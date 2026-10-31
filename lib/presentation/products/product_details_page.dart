import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product_entity.dart';
import '../../injectable/service_locator.dart';
import '../../utils/app_sizes.dart';
import '../widgets/status_view.dart';
import 'bloc/product_details_bloc.dart';
import 'widgets/product_details_content.dart';
import 'widgets/product_image_gallery.dart';

@RoutePage()
class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
    @PathParam('id') required this.productId,
  });

  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ProductDetailsBloc>()..add(ProductDetailsRequested(productId)),
      child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) => switch (state) {
          ProductDetailsLoading() => Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          ),
          ProductDetailsFailure(:final error) => Scaffold(
            appBar: AppBar(),
            body: StatusView.error(
              error: error,
              onRetry: () => context.read<ProductDetailsBloc>().add(
                ProductDetailsRequested(productId),
              ),
            ),
          ),
          ProductDetailsLoaded(:final product) => _ProductDetailsView(product),
        },
      ),
    );
  }
}

class _ProductDetailsView extends StatelessWidget {
  const _ProductDetailsView(this.product);

  final ProductEntity product;

  static const _twoColumnBreakpoint = 840.0;

  @override
  Widget build(BuildContext context) {
    final images = product.images.isNotEmpty
        ? product.images
        : [product.thumbnail];

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= _twoColumnBreakpoint) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.xl),
                      child: ProductImageGallery(images: images),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(
                        0,
                        AppSizes.xl,
                        AppSizes.xl,
                        AppSizes.xl,
                      ),
                      child: ProductDetailsContent(product: product),
                    ),
                  ),
                ],
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: AppSizes.xl),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppSizes.contentMaxWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSizes.lg),
                        child: ProductImageGallery(images: images),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.lg,
                        ),
                        child: ProductDetailsContent(product: product),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
