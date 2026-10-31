import 'package:injectable/injectable.dart';

import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserEntity> call({
    required String username,
    required String password,
  }) => _repository.login(username: username.trim(), password: password);
}
