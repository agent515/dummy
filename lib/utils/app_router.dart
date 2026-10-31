import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../presentation/auth/bloc/auth_bloc.dart';
import '../presentation/auth/login_page.dart';
import '../presentation/auth/splash_page.dart';
import '../presentation/products/product_details_page.dart';
import '../presentation/products/products_page.dart';

part 'app_router.gr.dart';

/// Routes and their access rules.
///
/// Day-to-day redirects (after restore, login, logout or session expiry) are
/// driven by `App` listening to [AuthBloc]; the guards are the backstop for
/// any navigation that would bypass that.
@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter(this._authBloc);

  final AuthBloc _authBloc;

  bool get _isAuthenticated => _authBloc.state is AuthAuthenticated;

  late final _authGuard = AutoRouteGuard.simple((resolver, router) {
    if (_isAuthenticated) return resolver.next();
    resolver.next(false);
    router.replaceAll([const LoginRoute()]);
  }, debugLabel: 'AuthGuard');

  late final _guestGuard = AutoRouteGuard.simple((resolver, router) {
    if (!_isAuthenticated) return resolver.next();
    resolver.next(false);
    router.replaceAll([const ProductsRoute()]);
  }, debugLabel: 'GuestGuard');

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: '/', initial: true),
    AutoRoute(page: LoginRoute.page, path: '/login', guards: [_guestGuard]),
    AutoRoute(
      page: ProductsRoute.page,
      path: '/products',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: ProductDetailsRoute.page,
      path: '/products/:id',
      guards: [_authGuard],
    ),
  ];
}
