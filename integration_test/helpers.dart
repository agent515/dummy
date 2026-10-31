import 'package:flutter_test/flutter_test.dart';

/// Pumps frames until [finder] matches or [timeout] elapses. Used instead of
/// `pumpAndSettle`, which never settles while a progress indicator spins.
Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 20),
}) => pumpUntil(tester, () => finder.evaluate().isNotEmpty, timeout: timeout);

Future<void> pumpUntil(
  WidgetTester tester,
  bool Function() condition, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      throw TestFailure('Condition not met within $timeout');
    }
    await tester.pump(const Duration(milliseconds: 100));
  }
}
