import 'package:dummy/core/errors/app_exception.dart';
import 'package:dummy/core/network/session_expiry_notifier.dart';
import 'package:dummy/core/storage/token_storage.dart';
import 'package:dummy/data/repositories/auth_repository_impl.dart';
import 'package:dummy/domain/data_source/auth_remote_data_source.dart';
import 'package:dummy/domain/entities/auth_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fixtures.dart';

class _MockRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class _MockTokenStorage extends Mock implements TokenStorage {}

void main() {
  late _MockRemoteDataSource remote;
  late _MockTokenStorage tokenStorage;
  late AuthRepositoryImpl repository;

  setUp(() {
    remote = _MockRemoteDataSource();
    tokenStorage = _MockTokenStorage();
    repository = AuthRepositoryImpl(
      remote,
      tokenStorage,
      SessionExpiryNotifier(),
    );
    when(
      () => tokenStorage.saveTokens(
        accessToken: any(named: 'accessToken'),
        refreshToken: any(named: 'refreshToken'),
      ),
    ).thenAnswer((_) async {});
    when(() => tokenStorage.clear()).thenAnswer((_) async {});
  });

  test('login stores the issued tokens and returns the user', () async {
    when(
      () => remote.login(username: 'emilys', password: 'emilyspass'),
    ).thenAnswer(
      (_) async =>
          const AuthEntity(user: testUser, accessToken: 'a', refreshToken: 'r'),
    );

    final user = await repository.login(
      username: 'emilys',
      password: 'emilyspass',
    );

    expect(user, testUser);
    verify(
      () => tokenStorage.saveTokens(accessToken: 'a', refreshToken: 'r'),
    ).called(1);
  });

  test('login failure stores nothing', () async {
    when(
      () => remote.login(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenThrow(const ApiException('Invalid credentials', statusCode: 400));

    await expectLater(
      repository.login(username: 'emilys', password: 'wrong'),
      throwsA(isA<ApiException>()),
    );
    verifyNever(
      () => tokenStorage.saveTokens(
        accessToken: any(named: 'accessToken'),
        refreshToken: any(named: 'refreshToken'),
      ),
    );
  });

  group('restoreSession', () {
    test(
      'returns null without calling the API when no session is stored',
      () async {
        when(() => tokenStorage.hasSession()).thenAnswer((_) async => false);

        expect(await repository.restoreSession(), isNull);
        verifyNever(() => remote.getCurrentUser());
      },
    );

    test('returns the current user for a valid session', () async {
      when(() => tokenStorage.hasSession()).thenAnswer((_) async => true);
      when(() => remote.getCurrentUser()).thenAnswer((_) async => testUser);

      expect(await repository.restoreSession(), testUser);
    });

    test('clears the session and rethrows when it is unauthorized', () async {
      when(() => tokenStorage.hasSession()).thenAnswer((_) async => true);
      when(
        () => remote.getCurrentUser(),
      ).thenThrow(const UnauthorizedException());

      await expectLater(
        repository.restoreSession(),
        throwsA(isA<UnauthorizedException>()),
      );
      verify(() => tokenStorage.clear()).called(1);
    });

    test('keeps the session on transient errors', () async {
      when(() => tokenStorage.hasSession()).thenAnswer((_) async => true);
      when(() => remote.getCurrentUser()).thenThrow(const NetworkException());

      await expectLater(
        repository.restoreSession(),
        throwsA(isA<NetworkException>()),
      );
      verifyNever(() => tokenStorage.clear());
    });
  });
}
