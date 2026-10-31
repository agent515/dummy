import 'package:flutter/material.dart';

import '../../../utils/app_sizes.dart';
import '../../widgets/app_network_image.dart';

/// Square, swipeable image carousel with a page indicator.
class ProductImageGallery extends StatefulWidget {
  const ProductImageGallery({super.key, required this.images});

  final List<String> images;

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final images = widget.images;

    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        child: ColoredBox(
          color: colors.surfaceContainerHighest.withValues(alpha: .4),
          child: Stack(
            children: [
              PageView.builder(
                itemCount: images.length,
                onPageChanged: (page) => setState(() => _page = page),
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.all(AppSizes.xl),
                  child: Semantics(
                    image: true,
                    label: 'Product image ${index + 1} of ${images.length}',
                    child: AppNetworkImage(images[index]),
                  ),
                ),
              ),
              if (images.length > 1)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: AppSizes.md,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < images.length; i++)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: i == _page ? 18 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: i == _page
                                ? colors.primary
                                : colors.outlineVariant,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
