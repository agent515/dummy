import 'package:dio/dio.dart';
import 'package:dummy/core/errors/app_exception.dart';
import 'package:dummy/core/network/api_error_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final options = RequestOptions(path: '/test');

  DioException badResponse(int statusCode, [Object? data]) => DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response(
      requestOptions: options,
      statusCode: statusCode,
      data: data,
    ),
  );

  group('fromDioException', () {
    test('maps timeouts', () {
      for (final type in [
        DioExceptionType.connectionTimeout,
        DioExceptionType.sendTimeout,
        DioExceptionType.receiveTimeout,
      ]) {
        expect(
          ApiErrorHandler.fromDioException(
            DioException(requestOptions: options, type: type),
          ),
          isA<RequestTimeoutException>(),
        );
      }
    });

    test('maps connection errors to NetworkException', () {
      expect(
        ApiErrorHandler.fromDioException(
          DioException.connectionError(requestOptions: options, reason: 'x'),
        ),
        isA<NetworkException>(),
      );
    });

    test('maps 401 to UnauthorizedException with the server message', () {
      expect(
        ApiErrorHandler.fromDioException(
          badResponse(401, {'message': 'Token Expired!'}),
        ),
        const UnauthorizedException('Token Expired!'),
      );
    });

    test('maps other statuses to ApiException with the server message', () {
      expect(
        ApiErrorHandler.fromDioException(
          badResponse(400, {'message': 'Invalid credentials'}),
        ),
        const ApiException('Invalid credentials', statusCode: 400),
      );
    });

    test('falls back to a generic message when the body has none', () {
      expect(
        ApiErrorHandler.fromDioException(badResponse(502, '<html>')),
        isA<ApiException>().having((e) => e.statusCode, 'statusCode', 502),
      );
    });

    test('keeps an AppException already attached by an interceptor', () {
      final error = badResponse(
        401,
      ).copyWith(error: const UnauthorizedException());
      expect(
        ApiErrorHandler.fromDioException(error),
        const UnauthorizedException(),
      );
    });
  });

  group('guard', () {
    test('returns the result on success', () async {
      expect(await ApiErrorHandler.guard(() async => 42), 42);
    });

    test('converts DioExceptions', () {
      expect(
        ApiErrorHandler.guard<void>(() async => throw badResponse(404)),
        throwsA(isA<ApiException>()),
      );
    });

    test('converts parsing errors to UnknownException', () {
      expect(
        ApiErrorHandler.guard<int>(
          () async => (<String, dynamic>{})['id'] as int,
        ),
        throwsA(isA<UnknownException>()),
      );
    });
  });
}
