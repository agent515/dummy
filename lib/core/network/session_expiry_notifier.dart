import 'dart:async';

import 'package:injectable/injectable.dart';

/// Lets the networking layer announce that the session is over without
/// depending on the layers that react to it (auth state, navigation).
@lazySingleton
class SessionExpiryNotifier {
  final _controller = StreamController<void>.broadcast();

  Stream<void> get stream => _controller.stream;

  void notifyExpired() => _controller.add(null);

  @disposeMethod
  Future<void> dispose() => _controller.close();
}
