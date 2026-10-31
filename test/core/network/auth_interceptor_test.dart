import 'package:dio/dio.dart';
import 'package:dummy/const/consts.dart';
import 'package:dummy/core/errors/app_exception.dart';
import 'package:dummy/core/network/auth_interceptor.dart';
import 'package:dummy/core/network/session_expiry_notifier.dart';
import 'package:dummy/core/storage/token_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';

void main() {
  late FakeHttpAdapter adapter;
  late TokenStorage tokenStorage;
  late SessionExpiryNotifier notifier;
  late Dio dio;
  late int expiryNotifications;

  Dio buildDio() =>
      Dio(BaseOptions(baseUrl: 'https://test.local'))
        ..httpClientAdapter = adapter;

  setUp(() async {
    FlutterSecureStorage.setMockInitialValues({});
    adapter = FakeHttpAdapter();
    tokenStorage = TokenStorage(const FlutterSecureStorage());
    notifier = SessionExpiryNotifier();
    expiryNotifications = 0;
    notifier.stream.listen((_) => expiryNotifications++);

    dio = buildDio()
      ..interceptors.add(AuthInterceptor(tokenStorage, buildDio(), notifier));

    await tokenStorage.saveTokens(accessToken: 'old', refreshToken: 'refresh');
  });

  /// `/auth/me` that only accepts the `new` access token.
  void acceptOnlyNewToken() => adapter.on(
    Endpoints.currentUser,
    (options) => authHeaderOf(options) == 'Bearer new'
        ? jsonBody({'id': 1})
        : jsonBody({'message': 'Token Expired!'}, 401),
  );

  void refreshSucceeds() => adapter.on(Endpoints.refresh, (_) async {
    await Future<void>.delayed(const Duration(milliseconds: 20));
    return jsonBody({'accessToken': 'new', 'refreshToken': 'refresh-2'});
  });

  test('attaches the stored access token', () async {
    adapter.on(Endpoints.products, (_) => jsonBody({'products': []}));

    await dio.get<void>(Endpoints.products);

    expect(authHeaderOf(adapter.requests.single), 'Bearer old');
  });

  test('does not attach a token to requests marked skipAuth', () async {
    adapter.on(Endpoints.login, (_) => jsonBody({}));

    await dio.post<void>(
      Endpoints.login,
      options: Options(extra: {AuthInterceptor.skipAuthKey: true}),
    );

    expect(authHeaderOf(adapter.requests.single), isNull);
  });

  test('refreshes on 401, retries with the new token and stores it', () async {
    acceptOnlyNewToken();
    refreshSucceeds();

    final response = await dio.get<Map<String, dynamic>>(Endpoints.currentUser);

    expect(response.statusCode, 200);
    expect(adapter.countFor(Endpoints.refresh), 1);
    expect(authHeaderOf(adapter.requests.last), 'Bearer new');
    expect(await tokenStorage.readAccessToken(), 'new');
    expect(await tokenStorage.readRefreshToken(), 'refresh-2');
    expect(adapter.requests[1].data, {
      'refreshToken': 'refresh',
      'expiresInMins': ApiConstants.tokenExpiresInMins,
    });
  });

  test('refreshes once for concurrent 401s', () async {
    acceptOnlyNewToken();
    refreshSucceeds();

    final responses = await Future.wait([
      for (var i = 0; i < 3; i++) dio.get<void>(Endpoints.currentUser),
    ]);

    expect(responses.map((r) => r.statusCode), everyElement(200));
    expect(adapter.countFor(Endpoints.refresh), 1);
  });

  test('a rejected refresh clears the session and notifies', () async {
    acceptOnlyNewToken();
    adapter.on(
      Endpoints.refresh,
      (_) => jsonBody({'message': 'Invalid refresh token'}, 403),
    );

    await expectLater(
      dio.get<void>(Endpoints.currentUser),
      throwsA(
        isA<DioException>().having(
          (e) => e.error,
          'error',
          isA<UnauthorizedException>(),
        ),
      ),
    );
    expect(await tokenStorage.hasSession(), isFalse);
    expect(await tokenStorage.readAccessToken(), isNull);
    expect(expiryNotifications, 1);
  });

  test('a refresh that fails transiently keeps the session', () async {
    acceptOnlyNewToken();
    adapter.on(
      Endpoints.refresh,
      (options) => throw DioException.connectionError(
        requestOptions: options,
        reason: 'offline',
      ),
    );

    await expectLater(
      dio.get<void>(Endpoints.currentUser),
      throwsA(isA<DioException>()),
    );
    expect(await tokenStorage.hasSession(), isTrue);
    expect(expiryNotifications, 0);
  });

  test('without a refresh token the session ends without a refresh', () async {
    await tokenStorage.clear();
    acceptOnlyNewToken();

    await expectLater(
      dio.get<void>(Endpoints.currentUser),
      throwsA(isA<DioException>()),
    );
    expect(adapter.countFor(Endpoints.refresh), 0);
    expect(expiryNotifications, 1);
  });

  test('a 401 on a skipAuth request is not refreshed', () async {
    adapter.on(
      Endpoints.login,
      (_) => jsonBody({'message': 'Unauthorized'}, 401),
    );

    await expectLater(
      dio.post<void>(
        Endpoints.login,
        options: Options(extra: {AuthInterceptor.skipAuthKey: true}),
      ),
      throwsA(isA<DioException>()),
    );
    expect(adapter.countFor(Endpoints.refresh), 0);
    expect(expiryNotifications, 0);
  });

  test('non-401 errors pass through untouched', () async {
    adapter.on(Endpoints.products, (_) => jsonBody({'message': 'boom'}, 500));

    await expectLater(
      dio.get<void>(Endpoints.products),
      throwsA(
        isA<DioException>().having(
          (e) => e.response?.statusCode,
          'status',
          500,
        ),
      ),
    );
    expect(adapter.countFor(Endpoints.refresh), 0);
  });
}
