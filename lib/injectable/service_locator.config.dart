// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:dummy/core/network/auth_interceptor.dart' as _i972;
import 'package:dummy/core/network/session_expiry_notifier.dart' as _i1011;
import 'package:dummy/core/storage/token_storage.dart' as _i320;
import 'package:dummy/data/data_source/auth_remote_data_source.dart' as _i622;
import 'package:dummy/data/data_source/product_remote_data_source.dart'
    as _i872;
import 'package:dummy/data/repositories/auth_repository_impl.dart' as _i550;
import 'package:dummy/data/repositories/product_repository_impl.dart' as _i481;
import 'package:dummy/domain/data_source/auth_remote_data_source.dart' as _i53;
import 'package:dummy/domain/data_source/product_remote_data_source.dart'
    as _i186;
import 'package:dummy/domain/repositories/auth_repository.dart' as _i609;
import 'package:dummy/domain/repositories/product_repository.dart' as _i848;
import 'package:dummy/domain/use_case/get_product_details_use_case.dart'
    as _i653;
import 'package:dummy/domain/use_case/get_products_use_case.dart' as _i691;
import 'package:dummy/domain/use_case/login_use_case.dart' as _i41;
import 'package:dummy/domain/use_case/logout_use_case.dart' as _i656;
import 'package:dummy/domain/use_case/restore_session_use_case.dart' as _i744;
import 'package:dummy/injectable/modules/debug_module.dart' as _i833;
import 'package:dummy/injectable/modules/network_module.dart' as _i118;
import 'package:dummy/injectable/modules/storage_module.dart' as _i692;
import 'package:dummy/presentation/auth/bloc/auth_bloc.dart' as _i1006;
import 'package:dummy/presentation/products/bloc/product_details_bloc.dart'
    as _i468;
import 'package:dummy/presentation/products/bloc/products_bloc.dart' as _i560;
import 'package:dummy/utils/app_router.dart' as _i467;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logarte/logarte.dart' as _i855;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final debugModule = _$DebugModule();
    final storageModule = _$StorageModule();
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i1011.SessionExpiryNotifier>(
      () => _i1011.SessionExpiryNotifier(),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i855.Logarte>(() => debugModule.logarte);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.secureStorage,
    );
    gh.lazySingleton<_i320.TokenStorage>(
      () => _i320.TokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.plainDio(gh<_i855.Logarte>()),
      instanceName: 'plainDio',
    );
    gh.lazySingleton<_i972.AuthInterceptor>(
      () => _i972.AuthInterceptor(
        gh<_i320.TokenStorage>(),
        gh<_i361.Dio>(instanceName: 'plainDio'),
        gh<_i1011.SessionExpiryNotifier>(),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(gh<_i972.AuthInterceptor>(), gh<_i855.Logarte>()),
    );
    gh.lazySingleton<_i622.AuthApi>(
      () => networkModule.authApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i872.ProductApi>(
      () => networkModule.productApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i53.AuthRemoteDataSource>(
      () => _i622.AuthRemoteDataSourceImpl(gh<_i622.AuthApi>()),
    );
    gh.lazySingleton<_i186.ProductRemoteDataSource>(
      () => _i872.ProductRemoteDataSourceImpl(gh<_i872.ProductApi>()),
    );
    gh.lazySingleton<_i609.AuthRepository>(
      () => _i550.AuthRepositoryImpl(
        gh<_i53.AuthRemoteDataSource>(),
        gh<_i320.TokenStorage>(),
        gh<_i1011.SessionExpiryNotifier>(),
      ),
    );
    gh.lazySingleton<_i848.ProductRepository>(
      () => _i481.ProductRepositoryImpl(gh<_i186.ProductRemoteDataSource>()),
    );
    gh.factory<_i41.LoginUseCase>(
      () => _i41.LoginUseCase(gh<_i609.AuthRepository>()),
    );
    gh.factory<_i656.LogoutUseCase>(
      () => _i656.LogoutUseCase(gh<_i609.AuthRepository>()),
    );
    gh.factory<_i744.RestoreSessionUseCase>(
      () => _i744.RestoreSessionUseCase(gh<_i609.AuthRepository>()),
    );
    gh.lazySingleton<_i1006.AuthBloc>(
      () => _i1006.AuthBloc(
        gh<_i41.LoginUseCase>(),
        gh<_i744.RestoreSessionUseCase>(),
        gh<_i656.LogoutUseCase>(),
        gh<_i609.AuthRepository>(),
      ),
    );
    gh.lazySingleton<_i467.AppRouter>(
      () => _i467.AppRouter(gh<_i1006.AuthBloc>()),
    );
    gh.factory<_i653.GetProductDetailsUseCase>(
      () => _i653.GetProductDetailsUseCase(gh<_i848.ProductRepository>()),
    );
    gh.factory<_i691.GetProductsUseCase>(
      () => _i691.GetProductsUseCase(gh<_i848.ProductRepository>()),
    );
    gh.factory<_i468.ProductDetailsBloc>(
      () => _i468.ProductDetailsBloc(gh<_i653.GetProductDetailsUseCase>()),
    );
    gh.factory<_i560.ProductsBloc>(
      () => _i560.ProductsBloc(gh<_i691.GetProductsUseCase>()),
    );
    return this;
  }
}

class _$DebugModule extends _i833.DebugModule {}

class _$StorageModule extends _i692.StorageModule {}

class _$NetworkModule extends _i118.NetworkModule {}
