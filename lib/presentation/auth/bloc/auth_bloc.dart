import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/app_exception.dart';
import '../../../domain/entities/auth_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/use_case/login_use_case.dart';
import '../../../domain/use_case/logout_use_case.dart';
import '../../../domain/use_case/restore_session_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// App-wide authentication state. Navigation reacts to it (see `App`).
@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._login,
    this._restoreSession,
    this._logout,
    AuthRepository authRepository,
  ) : super(const AuthInitial()) {
    on<AuthSessionRestoreRequested>(
      _onRestoreRequested,
      transformer: droppable(),
    );
    on<AuthLoginSubmitted>(_onLoginSubmitted, transformer: droppable());
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<_AuthSessionExpired>(_onSessionExpired);

    // Session expiry is an event stream rather than an operation, so it's
    // observed on the repository directly.
    _sessionExpiredSubscription = authRepository.sessionExpired.listen(
      (_) => add(const _AuthSessionExpired()),
    );
  }

  final LoginUseCase _login;
  final RestoreSessionUseCase _restoreSession;
  final LogoutUseCase _logout;
  late final StreamSubscription<void> _sessionExpiredSubscription;

  Future<void> _onRestoreRequested(
    AuthSessionRestoreRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = await _restoreSession();
      emit(
        user == null
            ? const AuthUnauthenticated()
            : AuthAuthenticated(user: user),
      );
    } on UnauthorizedException {
      emit(const AuthUnauthenticated(sessionExpired: true));
    } on AppException {
      // Tokens exist but couldn't be verified (offline, server down). Keep the
      // user signed in; any request that really needs auth will re-check.
      emit(const AuthAuthenticated());
    }
  }

  Future<void> _onLoginSubmitted(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoginInProgress());
    try {
      final user = await _login(
        username: event.username,
        password: event.password,
      );
      emit(AuthAuthenticated(user: user));
    } on AppException catch (error) {
      emit(AuthUnauthenticated(error: error));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    // Clearing local tokens can't meaningfully fail; sign out regardless.
    try {
      await _logout();
    } finally {
      emit(const AuthUnauthenticated());
    }
  }

  void _onSessionExpired(_AuthSessionExpired event, Emitter<AuthState> emit) {
    if (state is AuthAuthenticated) {
      emit(const AuthUnauthenticated(sessionExpired: true));
    }
  }

  @override
  Future<void> close() async {
    await _sessionExpiredSubscription.cancel();
    return super.close();
  }
}
