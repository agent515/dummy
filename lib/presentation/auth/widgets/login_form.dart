import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_error.dart';
import '../../../utils/app_sizes.dart';
import '../bloc/auth_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  /// Public test account documented by DummyJSON.
  static const demoUsername = 'emilys';
  static const demoPassword = 'emilyspass';

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
      AuthLoginSubmitted(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _fillDemoCredentials() {
    _usernameController.text = LoginForm.demoUsername;
    _passwordController.text = LoginForm.demoPassword;
    _formKey.currentState!.validate();
  }

  static String? _required(String? value, String field) =>
      (value == null || value.trim().isEmpty) ? 'Enter your $field' : null;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (_, current) => current is AuthAuthenticated,
      // Lets the platform offer to save the credentials.
      listener: (_, _) => TextInput.finishAutofillContext(),
      builder: (context, state) {
        final isLoading = state is AuthLoginInProgress;
        final bannerMessage = switch (state) {
          AuthUnauthenticated(:final error?) => error.userMessage,
          AuthUnauthenticated(sessionExpired: true) =>
            'Your session has expired. Please sign in again.',
          _ => null,
        };

        return Form(
          key: _formKey,
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (bannerMessage != null) ...[
                  _ErrorBanner(message: bannerMessage),
                  const SizedBox(height: AppSizes.lg),
                ],
                TextFormField(
                  controller: _usernameController,
                  enabled: !isLoading,
                  autofillHints: const [AutofillHints.username],
                  autocorrect: false,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                  validator: (value) => _required(value, 'username'),
                ),
                const SizedBox(height: AppSizes.lg),
                TextFormField(
                  controller: _passwordController,
                  enabled: !isLoading,
                  obscureText: _obscurePassword,
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      tooltip: _obscurePassword
                          ? 'Show password'
                          : 'Hide password',
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (value) => _required(value, 'password'),
                ),
                const SizedBox(height: AppSizes.xl),
                FilledButton(
                  onPressed: isLoading ? null : _submit,
                  child: isLoading
                      ? const SizedBox.square(
                          dimension: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        )
                      : const Text('Sign in'),
                ),
                const SizedBox(height: AppSizes.sm),
                TextButton(
                  onPressed: isLoading ? null : _fillDemoCredentials,
                  child: const Text('Use demo account'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      liveRegion: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.errorContainer,
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Row(
            children: [
              Icon(Icons.error_outline_rounded, color: colors.onErrorContainer),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: colors.onErrorContainer),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
