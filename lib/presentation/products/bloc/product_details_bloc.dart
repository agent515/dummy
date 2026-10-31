import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/app_exception.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/use_case/get_product_details_use_case.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

@injectable
class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc(this._getProductDetails)
    : super(const ProductDetailsLoading()) {
    on<ProductDetailsRequested>(_onRequested, transformer: restartable());
  }

  final GetProductDetailsUseCase _getProductDetails;

  Future<void> _onRequested(
    ProductDetailsRequested event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(const ProductDetailsLoading());
    try {
      emit(ProductDetailsLoaded(await _getProductDetails(event.productId)));
    } on AppException catch (error) {
      emit(ProductDetailsFailure(error));
    }
  }
}
