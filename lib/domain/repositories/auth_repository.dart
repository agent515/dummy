import '../entities/auth_entity.dart';

abstract interface class AuthRepository {
  /// Authenticates and persists the issued tokens.
  Future<UserEntity> login({
    required String username,
    required String password,
  });

  /// Validates the persisted session and returns its user, or `null` when no
  /// session is stored.
  ///
  /// Throws [UnauthorizedException] (after clearing the session) when the
  /// stored tokens are no longer valid, or another [AppException] when the
  /// session couldn't be verified, e.g. while offline.
  Future<UserEntity?> restoreSession();

  Future<void> logout();

  /// Emits whenever the session ends outside of an explicit [logout], e.g.
  /// when a token refresh is rejected.
  Stream<void> get sessionExpired;
}
