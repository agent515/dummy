import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const UserEntity._();

  const factory UserEntity({
    required int id,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String image,
  }) = _UserEntity;

  String get fullName => '$firstName $lastName'.trim();
}

/// Result of a successful login: the user plus the issued token pair.
// toString is not generated so tokens never end up in logs.
@Freezed(toStringOverride: false)
abstract class AuthEntity with _$AuthEntity {
  const factory AuthEntity({
    required UserEntity user,
    required String accessToken,
    required String refreshToken,
  }) = _AuthEntity;
}
