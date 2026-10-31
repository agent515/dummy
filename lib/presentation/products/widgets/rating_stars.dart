import 'package:flutter/material.dart';

/// Five stars filled to [rating] (0–5), in half-star steps.
class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.rating, this.size = 16});

  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    final halfSteps = (rating.clamp(0, 5) * 2).round();
    return Semantics(
      label: 'Rated ${rating.toStringAsFixed(1)} out of 5',
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var star = 1; star <= 5; star++)
            Icon(
              halfSteps >= star * 2
                  ? Icons.star_rounded
                  : halfSteps == star * 2 - 1
                  ? Icons.star_half_rounded
                  : Icons.star_outline_rounded,
              size: size,
              color: Colors.amber.shade600,
            ),
        ],
      ),
    );
  }
}
