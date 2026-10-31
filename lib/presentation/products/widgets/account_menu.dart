import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/bloc/auth_bloc.dart';

enum _AccountAction { logout }

/// Avatar button in the app bar with the signed-in user and a sign-out action.
class AccountMenu extends StatelessWidget {
  const AccountMenu({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign out?'),
        content: const Text("You'll need to sign in again to browse products."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            // The theme's full-width minimumSize would push this onto its own line.
            style: FilledButton.styleFrom(minimumSize: const Size(64, 40)),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      context.read<AuthBloc>().add(const AuthLogoutRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = switch (context.watch<AuthBloc>().state) {
      AuthAuthenticated(:final user) => user,
      _ => null,
    };
    final colors = Theme.of(context).colorScheme;

    return PopupMenuButton<_AccountAction>(
      tooltip: 'Account',
      onSelected: (action) => switch (action) {
        _AccountAction.logout => _confirmLogout(context),
      },
      itemBuilder: (context) => [
        if (user != null)
          PopupMenuItem(
            enabled: false,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(user.fullName),
              subtitle: Text(user.email),
            ),
          ),
        const PopupMenuItem(
          value: _AccountAction.logout,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.logout_rounded),
            title: Text('Sign out'),
          ),
        ),
      ],
      child: CircleAvatar(
        radius: 18,
        backgroundColor: colors.primaryContainer,
        foregroundImage: user == null || user.image.isEmpty
            ? null
            : CachedNetworkImageProvider(user.image),
        child: Icon(Icons.person_rounded, color: colors.onPrimaryContainer),
      ),
    );
  }
}
