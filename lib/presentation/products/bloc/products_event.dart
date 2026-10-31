part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

/// Loads the first page, replacing whatever is shown. Also used to retry a
/// failed initial load.
final class ProductsStarted extends ProductsEvent {
  const ProductsStarted();
}

/// Pull-to-refresh: reloads the first page while keeping the current list
/// visible until it arrives.
final class ProductsRefreshed extends ProductsEvent {
  const ProductsRefreshed();
}

final class ProductsNextPageRequested extends ProductsEvent {
  const ProductsNextPageRequested({this.isRetry = false});

  /// Scroll-triggered requests are ignored after a failed page so the list
  /// doesn't retry on its own in a loop; an explicit retry clears that.
  final bool isRetry;

  @override
  List<Object?> get props => [isRetry];
}
