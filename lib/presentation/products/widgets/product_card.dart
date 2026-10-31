import 'package:flutter/material.dart';

import '../../../core/utils/formatters.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../utils/app_sizes.dart';
import '../../widgets/app_network_image.dart';

/// Grid layout shared by the product grid and its loading skeleton.
const productGridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: AppSizes.productTileMaxWidth,
  mainAxisSpacing: AppSizes.md,
  crossAxisSpacing: AppSizes.md,
  childAspectRatio: 0.64,
);

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final ProductEntity product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Flexible so large text scales shrink the image, not overflow.
            Expanded(
              child: ColoredBox(
                color: colors.surfaceContainerHighest.withValues(alpha: .4),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.sm),
                  child: AppNetworkImage(product.thumbnail),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    product.brand ?? product.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          Formatters.price(product.price),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: colors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: Colors.amber.shade600,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Placeholder tile shown while the first page loads.
class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final block = Theme.of(context).colorScheme.surfaceContainerHighest;
    Widget bar(double widthFactor) => FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        height: 12,
        decoration: BoxDecoration(
          color: block,
          borderRadius: BorderRadius.circular(AppSizes.xs),
        ),
      ),
    );

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: ColoredBox(color: block.withValues(alpha: .6))),
          Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bar(.9),
                const SizedBox(height: AppSizes.sm),
                bar(.5),
                const SizedBox(height: AppSizes.md),
                bar(.35),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
