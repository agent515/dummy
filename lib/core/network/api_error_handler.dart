import 'package:dio/dio.dart';

import '../errors/app_exception.dart';

abstract final class ApiErrorHandler {
  /// Runs [request] and converts any failure into an [AppException].
  static Future<T> guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw fromDioException(e);
    } on FormatException {
      throw const UnknownException('Unexpected response from server');
    } on TypeError {
      // json_serializable throws TypeErrors for missing/mistyped fields.
      throw const UnknownException('Unexpected response from server');
    }
  }

  static AppException fromDioException(DioException e) {
    // Interceptors may already have decided what went wrong.
    if (e.error case final AppException error) return error;

    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.transformTimeout => const RequestTimeoutException(),
      DioExceptionType.connectionError => const NetworkException(),
      DioExceptionType.badResponse => _fromResponse(e.response),
      DioExceptionType.badCertificate => const NetworkException(
        'Could not establish a secure connection',
      ),
      DioExceptionType.cancel => const UnknownException('Request cancelled'),
      DioExceptionType.unknown => UnknownException(
        e.message ?? 'Something went wrong',
      ),
    };
  }

  static AppException _fromResponse(Response<dynamic>? response) {
    final statusCode = response?.statusCode;
    final message = _messageFrom(response?.data);

    if (statusCode == 401) {
      return UnauthorizedException(message ?? 'Session expired');
    }
    return ApiException(
      message ?? 'Request failed with status $statusCode',
      statusCode: statusCode,
    );
  }

  /// DummyJSON reports errors as `{"message": "..."}`.
  static String? _messageFrom(Object? data) => switch (data) {
    {'message': final String message} when message.isNotEmpty => message,
    _ => null,
  };
}
