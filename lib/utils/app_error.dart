import '../core/errors/app_exception.dart';

extension AppErrorMessage on AppException {
  /// Copy suitable for showing to the user.
  String get userMessage => switch (this) {
    NetworkException() =>
      'No internet connection. Check your connection and try again.',
    RequestTimeoutException() =>
      'The server is taking too long to respond. Please try again.',
    UnauthorizedException() => 'Your session has expired. Please log in again.',
    // DummyJSON's messages are human-readable ("Invalid credentials").
    ApiException(:final statusCode)
        when statusCode != null && statusCode < 500 =>
      message,
    ApiException() => 'The server ran into a problem. Please try again later.',
    UnknownException() => 'Something went wrong. Please try again.',
  };
}
