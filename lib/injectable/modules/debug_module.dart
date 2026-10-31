import 'package:injectable/injectable.dart';
import 'package:logarte/logarte.dart';

@module
abstract class DebugModule {
  /// In-app console for inspecting network calls, enabled in every build
  /// mode. See `DioClient` and `LogarteButtonObserver`.
  // TODO: disable for the prod environment once environments are added.
  @lazySingleton
  Logarte get logarte => Logarte();
}
