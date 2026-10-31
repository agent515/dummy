import 'package:flutter/widgets.dart';
import 'package:logarte/logarte.dart';

/// Shows logarte's floating console button above every route.
///
/// [Logarte.attach] looks up the overlay from the context it is given after a
/// short delay, so that context has to sit inside the navigator's overlay and
/// outlive route changes. A route's context does not (the splash route is
/// replaced right away), so an empty overlay entry is inserted to provide one.
class LogarteButtonObserver extends NavigatorObserver {
  LogarteButtonObserver(this._logarte);

  final Logarte _logarte;
  bool _inserted = false;
  bool _attached = false;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (_inserted) return;
    _inserted = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigator?.overlay?.insert(
        OverlayEntry(
          builder: (context) {
            if (!_attached) {
              _attached = true;
              _logarte.attach(context: context, visible: true);
            }
            return const SizedBox.shrink();
          },
        ),
      );
    });
  }
}
