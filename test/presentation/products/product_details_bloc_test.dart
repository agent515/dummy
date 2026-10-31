import 'package:bloc_test/bloc_test.dart';
import 'package:dummy/core/errors/app_exception.dart';
import 'package:dummy/domain/use_case/get_product_details_use_case.dart';
import 'package:dummy/presentation/products/bloc/product_details_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fixtures.dart';

class _MockGetProductDetailsUseCase extends Mock
    implements GetProductDetailsUseCase {}

void main() {
  late _MockGetProductDetailsUseCase getProductDetails;

  setUp(() => getProductDetails = _MockGetProductDetailsUseCase());

  blocTest<ProductDetailsBloc, ProductDetailsState>(
    'loads the requested product',
    setUp: () => when(
      () => getProductDetails(5),
    ).thenAnswer((_) async => buildProduct(5)),
    build: () => ProductDetailsBloc(getProductDetails),
    act: (bloc) => bloc.add(const ProductDetailsRequested(5)),
    expect: () => [
      const ProductDetailsLoading(),
      ProductDetailsLoaded(buildProduct(5)),
    ],
  );

  blocTest<ProductDetailsBloc, ProductDetailsState>(
    'emits failure, and recovers on retry',
    setUp: () {
      var attempts = 0;
      when(() => getProductDetails(5)).thenAnswer((_) async {
        if (attempts++ == 0) throw const NetworkException();
        return buildProduct(5);
      });
    },
    build: () => ProductDetailsBloc(getProductDetails),
    act: (bloc) async {
      bloc.add(const ProductDetailsRequested(5));
      await Future<void>.delayed(Duration.zero);
      bloc.add(const ProductDetailsRequested(5));
    },
    expect: () => [
      const ProductDetailsLoading(),
      const ProductDetailsFailure(NetworkException()),
      const ProductDetailsLoading(),
      ProductDetailsLoaded(buildProduct(5)),
    ],
  );
}
