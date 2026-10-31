import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_error.dart';
import '../../../utils/app_router.dart';
import '../../../utils/app_sizes.dart';
import '../../widgets/status_view.dart';
import '../bloc/products_bloc.dart';
import 'product_card.dart';

/// Paginated, pull-to-refreshable product grid.
class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, required this.state});

  final ProductsState state;

  /// Remaining scroll distance at which the next page is requested.
  static const _loadMoreThreshold = 600.0;

  bool _onScrollMetrics(BuildContext context, ScrollMetrics metrics) {
    if (metrics.axis == Axis.vertical &&
        metrics.extentAfter < _loadMoreThreshold &&
        state.canLoadMore) {
      context.read<ProductsBloc>().add(const ProductsNextPageRequested());
    }
    return false;
  }

  Future<void> _onRefresh(BuildContext context) {
    final bloc = context.read<ProductsBloc>()..add(const ProductsRefreshed());
    return bloc.stream.firstWhere((state) => !state.isRefreshing);
  }

  @override
  Widget build(BuildContext context) {
    final products = state.products;

    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      // Metrics notifications also fire when content size changes, which
      // covers a first page too short to scroll (e.g. on large screens).
      child: NotificationListener<ScrollMetricsNotification>(
        onNotification: (n) => _onScrollMetrics(context, n.metrics),
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: (n) => _onScrollMetrics(context, n.metrics),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              if (products.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: StatusView(
                    icon: Icons.inventory_2_outlined,
                    title: 'No products yet',
                    message: 'Pull down to check again.',
                  ),
                )
              else ...[
                SliverSafeArea(
                  bottom: false,
                  sliver: SliverPadding(
                    padding: const EdgeInsets.all(AppSizes.lg),
                    sliver: SliverGrid.builder(
                      gridDelegate: productGridDelegate,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductCard(
                          key: ValueKey(product.id),
                          product: product,
                          onTap: () => context.router.push(
                            ProductDetailsRoute(productId: product.id),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SliverSafeArea(
                  top: false,
                  sliver: SliverToBoxAdapter(child: _ListFooter(state: state)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ListFooter extends StatelessWidget {
  const _ListFooter({required this.state});

  final ProductsState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mutedStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    final Widget child;
    if (state.loadMoreError case final error?) {
      child = Column(
        children: [
          Text(
            error.userMessage,
            style: mutedStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.sm),
          TextButton.icon(
            onPressed: () => context.read<ProductsBloc>().add(
              const ProductsNextPageRequested(isRetry: true),
            ),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
          ),
        ],
      );
    } else if (state.isLoadingMore || !state.hasReachedEnd) {
      // Also shown just before a page is requested, so the footer doesn't
      // jump.
      child = const SizedBox.square(
        dimension: 28,
        child: CircularProgressIndicator(strokeWidth: 2.5),
      );
    } else {
      child = Text(
        "You've seen all ${state.products.length} products",
        style: mutedStyle,
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.lg,
        0,
        AppSizes.lg,
        AppSizes.xl,
      ),
      child: Center(child: child),
    );
  }
}
