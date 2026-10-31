part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched once on app start.
final class AuthSessionRestoreRequested extends AuthEvent {
  const AuthSessionRestoreRequested();
}

final class AuthLoginSubmitted extends AuthEvent {
  const AuthLoginSubmitted({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object?> get props => [username, password];

  @override
  String toString() => 'AuthLoginSubmitted(username: $username)';
}

final class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

final class _AuthSessionExpired extends AuthEvent {
  const _AuthSessionExpired();
}
