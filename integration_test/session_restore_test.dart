import 'package:dummy/core/storage/token_storage.dart';
import 'package:dummy/injectable/service_locator.dart';
import 'package:dummy/main.dart' as app;
import 'package:dummy/presentation/products/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'helpers.dart';

/// Run after `login_flow_test.dart`: a fresh launch should skip login using
/// the stored session, and signing out should clear it.
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('restores the session, then signs out', (tester) async {
    app.main();

    await pumpUntilFound(tester, find.byType(ProductCard));
    expect(find.text('Welcome back'), findsNothing);
    await tester.pump(const Duration(seconds: 2));
    await binding.takeScreenshot('05-restored');

    await tester.tap(find.byTooltip('Account'));
    await pumpUntilFound(tester, find.text('Sign out'));
    await tester.pump(const Duration(milliseconds: 500));
    await binding.takeScreenshot('06-account-menu');
    await tester.tap(find.text('Sign out'));
    await pumpUntilFound(tester, find.text('Sign out?'));
    await tester.tap(find.widgetWithText(FilledButton, 'Sign out'));

    await pumpUntilFound(tester, find.text('Welcome back'));
    expect(await getIt<TokenStorage>().hasSession(), isFalse);
  });
}
