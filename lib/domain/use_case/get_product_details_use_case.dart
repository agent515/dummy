import 'package:injectable/injectable.dart';

import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

@injectable
class GetProductDetailsUseCase {
  const GetProductDetailsUseCase(this._repository);

  final ProductRepository _repository;

  Future<ProductEntity> call(int id) => _repository.getProductDetails(id);
}
