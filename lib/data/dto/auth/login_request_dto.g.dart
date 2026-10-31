// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequestDto _$LoginRequestDtoFromJson(Map<String, dynamic> json) =>
    _LoginRequestDto(
      username: json['username'] as String,
      password: json['password'] as String,
      expiresInMins:
          (json['expiresInMins'] as num?)?.toInt() ??
          ApiConstants.tokenExpiresInMins,
    );

Map<String, dynamic> _$LoginRequestDtoToJson(_LoginRequestDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'expiresInMins': instance.expiresInMins,
    };
