import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_entity.freezed.dart';

@freezed
abstract class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    required int id,
    required String title,
    required String description,
    required String category,
    required double price,
    required double discountPercentage,
    required double rating,
    required int stock,
    required String thumbnail,
    String? brand,
    String? availabilityStatus,
    String? warrantyInformation,
    String? shippingInformation,
    String? returnPolicy,
    @Default([]) List<String> images,
    @Default([]) List<String> tags,
    @Default([]) List<ProductReviewEntity> reviews,
  }) = _ProductEntity;
}

@freezed
abstract class ProductReviewEntity with _$ProductReviewEntity {
  const factory ProductReviewEntity({
    required int rating,
    required String comment,
    required String reviewerName,
    DateTime? date,
  }) = _ProductReviewEntity;
}

/// One page of the product catalogue.
@freezed
abstract class ProductPageEntity with _$ProductPageEntity {
  const factory ProductPageEntity({
    required List<ProductEntity> products,
    required int total,
    required int skip,
  }) = _ProductPageEntity;
}
