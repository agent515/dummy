// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductListResponseDto _$ProductListResponseDtoFromJson(
  Map<String, dynamic> json,
) => _ProductListResponseDto(
  products:
      (json['products'] as List<dynamic>?)
          ?.map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
  skip: (json['skip'] as num?)?.toInt() ?? 0,
  limit: (json['limit'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ProductListResponseDtoToJson(
  _ProductListResponseDto instance,
) => <String, dynamic>{
  'products': instance.products,
  'total': instance.total,
  'skip': instance.skip,
  'limit': instance.limit,
};
