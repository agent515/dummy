import 'package:dummy/core/storage/token_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  test('has no session until tokens are saved', () async {
    final storage = TokenStorage(const FlutterSecureStorage());

    expect(await storage.hasSession(), isFalse);
    expect(await storage.readAccessToken(), isNull);
  });

  test('persists tokens across instances', () async {
    await TokenStorage(
      const FlutterSecureStorage(),
    ).saveTokens(accessToken: 'access', refreshToken: 'refresh');

    final restored = TokenStorage(const FlutterSecureStorage());
    expect(await restored.hasSession(), isTrue);
    expect(await restored.readAccessToken(), 'access');
    expect(await restored.readRefreshToken(), 'refresh');
  });

  test('clear removes both tokens', () async {
    final storage = TokenStorage(const FlutterSecureStorage());
    await storage.saveTokens(accessToken: 'access', refreshToken: 'refresh');

    await storage.clear();

    expect(await storage.hasSession(), isFalse);
    expect(await storage.readAccessToken(), isNull);
    expect(
      await TokenStorage(const FlutterSecureStorage()).readAccessToken(),
      isNull,
    );
  });
}
