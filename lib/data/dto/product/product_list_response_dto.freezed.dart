// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_list_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductListResponseDto {

 List<ProductDto> get products; int get total; int get skip; int get limit;
/// Create a copy of ProductListResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductListResponseDtoCopyWith<ProductListResponseDto> get copyWith => _$ProductListResponseDtoCopyWithImpl<ProductListResponseDto>(this as ProductListResponseDto, _$identity);

  /// Serializes this ProductListResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductListResponseDto&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(products),total,skip,limit);

@override
String toString() {
  return 'ProductListResponseDto(products: $products, total: $total, skip: $skip, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $ProductListResponseDtoCopyWith<$Res>  {
  factory $ProductListResponseDtoCopyWith(ProductListResponseDto value, $Res Function(ProductListResponseDto) _then) = _$ProductListResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<ProductDto> products, int total, int skip, int limit
});




}
/// @nodoc
class _$ProductListResponseDtoCopyWithImpl<$Res>
    implements $ProductListResponseDtoCopyWith<$Res> {
  _$ProductListResponseDtoCopyWithImpl(this._self, this._then);

  final ProductListResponseDto _self;
  final $Res Function(ProductListResponseDto) _then;

/// Create a copy of ProductListResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? products = null,Object? total = null,Object? skip = null,Object? limit = null,}) {
  return _then(_self.copyWith(
products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductDto>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,skip: null == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductListResponseDto].
extension ProductListResponseDtoPatterns on ProductListResponseDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductListResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductListResponseDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductListResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _ProductListResponseDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductListResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProductListResponseDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProductDto> products,  int total,  int skip,  int limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductListResponseDto() when $default != null:
return $default(_that.products,_that.total,_that.skip,_that.limit);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProductDto> products,  int total,  int skip,  int limit)  $default,) {final _that = this;
switch (_that) {
case _ProductListResponseDto():
return $default(_that.products,_that.total,_that.skip,_that.limit);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProductDto> products,  int total,  int skip,  int limit)?  $default,) {final _that = this;
switch (_that) {
case _ProductListResponseDto() when $default != null:
return $default(_that.products,_that.total,_that.skip,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductListResponseDto implements ProductListResponseDto {
  const _ProductListResponseDto({final  List<ProductDto> products = const [], this.total = 0, this.skip = 0, this.limit = 0}): _products = products;
  factory _ProductListResponseDto.fromJson(Map<String, dynamic> json) => _$ProductListResponseDtoFromJson(json);

 final  List<ProductDto> _products;
@override@JsonKey() List<ProductDto> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override@JsonKey() final  int total;
@override@JsonKey() final  int skip;
@override@JsonKey() final  int limit;

/// Create a copy of ProductListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductListResponseDtoCopyWith<_ProductListResponseDto> get copyWith => __$ProductListResponseDtoCopyWithImpl<_ProductListResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductListResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductListResponseDto&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),total,skip,limit);

@override
String toString() {
  return 'ProductListResponseDto(products: $products, total: $total, skip: $skip, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$ProductListResponseDtoCopyWith<$Res> implements $ProductListResponseDtoCopyWith<$Res> {
  factory _$ProductListResponseDtoCopyWith(_ProductListResponseDto value, $Res Function(_ProductListResponseDto) _then) = __$ProductListResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<ProductDto> products, int total, int skip, int limit
});




}
/// @nodoc
class __$ProductListResponseDtoCopyWithImpl<$Res>
    implements _$ProductListResponseDtoCopyWith<$Res> {
  __$ProductListResponseDtoCopyWithImpl(this._self, this._then);

  final _ProductListResponseDto _self;
  final $Res Function(_ProductListResponseDto) _then;

/// Create a copy of ProductListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? products = null,Object? total = null,Object? skip = null,Object? limit = null,}) {
  return _then(_ProductListResponseDto(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductDto>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,skip: null == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
