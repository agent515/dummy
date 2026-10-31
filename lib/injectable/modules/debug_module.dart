import 'package:injectable/injectable.dart';
import 'package:logarte/logarte.dart';

@module
abstract class DebugModule {
  /// In-app console for inspecting network calls. Only wired up in debug
  /// builds, see `DioClient` and `LogarteButtonObserver`.
  @lazySingleton
  Logarte get logarte => Logarte();
}
