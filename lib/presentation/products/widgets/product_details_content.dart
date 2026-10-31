import 'package:flutter/material.dart';

import '../../../core/utils/formatters.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../utils/app_sizes.dart';
import 'rating_stars.dart';

/// Everything on the details page except the image gallery.
class ProductDetailsContent extends StatelessWidget {
  const ProductDetailsContent({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final mutedStyle = theme.textTheme.bodyMedium?.copyWith(
      color: colors.onSurfaceVariant,
    );

    final policies = [
      (Icons.verified_user_outlined, 'Warranty', product.warrantyInformation),
      (Icons.local_shipping_outlined, 'Shipping', product.shippingInformation),
      (Icons.assignment_return_outlined, 'Returns', product.returnPolicy),
    ].where((policy) => policy.$3?.isNotEmpty ?? false).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          [?product.brand, _capitalize(product.category)].join(' · '),
          style: theme.textTheme.labelLarge?.copyWith(color: colors.primary),
        ),
        const SizedBox(height: AppSizes.xs),
        Text(product.title, style: theme.textTheme.headlineSmall),
        const SizedBox(height: AppSizes.md),
        Wrap(
          spacing: AppSizes.sm,
          runSpacing: AppSizes.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              Formatters.price(product.price),
              style: theme.textTheme.headlineMedium?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (product.discountPercentage > 0)
              _Pill(
                label: Formatters.discount(product.discountPercentage),
                background: colors.tertiaryContainer,
                foreground: colors.onTertiaryContainer,
              ),
          ],
        ),
        const SizedBox(height: AppSizes.md),
        Wrap(
          spacing: AppSizes.md,
          runSpacing: AppSizes.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RatingStars(rating: product.rating, size: 18),
                const SizedBox(width: AppSizes.xs),
                Text(
                  product.rating.toStringAsFixed(1),
                  style: theme.textTheme.labelLarge,
                ),
              ],
            ),
            _StockPill(product: product),
          ],
        ),
        const SizedBox(height: AppSizes.xl),
        Text('Description', style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSizes.sm),
        Text(product.description, style: theme.textTheme.bodyLarge),
        if (policies.isNotEmpty) ...[
          const SizedBox(height: AppSizes.xl),
          Card(
            child: Column(
              children: [
                for (final (icon, label, value) in policies)
                  ListTile(
                    leading: Icon(icon, color: colors.primary),
                    title: Text(label),
                    subtitle: Text(value!),
                  ),
              ],
            ),
          ),
        ],
        if (product.tags.isNotEmpty) ...[
          const SizedBox(height: AppSizes.xl),
          Wrap(
            spacing: AppSizes.sm,
            runSpacing: AppSizes.sm,
            children: [
              for (final tag in product.tags) Chip(label: Text('#$tag')),
            ],
          ),
        ],
        const SizedBox(height: AppSizes.xl),
        Text(
          'Reviews (${product.reviews.length})',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: AppSizes.sm),
        if (product.reviews.isEmpty)
          Text('No reviews yet.', style: mutedStyle)
        else
          for (final review in product.reviews) ...[
            _ReviewTile(review: review),
            const SizedBox(height: AppSizes.sm),
          ],
      ],
    );
  }

  static String _capitalize(String value) => value.isEmpty
      ? value
      : '${value[0].toUpperCase()}${value.substring(1).replaceAll('-', ' ')}';
}

class _StockPill extends StatelessWidget {
  const _StockPill({required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final status =
        product.availabilityStatus ??
        (product.stock > 0 ? 'In Stock' : 'Out of Stock');
    final inStock = product.stock > 0;

    return _Pill(
      label: inStock ? '$status · ${product.stock} left' : status,
      background: inStock ? colors.secondaryContainer : colors.errorContainer,
      foreground: inStock
          ? colors.onSecondaryContainer
          : colors.onErrorContainer,
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.xs,
        ),
        child: Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: foreground),
        ),
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});

  final ProductReviewEntity review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    review.reviewerName,
                    style: theme.textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                RatingStars(rating: review.rating.toDouble(), size: 14),
              ],
            ),
            if (review.date case final date?) ...[
              const SizedBox(height: 2),
              Text(
                Formatters.date(date),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: AppSizes.sm),
            Text(review.comment, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
