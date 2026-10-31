import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

typedef Responder = FutureOr<ResponseBody> Function(RequestOptions options);

/// In-memory [HttpClientAdapter] that answers by request path and records
/// every request it receives.
class FakeHttpAdapter implements HttpClientAdapter {
  final _responders = <String, Responder>{};
  final requests = <RequestOptions>[];

  void on(String path, Responder responder) => _responders[path] = responder;

  int countFor(String path) =>
      requests.where((request) => request.path == path).length;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final responder = _responders[options.path];
    if (responder == null) return jsonBody({'message': 'Not found'}, 404);
    return responder(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody jsonBody(Object data, [int statusCode = 200]) =>
    ResponseBody.fromString(
      jsonEncode(data),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

String? authHeaderOf(RequestOptions options) =>
    options.headers['Authorization'] as String?;
