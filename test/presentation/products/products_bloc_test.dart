import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dummy/core/errors/app_exception.dart';
import 'package:dummy/domain/entities/product_entity.dart';
import 'package:dummy/domain/use_case/get_products_use_case.dart';
import 'package:dummy/presentation/products/bloc/products_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fixtures.dart';

class _MockGetProductsUseCase extends Mock implements GetProductsUseCase {}

void main() {
  late _MockGetProductsUseCase getProducts;

  final firstPage = buildPage(skip: 0);
  final secondPage = buildPage(skip: 20);
  final loadedFirstPage = ProductsState(
    status: ProductsStatus.success,
    products: firstPage.products,
    total: 194,
  );

  setUp(() => getProducts = _MockGetProductsUseCase());

  void stubPage(int skip, Future<ProductPageEntity> Function() answer) => when(
    () => getProducts(limit: 20, skip: skip),
  ).thenAnswer((_) => answer());

  ProductsBloc buildBloc() => ProductsBloc(getProducts);

  group('initial load', () {
    blocTest<ProductsBloc, ProductsState>(
      'emits loading then the first page',
      setUp: () => stubPage(0, () async => firstPage),
      build: buildBloc,
      act: (bloc) => bloc.add(const ProductsStarted()),
      expect: () => [
        const ProductsState(status: ProductsStatus.loading),
        loadedFirstPage,
      ],
    );

    blocTest<ProductsBloc, ProductsState>(
      'emits failure with the error',
      setUp: () => stubPage(0, () async => throw const NetworkException()),
      build: buildBloc,
      act: (bloc) => bloc.add(const ProductsStarted()),
      expect: () => [
        const ProductsState(status: ProductsStatus.loading),
        const ProductsState(
          status: ProductsStatus.failure,
          error: NetworkException(),
        ),
      ],
    );

    blocTest<ProductsBloc, ProductsState>(
      'emits success with an empty list when there are no products',
      setUp: () =>
          stubPage(0, () async => buildPage(skip: 0, count: 0, total: 0)),
      build: buildBloc,
      act: (bloc) => bloc.add(const ProductsStarted()),
      skip: 1,
      expect: () => [
        isA<ProductsState>()
            .having((s) => s.status, 'status', ProductsStatus.success)
            .having((s) => s.products, 'products', isEmpty)
            .having((s) => s.hasReachedEnd, 'hasReachedEnd', isTrue),
      ],
    );
  });

  group('pagination', () {
    blocTest<ProductsBloc, ProductsState>(
      'appends the next page using the loaded count as skip',
      setUp: () => stubPage(20, () async => secondPage),
      build: buildBloc,
      seed: () => loadedFirstPage,
      act: (bloc) => bloc.add(const ProductsNextPageRequested()),
      expect: () => [
        loadedFirstPage.copyWith(isLoadingMore: true),
        loadedFirstPage.copyWith(
          products: [...firstPage.products, ...secondPage.products],
        ),
      ],
    );

    blocTest<ProductsBloc, ProductsState>(
      'drops duplicate requests while a page is loading',
      setUp: () => stubPage(20, () async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        return secondPage;
      }),
      build: buildBloc,
      seed: () => loadedFirstPage,
      act: (bloc) => bloc
        ..add(const ProductsNextPageRequested())
        ..add(const ProductsNextPageRequested())
        ..add(const ProductsNextPageRequested()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        verify(() => getProducts(limit: 20, skip: 20)).called(1);
        expect(bloc.state.products, hasLength(40));
      },
    );

    blocTest<ProductsBloc, ProductsState>(
      'does nothing once every product is loaded',
      build: buildBloc,
      seed: () => loadedFirstPage.copyWith(total: 20),
      act: (bloc) => bloc.add(const ProductsNextPageRequested()),
      expect: () => <ProductsState>[],
      verify: (_) => verifyNever(
        () => getProducts(
          limit: any(named: 'limit'),
          skip: any(named: 'skip'),
        ),
      ),
    );

    blocTest<ProductsBloc, ProductsState>(
      'stops when a page comes back empty despite the total',
      setUp: () => stubPage(20, () async => buildPage(skip: 20, count: 0)),
      build: buildBloc,
      seed: () => loadedFirstPage,
      act: (bloc) => bloc.add(const ProductsNextPageRequested()),
      verify: (bloc) {
        expect(bloc.state.total, 20);
        expect(bloc.state.hasReachedEnd, isTrue);
      },
    );

    blocTest<ProductsBloc, ProductsState>(
      'keeps loaded products when a page fails',
      setUp: () => stubPage(20, () async => throw const NetworkException()),
      build: buildBloc,
      seed: () => loadedFirstPage,
      act: (bloc) => bloc.add(const ProductsNextPageRequested()),
      expect: () => [
        loadedFirstPage.copyWith(isLoadingMore: true),
        loadedFirstPage.copyWith(loadMoreError: () => const NetworkException()),
      ],
    );

    blocTest<ProductsBloc, ProductsState>(
      'after a failed page, only an explicit retry requests it again',
      setUp: () => stubPage(20, () async => secondPage),
      build: buildBloc,
      seed: () => loadedFirstPage.copyWith(
        loadMoreError: () => const NetworkException(),
      ),
      act: (bloc) async {
        bloc.add(const ProductsNextPageRequested());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const ProductsNextPageRequested(isRetry: true));
      },
      verify: (bloc) {
        verify(() => getProducts(limit: 20, skip: 20)).called(1);
        expect(bloc.state.products, hasLength(40));
        expect(bloc.state.loadMoreError, isNull);
      },
    );
  });

  group('refresh', () {
    final refreshedPage = buildPage(skip: 0, total: 200);

    blocTest<ProductsBloc, ProductsState>(
      'replaces the list with the first page',
      setUp: () => stubPage(0, () async => refreshedPage),
      build: buildBloc,
      seed: () => loadedFirstPage.copyWith(
        products: [...firstPage.products, ...secondPage.products],
      ),
      act: (bloc) => bloc.add(const ProductsRefreshed()),
      skip: 1,
      expect: () => [
        ProductsState(
          status: ProductsStatus.success,
          products: refreshedPage.products,
          total: 200,
        ),
      ],
    );

    blocTest<ProductsBloc, ProductsState>(
      'keeps the current list and reports the error when it fails',
      setUp: () =>
          stubPage(0, () async => throw const RequestTimeoutException()),
      build: buildBloc,
      seed: () => loadedFirstPage,
      act: (bloc) => bloc.add(const ProductsRefreshed()),
      expect: () => [
        loadedFirstPage.copyWith(isRefreshing: true),
        loadedFirstPage.copyWith(error: () => const RequestTimeoutException()),
      ],
    );

    final pendingPage = Completer<ProductPageEntity>();
    blocTest<ProductsBloc, ProductsState>(
      'discards a next page that resolves after a refresh',
      setUp: () {
        stubPage(20, () => pendingPage.future);
        stubPage(0, () async => refreshedPage);
      },
      build: buildBloc,
      seed: () => loadedFirstPage,
      act: (bloc) async {
        bloc.add(const ProductsNextPageRequested());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const ProductsRefreshed());
        await Future<void>.delayed(Duration.zero);
        pendingPage.complete(secondPage);
      },
      verify: (bloc) {
        expect(bloc.state.products, refreshedPage.products);
        expect(bloc.state.isLoadingMore, isFalse);
      },
    );
  });
}
