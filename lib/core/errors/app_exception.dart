import 'package:equatable/equatable.dart';

/// Errors surfaced from the data layer.
///
/// Everything below the presentation layer converts transport-level failures
/// (Dio, JSON parsing) into one of these, so blocs only ever handle
/// [AppException]s.
sealed class AppException extends Equatable implements Exception {
  const AppException(this.message);

  /// Technical description; may come straight from the API response.
  final String message;

  @override
  List<Object?> get props => [message];

  @override
  String toString() => '$runtimeType: $message';
}

/// The device couldn't reach the server.
final class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

/// The server didn't respond in time.
final class RequestTimeoutException extends AppException {
  const RequestTimeoutException([super.message = 'Request timed out']);
}

/// Credentials are missing, expired or were rejected and couldn't be refreshed.
final class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Session expired']);
}

/// The server responded with a non-auth error status (4xx/5xx).
final class ApiException extends AppException {
  const ApiException(super.message, {this.statusCode});

  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// Anything else, including responses that couldn't be parsed.
final class UnknownException extends AppException {
  const UnknownException([super.message = 'Something went wrong']);
}
