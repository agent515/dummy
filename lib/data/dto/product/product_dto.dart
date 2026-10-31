import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/product_entity.dart';

part 'product_dto.freezed.dart';
part 'product_dto.g.dart';

/// Every field except `id` is defaulted so one malformed product can't
/// fail a whole page.
@freezed
abstract class ProductDto with _$ProductDto {
  const factory ProductDto({
    required int id,
    @Default('') String title,
    @Default('') String description,
    @Default('') String category,
    @Default(0) double price,
    @Default(0) double discountPercentage,
    @Default(0) double rating,
    @Default(0) int stock,
    @Default('') String thumbnail,
    String? brand,
    String? availabilityStatus,
    String? warrantyInformation,
    String? shippingInformation,
    String? returnPolicy,
    @Default([]) List<String> images,
    @Default([]) List<String> tags,
    @Default([]) List<ProductReviewDto> reviews,
  }) = _ProductDto;

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);
}

@freezed
abstract class ProductReviewDto with _$ProductReviewDto {
  const factory ProductReviewDto({
    @Default(0) int rating,
    @Default('') String comment,
    @Default('') String reviewerName,
    String? date,
  }) = _ProductReviewDto;

  factory ProductReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewDtoFromJson(json);
}

extension ProductDtoMapper on ProductDto {
  ProductEntity toEntity() => ProductEntity(
    id: id,
    title: title,
    description: description,
    category: category,
    price: price,
    discountPercentage: discountPercentage,
    rating: rating,
    stock: stock,
    thumbnail: thumbnail,
    brand: brand,
    availabilityStatus: availabilityStatus,
    warrantyInformation: warrantyInformation,
    shippingInformation: shippingInformation,
    returnPolicy: returnPolicy,
    images: images,
    tags: tags,
    reviews: reviews.map((review) => review.toEntity()).toList(),
  );
}

extension ProductReviewDtoMapper on ProductReviewDto {
  ProductReviewEntity toEntity() => ProductReviewEntity(
    rating: rating,
    comment: comment,
    reviewerName: reviewerName,
    date: date == null ? null : DateTime.tryParse(date!),
  );
}
