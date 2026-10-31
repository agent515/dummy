import 'package:injectable/injectable.dart';

import '../../core/errors/app_exception.dart';
import '../../core/network/session_expiry_notifier.dart';
import '../../core/storage/token_storage.dart';
import '../../domain/data_source/auth_remote_data_source.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._remoteDataSource,
    this._tokenStorage,
    this._sessionExpiryNotifier,
  );

  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;
  final SessionExpiryNotifier _sessionExpiryNotifier;

  @override
  Future<UserEntity> login({
    required String username,
    required String password,
  }) async {
    final auth = await _remoteDataSource.login(
      username: username,
      password: password,
    );
    await _tokenStorage.saveTokens(
      accessToken: auth.accessToken,
      refreshToken: auth.refreshToken,
    );
    return auth.user;
  }

  @override
  Future<UserEntity?> restoreSession() async {
    if (!await _tokenStorage.hasSession()) return null;

    try {
      // Fetching the profile validates the token, refreshing it if needed.
      return await _remoteDataSource.getCurrentUser();
    } on UnauthorizedException {
      await _tokenStorage.clear();
      rethrow;
    }
  }

  @override
  Future<void> logout() => _tokenStorage.clear();

  @override
  Stream<void> get sessionExpired => _sessionExpiryNotifier.stream;
}
