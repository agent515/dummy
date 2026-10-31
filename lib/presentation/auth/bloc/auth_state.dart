part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// The persisted session hasn't been checked yet.
final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated({this.error, this.sessionExpired = false});

  /// Why the last login attempt failed, if it did.
  final AppException? error;

  /// The user was signed out because their session could not be renewed.
  final bool sessionExpired;

  @override
  List<Object?> get props => [error, sessionExpired];
}

final class AuthLoginInProgress extends AuthState {
  const AuthLoginInProgress();
}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({this.user});

  /// `null` when a stored session was kept but the profile couldn't be
  /// fetched, e.g. when the app starts offline.
  final UserEntity? user;

  @override
  List<Object?> get props => [user];
}
