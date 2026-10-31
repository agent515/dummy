import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logarte/logarte.dart';

import '../../core/network/auth_interceptor.dart';
import '../../core/network/dio_client.dart';
import '../../data/data_source/auth_remote_data_source.dart';
import '../../data/data_source/product_remote_data_source.dart';

@module
abstract class NetworkModule {
  @Named(DioClient.plainDioName)
  @lazySingleton
  Dio plainDio(Logarte logarte) => DioClient.create(logarte: logarte);

  /// The app's main client. Swap [AuthInterceptor] here to change how
  /// authentication and token refresh are handled.
  @lazySingleton
  Dio dio(AuthInterceptor authInterceptor, Logarte logarte) =>
      DioClient.create(logarte: logarte, interceptors: [authInterceptor]);

  @lazySingleton
  AuthApi authApi(Dio dio) => AuthApi(dio);

  @lazySingleton
  ProductApi productApi(Dio dio) => ProductApi(dio);
}
