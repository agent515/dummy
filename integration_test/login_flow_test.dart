import 'package:dummy/main.dart' as app;
import 'package:dummy/presentation/products/bloc/products_bloc.dart';
import 'package:dummy/presentation/products/widgets/product_card.dart';
import 'package:dummy/presentation/products/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'helpers.dart';

/// End-to-end against the live API: login → products → pagination → details.
/// Leaves the session signed in; `session_restore_test.dart` picks it up.
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('login, paginate and open a product', (tester) async {
    await const FlutterSecureStorage().deleteAll();
    app.main();

    await pumpUntilFound(tester, find.text('Welcome back'));
    await binding.takeScreenshot('01-login');

    await tester.tap(find.text('Use demo account'));
    await tester.pump();
    await tester.tap(find.text('Sign in'));
    await pumpUntilFound(tester, find.byType(ProductCard));
    await tester.pump(const Duration(seconds: 2)); // let thumbnails load
    await binding.takeScreenshot('02-products');

    ProductsState productsState() =>
        tester.element(find.byType(ProductsGrid)).read<ProductsBloc>().state;
    expect(productsState().products, hasLength(20));
    expect(productsState().total, greaterThan(20));

    await tester.fling(
      find.byType(CustomScrollView),
      const Offset(0, -4000),
      4000,
    );
    await pumpUntil(tester, () => productsState().products.length >= 40);
    final ids = productsState().products.map((p) => p.id).toList();
    expect(ids.toSet(), hasLength(ids.length), reason: 'no duplicates');
    await tester.pump(const Duration(seconds: 1));
    await binding.takeScreenshot('03-paginated');

    // Off-screen cards in the sliver cache area also match; tap a visible one.
    await tester.tap(find.byType(ProductCard).hitTestable().first);
    await pumpUntilFound(tester, find.text('Description'));
    await tester.pump(const Duration(seconds: 2));
    await binding.takeScreenshot('04-details');

    await tester.pageBack();
    await pumpUntilFound(tester, find.byType(ProductCard));
  });
}
