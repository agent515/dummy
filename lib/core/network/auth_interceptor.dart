import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../const/consts.dart';
import '../errors/app_exception.dart';
import '../storage/token_storage.dart';
import 'dio_client.dart';
import 'session_expiry_notifier.dart';

/// Attaches the bearer token to requests and, on a 401, refreshes the token
/// pair and retries the request once.
///
/// As a [QueuedInterceptor], callbacks run one at a time, so 401s that arrive
/// while a refresh is in flight wait for it. This is the only class that
/// knows about token refresh; it's wired up in `NetworkModule` and can be
/// replaced there without touching anything else.
@lazySingleton
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor(
    this._tokenStorage,
    @Named(DioClient.plainDioName) this._plainDio,
    this._sessionExpiryNotifier,
  );

  /// Set to `true` in [RequestOptions.extra] for requests that must neither
  /// carry a token nor trigger a refresh (login).
  static const skipAuthKey = 'skipAuth';

  static const _authHeader = 'Authorization';

  final TokenStorage _tokenStorage;

  /// Has no auth interceptor, so refresh and retry requests can't recurse
  /// into this one or deadlock behind the error queue.
  final Dio _plainDio;
  final SessionExpiryNotifier _sessionExpiryNotifier;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[skipAuthKey] != true) {
      try {
        final token = await _tokenStorage.readAccessToken();
        if (token != null) options.headers[_authHeader] = _bearer(token);
      } catch (_) {
        // Send unauthenticated; a 401 will route through onError.
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401 ||
        err.requestOptions.extra[skipAuthKey] == true) {
      return handler.next(err);
    }

    try {
      final accessToken = await _recoverAccessToken(err.requestOptions);
      if (accessToken == null) return handler.next(await _endSession(err));

      handler.resolve(await _retry(err.requestOptions, accessToken));
    } on DioException catch (e) {
      handler.next(e);
    } catch (_) {
      handler.next(err);
    }
  }

  /// Returns an access token to retry [failed] with, or `null` when the
  /// session can't be recovered.
  Future<String?> _recoverAccessToken(RequestOptions failed) async {
    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null) return null;

    // A request queued behind a refresh failed with the old token; the
    // refresh already happened, so retry with the new one.
    final currentToken = await _tokenStorage.readAccessToken();
    if (currentToken != null &&
        failed.headers[_authHeader] != _bearer(currentToken)) {
      return currentToken;
    }

    try {
      final response = await _plainDio.post<Map<String, dynamic>>(
        Endpoints.refresh,
        data: {
          'refreshToken': refreshToken,
          'expiresInMins': ApiConstants.tokenExpiresInMins,
        },
      );
      final data = response.data!;
      final accessToken = data['accessToken'] as String;
      await _tokenStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: data['refreshToken'] as String,
      );
      return accessToken;
    } on DioException catch (e) {
      // A 4xx means the refresh token was rejected and the session is over.
      // Anything else (offline, 5xx) is transient: keep the session.
      final status = e.response?.statusCode;
      if (status != null && status >= 400 && status < 500) return null;
      rethrow;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions options, String token) =>
      _plainDio.fetch<dynamic>(
        options.copyWith(
          headers: {...options.headers, _authHeader: _bearer(token)},
        ),
      );

  Future<DioException> _endSession(DioException err) async {
    await _tokenStorage.clear();
    _sessionExpiryNotifier.notifyExpired();
    return err.copyWith(error: const UnauthorizedException());
  }

  static String _bearer(String token) => 'Bearer $token';
}
