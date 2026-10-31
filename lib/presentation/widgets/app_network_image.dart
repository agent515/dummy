import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Cached network image with themed placeholder and error states.
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage(this.url, {super.key, this.fit = BoxFit.contain});

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final fallback = ColoredBox(
      color: colors.surfaceContainerHighest,
      child: Center(
        child: Icon(Icons.image_outlined, color: colors.outline, size: 32),
      ),
    );

    if (url.isEmpty) return fallback;
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 200),
      placeholder: (_, _) => ColoredBox(color: colors.surfaceContainerHighest),
      errorWidget: (_, _, _) => fallback,
    );
  }
}
