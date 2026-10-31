import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/auth_entity.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

/// `GET /auth/me` response. Only the fields the app uses are mapped.
@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    required int id,
    required String username,
    @Default('') String email,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String image,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

extension UserDtoMapper on UserDto {
  UserEntity toEntity() => UserEntity(
    id: id,
    username: username,
    email: email,
    firstName: firstName,
    lastName: lastName,
    image: image,
  );
}
