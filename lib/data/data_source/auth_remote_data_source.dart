import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../const/consts.dart';
import '../../core/network/api_error_handler.dart';
import '../../core/network/auth_interceptor.dart';
import '../../domain/data_source/auth_remote_data_source.dart';
import '../../domain/entities/auth_entity.dart';
import '../dto/auth/auth_response_dto.dart';
import '../dto/auth/login_request_dto.dart';
import '../dto/auth/user_dto.dart';

part 'auth_remote_data_source.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST(Endpoints.login)
  @Extra({AuthInterceptor.skipAuthKey: true})
  Future<AuthResponseDto> login(@Body() LoginRequestDto request);

  @GET(Endpoints.currentUser)
  Future<UserDto> getCurrentUser();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._api);

  final AuthApi _api;

  @override
  Future<AuthEntity> login({
    required String username,
    required String password,
  }) => ApiErrorHandler.guard(() async {
    final response = await _api.login(
      LoginRequestDto(username: username, password: password),
    );
    return response.toEntity();
  });

  @override
  Future<UserEntity> getCurrentUser() => ApiErrorHandler.guard(
    () async => (await _api.getCurrentUser()).toEntity(),
  );
}
