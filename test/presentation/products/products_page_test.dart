import 'package:bloc_test/bloc_test.dart';
import 'package:dummy/core/errors/app_exception.dart';
import 'package:dummy/injectable/service_locator.dart';
import 'package:dummy/presentation/auth/bloc/auth_bloc.dart';
import 'package:dummy/presentation/products/bloc/products_bloc.dart';
import 'package:dummy/presentation/products/products_page.dart';
import 'package:dummy/presentation/products/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fixtures.dart';

class _MockProductsBloc extends MockBloc<ProductsEvent, ProductsState>
    implements ProductsBloc {}

class _MockAuthBloc extends MockBloc<AuthEvent, AuthState>
    implements AuthBloc {}

void main() {
  late _MockProductsBloc productsBloc;
  late _MockAuthBloc authBloc;

  setUp(() {
    productsBloc = _MockProductsBloc();
    authBloc = _MockAuthBloc();
    when(
      () => authBloc.state,
    ).thenReturn(const AuthAuthenticated(user: testUser));
    getIt.registerFactory<ProductsBloc>(() => productsBloc);
  });

  tearDown(getIt.reset);

  Future<void> pumpPage(WidgetTester tester, ProductsState state) {
    when(() => productsBloc.state).thenReturn(state);
    return tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: authBloc,
          child: const ProductsPage(),
        ),
      ),
    );
  }

  testWidgets('requests the first page on open', (tester) async {
    await pumpPage(tester, const ProductsState());

    verify(() => productsBloc.add(const ProductsStarted())).called(1);
  });

  testWidgets('shows skeletons while loading', (tester) async {
    await pumpPage(tester, const ProductsState(status: ProductsStatus.loading));

    expect(find.byType(ProductCardSkeleton), findsWidgets);
    expect(find.byType(ProductCard), findsNothing);
  });

  testWidgets('shows the error with a retry action', (tester) async {
    await pumpPage(
      tester,
      const ProductsState(
        status: ProductsStatus.failure,
        error: NetworkException(),
      ),
    );

    expect(find.text("You're offline"), findsOneWidget);
    await tester.tap(find.text('Try again'));
    verify(() => productsBloc.add(const ProductsStarted())).called(2);
  });

  testWidgets('shows an empty state', (tester) async {
    await pumpPage(tester, const ProductsState(status: ProductsStatus.success));

    expect(find.text('No products yet'), findsOneWidget);
  });

  testWidgets('renders products and the end-of-list footer', (tester) async {
    final page = buildPage(skip: 0, count: 2, total: 2);
    await pumpPage(
      tester,
      ProductsState(
        status: ProductsStatus.success,
        products: page.products,
        total: 2,
      ),
    );

    expect(find.byType(ProductCard), findsNWidgets(2));
    expect(find.text('Product 1'), findsOneWidget);
    expect(find.text("You've seen all 2 products"), findsOneWidget);
  });

  testWidgets('offers a retry when the next page fails', (tester) async {
    final page = buildPage(skip: 0, count: 2, total: 50);
    await pumpPage(
      tester,
      ProductsState(
        status: ProductsStatus.success,
        products: page.products,
        total: 50,
        loadMoreError: const NetworkException(),
      ),
    );

    await tester.tap(find.text('Retry'));
    verify(
      () => productsBloc.add(const ProductsNextPageRequested(isRetry: true)),
    ).called(1);
  });
}
