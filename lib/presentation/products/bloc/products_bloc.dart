import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../const/consts.dart';
import '../../../core/errors/app_exception.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/use_case/get_products_use_case.dart';

part 'products_event.dart';
part 'products_state.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(this._getProducts) : super(const ProductsState()) {
    on<ProductsStarted>(_onStarted, transformer: restartable());
    on<ProductsRefreshed>(_onRefreshed, transformer: droppable());
    on<ProductsNextPageRequested>(
      _onNextPageRequested,
      transformer: droppable(),
    );
  }

  final GetProductsUseCase _getProducts;

  /// Bumped whenever the list is reset, so a page request that started
  /// before the reset can recognise its result as stale.
  int _generation = 0;

  Future<void> _onStarted(
    ProductsStarted event,
    Emitter<ProductsState> emit,
  ) async {
    final generation = ++_generation;
    emit(const ProductsState(status: ProductsStatus.loading));
    try {
      final page = await _fetchPage(skip: 0);
      if (generation != _generation) return;
      emit(
        ProductsState(
          status: ProductsStatus.success,
          products: page.products,
          total: page.total,
        ),
      );
    } on AppException catch (error) {
      if (generation != _generation) return;
      emit(ProductsState(status: ProductsStatus.failure, error: error));
    }
  }

  Future<void> _onRefreshed(
    ProductsRefreshed event,
    Emitter<ProductsState> emit,
  ) async {
    if (state.status == ProductsStatus.loading) return;

    final generation = ++_generation;
    emit(
      state.copyWith(
        isRefreshing: true,
        isLoadingMore: false,
        error: () => null,
      ),
    );
    try {
      final page = await _fetchPage(skip: 0);
      if (generation != _generation) return;
      emit(
        ProductsState(
          status: ProductsStatus.success,
          products: page.products,
          total: page.total,
        ),
      );
    } on AppException catch (error) {
      if (generation != _generation) return;
      // Keep what's on screen; only fall back to a full error with nothing
      // to show.
      emit(
        state.products.isEmpty
            ? ProductsState(status: ProductsStatus.failure, error: error)
            : state.copyWith(isRefreshing: false, error: () => error),
      );
    }
  }

  Future<void> _onNextPageRequested(
    ProductsNextPageRequested event,
    Emitter<ProductsState> emit,
  ) async {
    // Concurrent requests are dropped by the transformer; these cover the
    // states where paginating makes no sense.
    final blockedByError = state.loadMoreError != null && !event.isRetry;
    if (state.status != ProductsStatus.success ||
        state.isRefreshing ||
        state.hasReachedEnd ||
        blockedByError) {
      return;
    }

    final generation = _generation;
    emit(state.copyWith(isLoadingMore: true, loadMoreError: () => null));
    try {
      final page = await _fetchPage(skip: state.products.length);
      if (generation != _generation) return;
      final products = [...state.products, ...page.products];
      emit(
        state.copyWith(
          products: products,
          // An empty page means the reported total was off; stop paginating.
          total: page.products.isEmpty ? products.length : page.total,
          isLoadingMore: false,
        ),
      );
    } on AppException catch (error) {
      if (generation != _generation) return;
      emit(state.copyWith(isLoadingMore: false, loadMoreError: () => error));
    }
  }

  Future<ProductPageEntity> _fetchPage({required int skip}) =>
      _getProducts(limit: ApiConstants.productsPageSize, skip: skip);
}
