import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/product_entity.dart';
import 'product_dto.dart';

part 'product_list_response_dto.freezed.dart';
part 'product_list_response_dto.g.dart';

@freezed
abstract class ProductListResponseDto with _$ProductListResponseDto {
  const factory ProductListResponseDto({
    @Default([]) List<ProductDto> products,
    @Default(0) int total,
    @Default(0) int skip,
    @Default(0) int limit,
  }) = _ProductListResponseDto;

  factory ProductListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductListResponseDtoFromJson(json);
}

extension ProductListResponseDtoMapper on ProductListResponseDto {
  ProductPageEntity toEntity() => ProductPageEntity(
    products: products.map((product) => product.toEntity()).toList(),
    total: total,
    skip: skip,
  );
}
