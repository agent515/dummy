import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logarte/logarte.dart';

import '../core/debug/logarte_button_observer.dart';
import '../injectable/service_locator.dart';
import '../presentation/auth/bloc/auth_bloc.dart';
import '../utils/app_router.dart';
import 'app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _authBloc = getIt<AuthBloc>();
  final _router = getIt<AppRouter>();
  late final _routerConfig = _router.config(
    navigatorObservers: () => [
      if (kDebugMode) LogarteButtonObserver(getIt<Logarte>()),
    ],
  );

  @override
  void initState() {
    super.initState();
    _authBloc.add(const AuthSessionRestoreRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authBloc,
      child: MaterialApp.router(
        title: 'DummyJSON Shop',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: _routerConfig,
        builder: (context, child) => BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous is AuthInitial ||
              (previous is AuthAuthenticated) != (current is AuthAuthenticated),
          listener: (context, state) => switch (state) {
            AuthAuthenticated() => _router.replaceAll([const ProductsRoute()]),
            AuthUnauthenticated() => _router.replaceAll([const LoginRoute()]),
            AuthInitial() || AuthLoginInProgress() => null,
          },
          child: child,
        ),
      ),
    );
  }
}
