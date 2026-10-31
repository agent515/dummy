import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dummy/core/errors/app_exception.dart';
import 'package:dummy/domain/repositories/auth_repository.dart';
import 'package:dummy/domain/use_case/login_use_case.dart';
import 'package:dummy/domain/use_case/logout_use_case.dart';
import 'package:dummy/domain/use_case/restore_session_use_case.dart';
import 'package:dummy/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fixtures.dart';

class _MockLoginUseCase extends Mock implements LoginUseCase {}

class _MockRestoreSessionUseCase extends Mock
    implements RestoreSessionUseCase {}

class _MockLogoutUseCase extends Mock implements LogoutUseCase {}

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockLoginUseCase login;
  late _MockRestoreSessionUseCase restoreSession;
  late _MockLogoutUseCase logout;
  late _MockAuthRepository repository;
  late StreamController<void> sessionExpired;

  setUp(() {
    login = _MockLoginUseCase();
    restoreSession = _MockRestoreSessionUseCase();
    logout = _MockLogoutUseCase();
    repository = _MockAuthRepository();
    sessionExpired = StreamController<void>.broadcast();
    when(
      () => repository.sessionExpired,
    ).thenAnswer((_) => sessionExpired.stream);
    when(() => logout()).thenAnswer((_) async {});
  });

  tearDown(() => sessionExpired.close());

  AuthBloc buildBloc() => AuthBloc(login, restoreSession, logout, repository);

  group('session restore', () {
    blocTest<AuthBloc, AuthState>(
      'is unauthenticated when nothing is stored',
      setUp: () => when(() => restoreSession()).thenAnswer((_) async => null),
      build: buildBloc,
      act: (bloc) => bloc.add(const AuthSessionRestoreRequested()),
      expect: () => [const AuthUnauthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      'is authenticated with the restored user',
      setUp: () =>
          when(() => restoreSession()).thenAnswer((_) async => testUser),
      build: buildBloc,
      act: (bloc) => bloc.add(const AuthSessionRestoreRequested()),
      expect: () => [const AuthAuthenticated(user: testUser)],
    );

    blocTest<AuthBloc, AuthState>(
      'reports an expired session when the tokens are rejected',
      setUp: () =>
          when(() => restoreSession()).thenThrow(const UnauthorizedException()),
      build: buildBloc,
      act: (bloc) => bloc.add(const AuthSessionRestoreRequested()),
      expect: () => [const AuthUnauthenticated(sessionExpired: true)],
    );

    blocTest<AuthBloc, AuthState>(
      'stays signed in when the session cannot be verified offline',
      setUp: () =>
          when(() => restoreSession()).thenThrow(const NetworkException()),
      build: buildBloc,
      act: (bloc) => bloc.add(const AuthSessionRestoreRequested()),
      expect: () => [const AuthAuthenticated()],
    );
  });

  group('login', () {
    blocTest<AuthBloc, AuthState>(
      'emits progress then authenticated',
      setUp: () => when(
        () => login(username: 'emilys', password: 'emilyspass'),
      ).thenAnswer((_) async => testUser),
      build: buildBloc,
      act: (bloc) => bloc.add(
        const AuthLoginSubmitted(username: 'emilys', password: 'emilyspass'),
      ),
      expect: () => [
        const AuthLoginInProgress(),
        const AuthAuthenticated(user: testUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits the error on failure',
      setUp: () => when(
        () => login(
          username: any(named: 'username'),
          password: any(named: 'password'),
        ),
      ).thenThrow(const ApiException('Invalid credentials', statusCode: 400)),
      build: buildBloc,
      act: (bloc) => bloc.add(
        const AuthLoginSubmitted(username: 'emilys', password: 'wrong'),
      ),
      expect: () => [
        const AuthLoginInProgress(),
        const AuthUnauthenticated(
          error: ApiException('Invalid credentials', statusCode: 400),
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'ignores repeated submits while one is in flight',
      setUp: () =>
          when(
            () => login(
              username: any(named: 'username'),
              password: any(named: 'password'),
            ),
          ).thenAnswer(
            (_) => Future.delayed(
              const Duration(milliseconds: 10),
              () => testUser,
            ),
          ),
      build: buildBloc,
      act: (bloc) => bloc
        ..add(const AuthLoginSubmitted(username: 'emilys', password: 'p'))
        ..add(const AuthLoginSubmitted(username: 'emilys', password: 'p')),
      wait: const Duration(milliseconds: 30),
      expect: () => [
        const AuthLoginInProgress(),
        const AuthAuthenticated(user: testUser),
      ],
      verify: (_) => verify(
        () => login(
          username: any(named: 'username'),
          password: any(named: 'password'),
        ),
      ).called(1),
    );
  });

  blocTest<AuthBloc, AuthState>(
    'logout clears the session',
    build: buildBloc,
    seed: () => const AuthAuthenticated(user: testUser),
    act: (bloc) => bloc.add(const AuthLogoutRequested()),
    expect: () => [const AuthUnauthenticated()],
    verify: (_) => verify(() => logout()).called(1),
  );

  blocTest<AuthBloc, AuthState>(
    'signs out when the network layer reports an expired session',
    build: buildBloc,
    seed: () => const AuthAuthenticated(user: testUser),
    act: (_) => sessionExpired.add(null),
    expect: () => [const AuthUnauthenticated(sessionExpired: true)],
  );
}
