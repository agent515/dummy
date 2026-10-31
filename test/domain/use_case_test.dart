import 'package:dummy/domain/repositories/auth_repository.dart';
import 'package:dummy/domain/repositories/product_repository.dart';
import 'package:dummy/domain/use_case/get_product_details_use_case.dart';
import 'package:dummy/domain/use_case/get_products_use_case.dart';
import 'package:dummy/domain/use_case/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fixtures.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockProductRepository extends Mock implements ProductRepository {}

void main() {
  test('LoginUseCase trims the username but not the password', () async {
    final repository = _MockAuthRepository();
    when(
      () => repository.login(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => testUser);

    await LoginUseCase(repository)(username: '  emilys ', password: ' pass ');

    verify(
      () => repository.login(username: 'emilys', password: ' pass '),
    ).called(1);
  });

  test('GetProductsUseCase forwards pagination parameters', () async {
    final repository = _MockProductRepository();
    final page = buildPage(skip: 20);
    when(
      () => repository.getProducts(limit: 20, skip: 20),
    ).thenAnswer((_) async => page);

    expect(await GetProductsUseCase(repository)(limit: 20, skip: 20), page);
  });

  test('GetProductDetailsUseCase loads by id', () async {
    final repository = _MockProductRepository();
    when(
      () => repository.getProductDetails(3),
    ).thenAnswer((_) async => buildProduct(3));

    expect((await GetProductDetailsUseCase(repository)(3)).id, 3);
  });
}
