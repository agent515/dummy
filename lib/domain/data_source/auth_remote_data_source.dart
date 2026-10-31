import '../entities/auth_entity.dart';

/// Remote auth operations. Implementations throw [AppException]s.
abstract interface class AuthRemoteDataSource {
  Future<AuthEntity> login({
    required String username,
    required String password,
  });

  /// Profile of the user owning the current access token.
  Future<UserEntity> getCurrentUser();
}
