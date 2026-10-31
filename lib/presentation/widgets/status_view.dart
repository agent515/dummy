import 'package:flutter/material.dart';

import '../../core/errors/app_exception.dart';
import '../../utils/app_error.dart';
import '../../utils/app_sizes.dart';

/// Centered icon, title, message and optional action, used for empty and
/// error states.
class StatusView extends StatelessWidget {
  const StatusView({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  StatusView.error({
    Key? key,
    required AppException error,
    VoidCallback? onRetry,
  }) : this(
         key: key,
         icon: switch (error) {
           NetworkException() => Icons.wifi_off_rounded,
           RequestTimeoutException() => Icons.hourglass_empty_rounded,
           _ => Icons.error_outline_rounded,
         },
         title: switch (error) {
           NetworkException() => "You're offline",
           ApiException(statusCode: 404) => 'Not found',
           _ => 'Something went wrong',
         },
         message: error.userMessage,
         actionLabel: onRetry == null ? null : 'Try again',
         onAction: onRetry,
       );

  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.formMaxWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 56, color: theme.colorScheme.outline),
              const SizedBox(height: AppSizes.lg),
              Text(
                title,
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              if (message != null) ...[
                const SizedBox(height: AppSizes.sm),
                Text(
                  message!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (onAction != null && actionLabel != null) ...[
                const SizedBox(height: AppSizes.xl),
                FilledButton.tonalIcon(
                  onPressed: onAction,
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(actionLabel!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
