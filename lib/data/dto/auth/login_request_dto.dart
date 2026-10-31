import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../const/consts.dart';

part 'login_request_dto.freezed.dart';
part 'login_request_dto.g.dart';

@Freezed(toStringOverride: false)
abstract class LoginRequestDto with _$LoginRequestDto {
  const factory LoginRequestDto({
    required String username,
    required String password,
    @Default(ApiConstants.tokenExpiresInMins) int expiresInMins,
  }) = _LoginRequestDto;

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);
}
