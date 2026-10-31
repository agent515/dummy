import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/auth_entity.dart';

part 'auth_response_dto.freezed.dart';
part 'auth_response_dto.g.dart';

/// `POST /auth/login` response: the user's profile plus the token pair.
@Freezed(toStringOverride: false)
abstract class AuthResponseDto with _$AuthResponseDto {
  const factory AuthResponseDto({
    required int id,
    required String username,
    required String accessToken,
    required String refreshToken,
    @Default('') String email,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String image,
  }) = _AuthResponseDto;

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);
}

extension AuthResponseDtoMapper on AuthResponseDto {
  AuthEntity toEntity() => AuthEntity(
    user: UserEntity(
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      image: image,
    ),
    accessToken: accessToken,
    refreshToken: refreshToken,
  );
}
