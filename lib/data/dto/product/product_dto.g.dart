// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) => _ProductDto(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  category: json['category'] as String? ?? '',
  price: (json['price'] as num?)?.toDouble() ?? 0,
  discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0,
  rating: (json['rating'] as num?)?.toDouble() ?? 0,
  stock: (json['stock'] as num?)?.toInt() ?? 0,
  thumbnail: json['thumbnail'] as String? ?? '',
  brand: json['brand'] as String?,
  availabilityStatus: json['availabilityStatus'] as String?,
  warrantyInformation: json['warrantyInformation'] as String?,
  shippingInformation: json['shippingInformation'] as String?,
  returnPolicy: json['returnPolicy'] as String?,
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  reviews:
      (json['reviews'] as List<dynamic>?)
          ?.map((e) => ProductReviewDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ProductDtoToJson(_ProductDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'discountPercentage': instance.discountPercentage,
      'rating': instance.rating,
      'stock': instance.stock,
      'thumbnail': instance.thumbnail,
      'brand': instance.brand,
      'availabilityStatus': instance.availabilityStatus,
      'warrantyInformation': instance.warrantyInformation,
      'shippingInformation': instance.shippingInformation,
      'returnPolicy': instance.returnPolicy,
      'images': instance.images,
      'tags': instance.tags,
      'reviews': instance.reviews,
    };

_ProductReviewDto _$ProductReviewDtoFromJson(Map<String, dynamic> json) =>
    _ProductReviewDto(
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      comment: json['comment'] as String? ?? '',
      reviewerName: json['reviewerName'] as String? ?? '',
      date: json['date'] as String?,
    );

Map<String, dynamic> _$ProductReviewDtoToJson(_ProductReviewDto instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'comment': instance.comment,
      'reviewerName': instance.reviewerName,
      'date': instance.date,
    };
