// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductDto {

 int get id; String get title; String get description; String get category; double get price; double get discountPercentage; double get rating; int get stock; String get thumbnail; String? get brand; String? get availabilityStatus; String? get warrantyInformation; String? get shippingInformation; String? get returnPolicy; List<String> get images; List<String> get tags; List<ProductReviewDto> get reviews;
/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDtoCopyWith<ProductDto> get copyWith => _$ProductDtoCopyWithImpl<ProductDto>(this as ProductDto, _$identity);

  /// Serializes this ProductDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.availabilityStatus, availabilityStatus) || other.availabilityStatus == availabilityStatus)&&(identical(other.warrantyInformation, warrantyInformation) || other.warrantyInformation == warrantyInformation)&&(identical(other.shippingInformation, shippingInformation) || other.shippingInformation == shippingInformation)&&(identical(other.returnPolicy, returnPolicy) || other.returnPolicy == returnPolicy)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.reviews, reviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,category,price,discountPercentage,rating,stock,thumbnail,brand,availabilityStatus,warrantyInformation,shippingInformation,returnPolicy,const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(reviews));

@override
String toString() {
  return 'ProductDto(id: $id, title: $title, description: $description, category: $category, price: $price, discountPercentage: $discountPercentage, rating: $rating, stock: $stock, thumbnail: $thumbnail, brand: $brand, availabilityStatus: $availabilityStatus, warrantyInformation: $warrantyInformation, shippingInformation: $shippingInformation, returnPolicy: $returnPolicy, images: $images, tags: $tags, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class $ProductDtoCopyWith<$Res>  {
  factory $ProductDtoCopyWith(ProductDto value, $Res Function(ProductDto) _then) = _$ProductDtoCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, String category, double price, double discountPercentage, double rating, int stock, String thumbnail, String? brand, String? availabilityStatus, String? warrantyInformation, String? shippingInformation, String? returnPolicy, List<String> images, List<String> tags, List<ProductReviewDto> reviews
});




}
/// @nodoc
class _$ProductDtoCopyWithImpl<$Res>
    implements $ProductDtoCopyWith<$Res> {
  _$ProductDtoCopyWithImpl(this._self, this._then);

  final ProductDto _self;
  final $Res Function(ProductDto) _then;

/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? price = null,Object? discountPercentage = null,Object? rating = null,Object? stock = null,Object? thumbnail = null,Object? brand = freezed,Object? availabilityStatus = freezed,Object? warrantyInformation = freezed,Object? shippingInformation = freezed,Object? returnPolicy = freezed,Object? images = null,Object? tags = null,Object? reviews = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,availabilityStatus: freezed == availabilityStatus ? _self.availabilityStatus : availabilityStatus // ignore: cast_nullable_to_non_nullable
as String?,warrantyInformation: freezed == warrantyInformation ? _self.warrantyInformation : warrantyInformation // ignore: cast_nullable_to_non_nullable
as String?,shippingInformation: freezed == shippingInformation ? _self.shippingInformation : shippingInformation // ignore: cast_nullable_to_non_nullable
as String?,returnPolicy: freezed == returnPolicy ? _self.returnPolicy : returnPolicy // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ProductReviewDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductDto].
extension ProductDtoPatterns on ProductDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductDto value)  $default,){
final _that = this;
switch (_that) {
case _ProductDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String category,  double price,  double discountPercentage,  double rating,  int stock,  String thumbnail,  String? brand,  String? availabilityStatus,  String? warrantyInformation,  String? shippingInformation,  String? returnPolicy,  List<String> images,  List<String> tags,  List<ProductReviewDto> reviews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.price,_that.discountPercentage,_that.rating,_that.stock,_that.thumbnail,_that.brand,_that.availabilityStatus,_that.warrantyInformation,_that.shippingInformation,_that.returnPolicy,_that.images,_that.tags,_that.reviews);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String category,  double price,  double discountPercentage,  double rating,  int stock,  String thumbnail,  String? brand,  String? availabilityStatus,  String? warrantyInformation,  String? shippingInformation,  String? returnPolicy,  List<String> images,  List<String> tags,  List<ProductReviewDto> reviews)  $default,) {final _that = this;
switch (_that) {
case _ProductDto():
return $default(_that.id,_that.title,_that.description,_that.category,_that.price,_that.discountPercentage,_that.rating,_that.stock,_that.thumbnail,_that.brand,_that.availabilityStatus,_that.warrantyInformation,_that.shippingInformation,_that.returnPolicy,_that.images,_that.tags,_that.reviews);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description,  String category,  double price,  double discountPercentage,  double rating,  int stock,  String thumbnail,  String? brand,  String? availabilityStatus,  String? warrantyInformation,  String? shippingInformation,  String? returnPolicy,  List<String> images,  List<String> tags,  List<ProductReviewDto> reviews)?  $default,) {final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.price,_that.discountPercentage,_that.rating,_that.stock,_that.thumbnail,_that.brand,_that.availabilityStatus,_that.warrantyInformation,_that.shippingInformation,_that.returnPolicy,_that.images,_that.tags,_that.reviews);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductDto implements ProductDto {
  const _ProductDto({required this.id, this.title = '', this.description = '', this.category = '', this.price = 0, this.discountPercentage = 0, this.rating = 0, this.stock = 0, this.thumbnail = '', this.brand, this.availabilityStatus, this.warrantyInformation, this.shippingInformation, this.returnPolicy, final  List<String> images = const [], final  List<String> tags = const [], final  List<ProductReviewDto> reviews = const []}): _images = images,_tags = tags,_reviews = reviews;
  factory _ProductDto.fromJson(Map<String, dynamic> json) => _$ProductDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String category;
@override@JsonKey() final  double price;
@override@JsonKey() final  double discountPercentage;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int stock;
@override@JsonKey() final  String thumbnail;
@override final  String? brand;
@override final  String? availabilityStatus;
@override final  String? warrantyInformation;
@override final  String? shippingInformation;
@override final  String? returnPolicy;
 final  List<String> _images;
@override@JsonKey() List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  List<ProductReviewDto> _reviews;
@override@JsonKey() List<ProductReviewDto> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}


/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDtoCopyWith<_ProductDto> get copyWith => __$ProductDtoCopyWithImpl<_ProductDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.availabilityStatus, availabilityStatus) || other.availabilityStatus == availabilityStatus)&&(identical(other.warrantyInformation, warrantyInformation) || other.warrantyInformation == warrantyInformation)&&(identical(other.shippingInformation, shippingInformation) || other.shippingInformation == shippingInformation)&&(identical(other.returnPolicy, returnPolicy) || other.returnPolicy == returnPolicy)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._reviews, _reviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,category,price,discountPercentage,rating,stock,thumbnail,brand,availabilityStatus,warrantyInformation,shippingInformation,returnPolicy,const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_reviews));

@override
String toString() {
  return 'ProductDto(id: $id, title: $title, description: $description, category: $category, price: $price, discountPercentage: $discountPercentage, rating: $rating, stock: $stock, thumbnail: $thumbnail, brand: $brand, availabilityStatus: $availabilityStatus, warrantyInformation: $warrantyInformation, shippingInformation: $shippingInformation, returnPolicy: $returnPolicy, images: $images, tags: $tags, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class _$ProductDtoCopyWith<$Res> implements $ProductDtoCopyWith<$Res> {
  factory _$ProductDtoCopyWith(_ProductDto value, $Res Function(_ProductDto) _then) = __$ProductDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description, String category, double price, double discountPercentage, double rating, int stock, String thumbnail, String? brand, String? availabilityStatus, String? warrantyInformation, String? shippingInformation, String? returnPolicy, List<String> images, List<String> tags, List<ProductReviewDto> reviews
});




}
/// @nodoc
class __$ProductDtoCopyWithImpl<$Res>
    implements _$ProductDtoCopyWith<$Res> {
  __$ProductDtoCopyWithImpl(this._self, this._then);

  final _ProductDto _self;
  final $Res Function(_ProductDto) _then;

/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? price = null,Object? discountPercentage = null,Object? rating = null,Object? stock = null,Object? thumbnail = null,Object? brand = freezed,Object? availabilityStatus = freezed,Object? warrantyInformation = freezed,Object? shippingInformation = freezed,Object? returnPolicy = freezed,Object? images = null,Object? tags = null,Object? reviews = null,}) {
  return _then(_ProductDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,availabilityStatus: freezed == availabilityStatus ? _self.availabilityStatus : availabilityStatus // ignore: cast_nullable_to_non_nullable
as String?,warrantyInformation: freezed == warrantyInformation ? _self.warrantyInformation : warrantyInformation // ignore: cast_nullable_to_non_nullable
as String?,shippingInformation: freezed == shippingInformation ? _self.shippingInformation : shippingInformation // ignore: cast_nullable_to_non_nullable
as String?,returnPolicy: freezed == returnPolicy ? _self.returnPolicy : returnPolicy // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ProductReviewDto>,
  ));
}


}


/// @nodoc
mixin _$ProductReviewDto {

 int get rating; String get comment; String get reviewerName; String? get date;
/// Create a copy of ProductReviewDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductReviewDtoCopyWith<ProductReviewDto> get copyWith => _$ProductReviewDtoCopyWithImpl<ProductReviewDto>(this as ProductReviewDto, _$identity);

  /// Serializes this ProductReviewDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductReviewDto&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,comment,reviewerName,date);

@override
String toString() {
  return 'ProductReviewDto(rating: $rating, comment: $comment, reviewerName: $reviewerName, date: $date)';
}


}

/// @nodoc
abstract mixin class $ProductReviewDtoCopyWith<$Res>  {
  factory $ProductReviewDtoCopyWith(ProductReviewDto value, $Res Function(ProductReviewDto) _then) = _$ProductReviewDtoCopyWithImpl;
@useResult
$Res call({
 int rating, String comment, String reviewerName, String? date
});




}
/// @nodoc
class _$ProductReviewDtoCopyWithImpl<$Res>
    implements $ProductReviewDtoCopyWith<$Res> {
  _$ProductReviewDtoCopyWithImpl(this._self, this._then);

  final ProductReviewDto _self;
  final $Res Function(ProductReviewDto) _then;

/// Create a copy of ProductReviewDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rating = null,Object? comment = null,Object? reviewerName = null,Object? date = freezed,}) {
  return _then(_self.copyWith(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,reviewerName: null == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductReviewDto].
extension ProductReviewDtoPatterns on ProductReviewDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductReviewDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductReviewDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductReviewDto value)  $default,){
final _that = this;
switch (_that) {
case _ProductReviewDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductReviewDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProductReviewDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rating,  String comment,  String reviewerName,  String? date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductReviewDto() when $default != null:
return $default(_that.rating,_that.comment,_that.reviewerName,_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rating,  String comment,  String reviewerName,  String? date)  $default,) {final _that = this;
switch (_that) {
case _ProductReviewDto():
return $default(_that.rating,_that.comment,_that.reviewerName,_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rating,  String comment,  String reviewerName,  String? date)?  $default,) {final _that = this;
switch (_that) {
case _ProductReviewDto() when $default != null:
return $default(_that.rating,_that.comment,_that.reviewerName,_that.date);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductReviewDto implements ProductReviewDto {
  const _ProductReviewDto({this.rating = 0, this.comment = '', this.reviewerName = '', this.date});
  factory _ProductReviewDto.fromJson(Map<String, dynamic> json) => _$ProductReviewDtoFromJson(json);

@override@JsonKey() final  int rating;
@override@JsonKey() final  String comment;
@override@JsonKey() final  String reviewerName;
@override final  String? date;

/// Create a copy of ProductReviewDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductReviewDtoCopyWith<_ProductReviewDto> get copyWith => __$ProductReviewDtoCopyWithImpl<_ProductReviewDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductReviewDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductReviewDto&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,comment,reviewerName,date);

@override
String toString() {
  return 'ProductReviewDto(rating: $rating, comment: $comment, reviewerName: $reviewerName, date: $date)';
}


}

/// @nodoc
abstract mixin class _$ProductReviewDtoCopyWith<$Res> implements $ProductReviewDtoCopyWith<$Res> {
  factory _$ProductReviewDtoCopyWith(_ProductReviewDto value, $Res Function(_ProductReviewDto) _then) = __$ProductReviewDtoCopyWithImpl;
@override @useResult
$Res call({
 int rating, String comment, String reviewerName, String? date
});




}
/// @nodoc
class __$ProductReviewDtoCopyWithImpl<$Res>
    implements _$ProductReviewDtoCopyWith<$Res> {
  __$ProductReviewDtoCopyWithImpl(this._self, this._then);

  final _ProductReviewDto _self;
  final $Res Function(_ProductReviewDto) _then;

/// Create a copy of ProductReviewDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rating = null,Object? comment = null,Object? reviewerName = null,Object? date = freezed,}) {
  return _then(_ProductReviewDto(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,reviewerName: null == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
