import 'package:injectable/injectable.dart';

import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

@injectable
class GetProductsUseCase {
  const GetProductsUseCase(this._repository);

  final ProductRepository _repository;

  Future<ProductPageEntity> call({required int limit, required int skip}) =>
      _repository.getProducts(limit: limit, skip: skip);
}
