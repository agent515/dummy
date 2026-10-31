import 'package:injectable/injectable.dart';

import '../../domain/data_source/product_remote_data_source.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

/// Remote-only today; this is where a local cache would plug in.
@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<ProductPageEntity> getProducts({
    required int limit,
    required int skip,
  }) => _remoteDataSource.getProducts(limit: limit, skip: skip);

  @override
  Future<ProductEntity> getProductDetails(int id) =>
      _remoteDataSource.getProductDetails(id);
}
