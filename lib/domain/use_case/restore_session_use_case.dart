import 'package:injectable/injectable.dart';

import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class RestoreSessionUseCase {
  const RestoreSessionUseCase(this._repository);

  final AuthRepository _repository;

  /// See [AuthRepository.restoreSession].
  Future<UserEntity?> call() => _repository.restoreSession();
}
