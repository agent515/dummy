import '../entities/product_entity.dart';

/// Remote product operations. Implementations throw [AppException]s.
abstract interface class ProductRemoteDataSource {
  Future<ProductPageEntity> getProducts({
    required int limit,
    required int skip,
  });

  Future<ProductEntity> getProductDetails(int id);
}
