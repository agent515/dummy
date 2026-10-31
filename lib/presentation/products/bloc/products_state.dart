part of 'products_bloc.dart';

enum ProductsStatus { initial, loading, success, failure }

final class ProductsState extends Equatable {
  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.total = 0,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.error,
    this.loadMoreError,
  });

  final ProductsStatus status;
  final List<ProductEntity> products;

  /// Total number of products the API reports.
  final int total;

  final bool isLoadingMore;
  final bool isRefreshing;

  /// Failure of the initial load (when [status] is failure) or of a refresh
  /// that kept the existing products.
  final AppException? error;

  /// Failure of the most recent next-page request.
  final AppException? loadMoreError;

  bool get hasReachedEnd => products.length >= total;

  bool get canLoadMore =>
      status == ProductsStatus.success &&
      !hasReachedEnd &&
      !isLoadingMore &&
      !isRefreshing &&
      loadMoreError == null;

  ProductsState copyWith({
    ProductsStatus? status,
    List<ProductEntity>? products,
    int? total,
    bool? isLoadingMore,
    bool? isRefreshing,
    AppException? Function()? error,
    AppException? Function()? loadMoreError,
  }) => ProductsState(
    status: status ?? this.status,
    products: products ?? this.products,
    total: total ?? this.total,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    isRefreshing: isRefreshing ?? this.isRefreshing,
    error: error != null ? error() : this.error,
    loadMoreError: loadMoreError != null ? loadMoreError() : this.loadMoreError,
  );

  @override
  List<Object?> get props => [
    status,
    products,
    total,
    isLoadingMore,
    isRefreshing,
    error,
    loadMoreError,
  ];
}
