import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injectable/service_locator.dart';
import '../../utils/app_error.dart';
import '../../utils/app_sizes.dart';
import '../widgets/status_view.dart';
import 'bloc/products_bloc.dart';
import 'widgets/account_menu.dart';
import 'widgets/product_card.dart';
import 'widgets/products_grid.dart';

@RoutePage()
class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductsBloc>()..add(const ProductsStarted()),
      child: const _ProductsView(),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: const [
          AccountMenu(),
          SizedBox(width: AppSizes.sm),
        ],
      ),
      body: BlocConsumer<ProductsBloc, ProductsState>(
        // A failed refresh keeps the current list, so report it out of band.
        listenWhen: (previous, current) =>
            current.status == ProductsStatus.success &&
            current.error != null &&
            current.error != previous.error,
        listener: (context, state) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.error!.userMessage)));
        },
        builder: (context, state) => switch (state.status) {
          ProductsStatus.initial ||
          ProductsStatus.loading => const _LoadingGrid(),
          ProductsStatus.failure => StatusView.error(
            error: state.error!,
            onRetry: () =>
                context.read<ProductsBloc>().add(const ProductsStarted()),
          ),
          ProductsStatus.success => ProductsGrid(state: state),
        },
      ),
    );
  }
}

class _LoadingGrid extends StatelessWidget {
  const _LoadingGrid();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Loading products',
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSizes.lg),
        gridDelegate: productGridDelegate,
        itemCount: 12,
        itemBuilder: (_, _) => const ProductCardSkeleton(),
      ),
    );
  }
}
