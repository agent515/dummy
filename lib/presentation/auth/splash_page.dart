import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../utils/app_sizes.dart';

/// Shown while the persisted session is restored; `App` navigates away once
/// the auth state is known.
@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.storefront_rounded, size: 64, color: colors.primary),
            const SizedBox(height: AppSizes.xl),
            const SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(strokeWidth: 2.5),
            ),
          ],
        ),
      ),
    );
  }
}
