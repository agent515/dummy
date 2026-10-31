part of 'product_details_bloc.dart';

sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object?> get props => [];
}

/// Loads (or reloads, on retry) the product with [productId].
final class ProductDetailsRequested extends ProductDetailsEvent {
  const ProductDetailsRequested(this.productId);

  final int productId;

  @override
  List<Object?> get props => [productId];
}
