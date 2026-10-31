import '../entities/product_entity.dart';

abstract interface class ProductRepository {
  Future<ProductPageEntity> getProducts({
    required int limit,
    required int skip,
  });

  Future<ProductEntity> getProductDetails(int id);
}
