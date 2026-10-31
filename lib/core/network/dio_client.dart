import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logarte/logarte.dart';

import '../../const/consts.dart';

/// Builds [Dio] instances that share the same base configuration.
abstract final class DioClient {
  /// Name of the [Dio] registered without auth handling. Used for token
  /// refresh and for retrying requests after a refresh, so neither can
  /// re-enter the auth interceptor.
  static const plainDioName = 'plainDio';

  static Dio create({
    required Logarte logarte,
    List<Interceptor> interceptors = const [],
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {Headers.acceptHeader: Headers.jsonContentType},
      ),
    );

    dio.interceptors.addAll([
      ...interceptors,
      // Headers and bodies are left out: they carry tokens and passwords.
      if (kDebugMode)
        LogInterceptor(
          requestHeader: false,
          requestBody: false,
          responseHeader: false,
          responseBody: false,
          logPrint: (line) => debugPrint(line.toString()),
        ),
      // Keeps full requests and responses in memory for the in-app console;
      // nothing is printed.
      LogarteDioInterceptor(logarte),
    ]);
    return dio;
  }
}
