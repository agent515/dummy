abstract final class ApiConstants {
  static const baseUrl = 'https://dummyjson.com';

  static const connectTimeout = Duration(seconds: 15);
  static const sendTimeout = Duration(seconds: 15);
  static const receiveTimeout = Duration(seconds: 20);

  /// Lifetime requested for access tokens on login and refresh.
  static const tokenExpiresInMins = 30;

  static const productsPageSize = 20;
}

abstract final class Endpoints {
  static const login = '/auth/login';
  static const refresh = '/auth/refresh';
  static const currentUser = '/auth/me';
  static const products = '/products';
  static const productDetails = '/products/{id}';
}
