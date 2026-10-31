import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../const/consts.dart';
import '../../core/network/api_error_handler.dart';
import '../../domain/data_source/product_remote_data_source.dart';
import '../../domain/entities/product_entity.dart';
import '../dto/product/product_dto.dart';
import '../dto/product/product_list_response_dto.dart';

part 'product_remote_data_source.g.dart';

@RestApi()
abstract class ProductApi {
  factory ProductApi(Dio dio) = _ProductApi;

  @GET(Endpoints.products)
  Future<ProductListResponseDto> getProducts({
    @Query('limit') required int limit,
    @Query('skip') required int skip,
  });

  @GET(Endpoints.productDetails)
  Future<ProductDto> getProductDetails(@Path('id') int id);
}

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  const ProductRemoteDataSourceImpl(this._api);

  final ProductApi _api;

  @override
  Future<ProductPageEntity> getProducts({
    required int limit,
    required int skip,
  }) => ApiErrorHandler.guard(
    () async => (await _api.getProducts(limit: limit, skip: skip)).toEntity(),
  );

  @override
  Future<ProductEntity> getProductDetails(int id) => ApiErrorHandler.guard(
    () async => (await _api.getProductDetails(id)).toEntity(),
  );
}
