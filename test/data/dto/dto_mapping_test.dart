import 'package:dummy/data/dto/auth/auth_response_dto.dart';
import 'package:dummy/data/dto/auth/login_request_dto.dart';
import 'package:dummy/data/dto/product/product_dto.dart';
import 'package:dummy/data/dto/product/product_list_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fixtures.dart';

void main() {
  group('ProductDto', () {
    test('parses an API product and maps it to an entity', () {
      final product = ProductDto.fromJson(productJson).toEntity();

      expect(product.id, 1);
      expect(product.title, 'Essence Mascara Lash Princess');
      expect(product.price, 9.99);
      expect(product.brand, 'Essence');
      expect(product.images, hasLength(1));
      expect(product.tags, ['beauty', 'mascara']);
      expect(product.reviews.single.reviewerName, 'Eleanor Collins');
      expect(
        product.reviews.single.date,
        DateTime.utc(2025, 4, 30, 9, 41, 2, 53),
      );
    });

    test('tolerates missing optional fields and integer prices', () {
      final product = ProductDto.fromJson({'id': 7, 'price': 5}).toEntity();

      expect(product.price, 5.0);
      expect(product.title, isEmpty);
      expect(product.brand, isNull);
      expect(product.reviews, isEmpty);
    });
  });

  test('ProductListResponseDto maps to a page entity', () {
    final page = ProductListResponseDto.fromJson({
      'products': [productJson],
      'total': 194,
      'skip': 0,
      'limit': 1,
    }).toEntity();

    expect(page.products.single.id, 1);
    expect(page.total, 194);
    expect(page.skip, 0);
  });

  test('AuthResponseDto maps user and tokens', () {
    final auth = AuthResponseDto.fromJson(loginResponseJson).toEntity();

    expect(auth.user.fullName, 'Emily Johnson');
    expect(auth.user.username, 'emilys');
    expect(auth.accessToken, 'access-token');
    expect(auth.refreshToken, 'refresh-token');
  });

  test('LoginRequestDto serialises the documented body', () {
    expect(
      const LoginRequestDto(
        username: 'emilys',
        password: 'emilyspass',
      ).toJson(),
      {'username': 'emilys', 'password': 'emilyspass', 'expiresInMins': 10},
    );
  });
}
