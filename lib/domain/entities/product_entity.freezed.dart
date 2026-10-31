// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductEntity {

 int get id; String get title; String get description; String get category; double get price; double get discountPercentage; double get rating; int get stock; String get thumbnail; String? get brand; String? get availabilityStatus; String? get warrantyInformation; String? get shippingInformation; String? get returnPolicy; List<String> get images; List<String> get tags; List<ProductReviewEntity> get reviews;
/// Create a copy of ProductEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductEntityCopyWith<ProductEntity> get copyWith => _$ProductEntityCopyWithImpl<ProductEntity>(this as ProductEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.availabilityStatus, availabilityStatus) || other.availabilityStatus == availabilityStatus)&&(identical(other.warrantyInformation, warrantyInformation) || other.warrantyInformation == warrantyInformation)&&(identical(other.shippingInformation, shippingInformation) || other.shippingInformation == shippingInformation)&&(identical(other.returnPolicy, returnPolicy) || other.returnPolicy == returnPolicy)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.reviews, reviews));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,category,price,discountPercentage,rating,stock,thumbnail,brand,availabilityStatus,warrantyInformation,shippingInformation,returnPolicy,const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(reviews));

@override
String toString() {
  return 'ProductEntity(id: $id, title: $title, description: $description, category: $category, price: $price, discountPercentage: $discountPercentage, rating: $rating, stock: $stock, thumbnail: $thumbnail, brand: $brand, availabilityStatus: $availabilityStatus, warrantyInformation: $warrantyInformation, shippingInformation: $shippingInformation, returnPolicy: $returnPolicy, images: $images, tags: $tags, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class $ProductEntityCopyWith<$Res>  {
  factory $ProductEntityCopyWith(ProductEntity value, $Res Function(ProductEntity) _then) = _$ProductEntityCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, String category, double price, double discountPercentage, double rating, int stock, String thumbnail, String? brand, String? availabilityStatus, String? warrantyInformation, String? shippingInformation, String? returnPolicy, List<String> images, List<String> tags, List<ProductReviewEntity> reviews
});




}
/// @nodoc
class _$ProductEntityCopyWithImpl<$Res>
    implements $ProductEntityCopyWith<$Res> {
  _$ProductEntityCopyWithImpl(this._self, this._then);

  final ProductEntity _self;
  final $Res Function(ProductEntity) _then;

/// Create a copy of ProductEntity
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
as List<ProductReviewEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductEntity].
extension ProductEntityPatterns on ProductEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProductEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProductEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String category,  double price,  double discountPercentage,  double rating,  int stock,  String thumbnail,  String? brand,  String? availabilityStatus,  String? warrantyInformation,  String? shippingInformation,  String? returnPolicy,  List<String> images,  List<String> tags,  List<ProductReviewEntity> reviews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String category,  double price,  double discountPercentage,  double rating,  int stock,  String thumbnail,  String? brand,  String? availabilityStatus,  String? warrantyInformation,  String? shippingInformation,  String? returnPolicy,  List<String> images,  List<String> tags,  List<ProductReviewEntity> reviews)  $default,) {final _that = this;
switch (_that) {
case _ProductEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description,  String category,  double price,  double discountPercentage,  double rating,  int stock,  String thumbnail,  String? brand,  String? availabilityStatus,  String? warrantyInformation,  String? shippingInformation,  String? returnPolicy,  List<String> images,  List<String> tags,  List<ProductReviewEntity> reviews)?  $default,) {final _that = this;
switch (_that) {
case _ProductEntity() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.price,_that.discountPercentage,_that.rating,_that.stock,_that.thumbnail,_that.brand,_that.availabilityStatus,_that.warrantyInformation,_that.shippingInformation,_that.returnPolicy,_that.images,_that.tags,_that.reviews);case _:
  return null;

}
}

}

/// @nodoc


class _ProductEntity implements ProductEntity {
  const _ProductEntity({required this.id, required this.title, required this.description, required this.category, required this.price, required this.discountPercentage, required this.rating, required this.stock, required this.thumbnail, this.brand, this.availabilityStatus, this.warrantyInformation, this.shippingInformation, this.returnPolicy, final  List<String> images = const [], final  List<String> tags = const [], final  List<ProductReviewEntity> reviews = const []}): _images = images,_tags = tags,_reviews = reviews;
  

@override final  int id;
@override final  String title;
@override final  String description;
@override final  String category;
@override final  double price;
@override final  double discountPercentage;
@override final  double rating;
@override final  int stock;
@override final  String thumbnail;
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

 final  List<ProductReviewEntity> _reviews;
@override@JsonKey() List<ProductReviewEntity> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}


/// Create a copy of ProductEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductEntityCopyWith<_ProductEntity> get copyWith => __$ProductEntityCopyWithImpl<_ProductEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.availabilityStatus, availabilityStatus) || other.availabilityStatus == availabilityStatus)&&(identical(other.warrantyInformation, warrantyInformation) || other.warrantyInformation == warrantyInformation)&&(identical(other.shippingInformation, shippingInformation) || other.shippingInformation == shippingInformation)&&(identical(other.returnPolicy, returnPolicy) || other.returnPolicy == returnPolicy)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._reviews, _reviews));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,category,price,discountPercentage,rating,stock,thumbnail,brand,availabilityStatus,warrantyInformation,shippingInformation,returnPolicy,const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_reviews));

@override
String toString() {
  return 'ProductEntity(id: $id, title: $title, description: $description, category: $category, price: $price, discountPercentage: $discountPercentage, rating: $rating, stock: $stock, thumbnail: $thumbnail, brand: $brand, availabilityStatus: $availabilityStatus, warrantyInformation: $warrantyInformation, shippingInformation: $shippingInformation, returnPolicy: $returnPolicy, images: $images, tags: $tags, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class _$ProductEntityCopyWith<$Res> implements $ProductEntityCopyWith<$Res> {
  factory _$ProductEntityCopyWith(_ProductEntity value, $Res Function(_ProductEntity) _then) = __$ProductEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description, String category, double price, double discountPercentage, double rating, int stock, String thumbnail, String? brand, String? availabilityStatus, String? warrantyInformation, String? shippingInformation, String? returnPolicy, List<String> images, List<String> tags, List<ProductReviewEntity> reviews
});




}
/// @nodoc
class __$ProductEntityCopyWithImpl<$Res>
    implements _$ProductEntityCopyWith<$Res> {
  __$ProductEntityCopyWithImpl(this._self, this._then);

  final _ProductEntity _self;
  final $Res Function(_ProductEntity) _then;

/// Create a copy of ProductEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? price = null,Object? discountPercentage = null,Object? rating = null,Object? stock = null,Object? thumbnail = null,Object? brand = freezed,Object? availabilityStatus = freezed,Object? warrantyInformation = freezed,Object? shippingInformation = freezed,Object? returnPolicy = freezed,Object? images = null,Object? tags = null,Object? reviews = null,}) {
  return _then(_ProductEntity(
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
as List<ProductReviewEntity>,
  ));
}


}

/// @nodoc
mixin _$ProductReviewEntity {

 int get rating; String get comment; String get reviewerName; DateTime? get date;
/// Create a copy of ProductReviewEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductReviewEntityCopyWith<ProductReviewEntity> get copyWith => _$ProductReviewEntityCopyWithImpl<ProductReviewEntity>(this as ProductReviewEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductReviewEntity&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,rating,comment,reviewerName,date);

@override
String toString() {
  return 'ProductReviewEntity(rating: $rating, comment: $comment, reviewerName: $reviewerName, date: $date)';
}


}

/// @nodoc
abstract mixin class $ProductReviewEntityCopyWith<$Res>  {
  factory $ProductReviewEntityCopyWith(ProductReviewEntity value, $Res Function(ProductReviewEntity) _then) = _$ProductReviewEntityCopyWithImpl;
@useResult
$Res call({
 int rating, String comment, String reviewerName, DateTime? date
});




}
/// @nodoc
class _$ProductReviewEntityCopyWithImpl<$Res>
    implements $ProductReviewEntityCopyWith<$Res> {
  _$ProductReviewEntityCopyWithImpl(this._self, this._then);

  final ProductReviewEntity _self;
  final $Res Function(ProductReviewEntity) _then;

/// Create a copy of ProductReviewEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rating = null,Object? comment = null,Object? reviewerName = null,Object? date = freezed,}) {
  return _then(_self.copyWith(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,reviewerName: null == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductReviewEntity].
extension ProductReviewEntityPatterns on ProductReviewEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductReviewEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductReviewEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductReviewEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProductReviewEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductReviewEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProductReviewEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rating,  String comment,  String reviewerName,  DateTime? date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductReviewEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rating,  String comment,  String reviewerName,  DateTime? date)  $default,) {final _that = this;
switch (_that) {
case _ProductReviewEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rating,  String comment,  String reviewerName,  DateTime? date)?  $default,) {final _that = this;
switch (_that) {
case _ProductReviewEntity() when $default != null:
return $default(_that.rating,_that.comment,_that.reviewerName,_that.date);case _:
  return null;

}
}

}

/// @nodoc


class _ProductReviewEntity implements ProductReviewEntity {
  const _ProductReviewEntity({required this.rating, required this.comment, required this.reviewerName, this.date});
  

@override final  int rating;
@override final  String comment;
@override final  String reviewerName;
@override final  DateTime? date;

/// Create a copy of ProductReviewEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductReviewEntityCopyWith<_ProductReviewEntity> get copyWith => __$ProductReviewEntityCopyWithImpl<_ProductReviewEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductReviewEntity&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,rating,comment,reviewerName,date);

@override
String toString() {
  return 'ProductReviewEntity(rating: $rating, comment: $comment, reviewerName: $reviewerName, date: $date)';
}


}

/// @nodoc
abstract mixin class _$ProductReviewEntityCopyWith<$Res> implements $ProductReviewEntityCopyWith<$Res> {
  factory _$ProductReviewEntityCopyWith(_ProductReviewEntity value, $Res Function(_ProductReviewEntity) _then) = __$ProductReviewEntityCopyWithImpl;
@override @useResult
$Res call({
 int rating, String comment, String reviewerName, DateTime? date
});




}
/// @nodoc
class __$ProductReviewEntityCopyWithImpl<$Res>
    implements _$ProductReviewEntityCopyWith<$Res> {
  __$ProductReviewEntityCopyWithImpl(this._self, this._then);

  final _ProductReviewEntity _self;
  final $Res Function(_ProductReviewEntity) _then;

/// Create a copy of ProductReviewEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rating = null,Object? comment = null,Object? reviewerName = null,Object? date = freezed,}) {
  return _then(_ProductReviewEntity(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,reviewerName: null == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$ProductPageEntity {

 List<ProductEntity> get products; int get total; int get skip;
/// Create a copy of ProductPageEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductPageEntityCopyWith<ProductPageEntity> get copyWith => _$ProductPageEntityCopyWithImpl<ProductPageEntity>(this as ProductPageEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductPageEntity&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(products),total,skip);

@override
String toString() {
  return 'ProductPageEntity(products: $products, total: $total, skip: $skip)';
}


}

/// @nodoc
abstract mixin class $ProductPageEntityCopyWith<$Res>  {
  factory $ProductPageEntityCopyWith(ProductPageEntity value, $Res Function(ProductPageEntity) _then) = _$ProductPageEntityCopyWithImpl;
@useResult
$Res call({
 List<ProductEntity> products, int total, int skip
});




}
/// @nodoc
class _$ProductPageEntityCopyWithImpl<$Res>
    implements $ProductPageEntityCopyWith<$Res> {
  _$ProductPageEntityCopyWithImpl(this._self, this._then);

  final ProductPageEntity _self;
  final $Res Function(ProductPageEntity) _then;

/// Create a copy of ProductPageEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? products = null,Object? total = null,Object? skip = null,}) {
  return _then(_self.copyWith(
products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,skip: null == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductPageEntity].
extension ProductPageEntityPatterns on ProductPageEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductPageEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductPageEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductPageEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProductPageEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductPageEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProductPageEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProductEntity> products,  int total,  int skip)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductPageEntity() when $default != null:
return $default(_that.products,_that.total,_that.skip);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProductEntity> products,  int total,  int skip)  $default,) {final _that = this;
switch (_that) {
case _ProductPageEntity():
return $default(_that.products,_that.total,_that.skip);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProductEntity> products,  int total,  int skip)?  $default,) {final _that = this;
switch (_that) {
case _ProductPageEntity() when $default != null:
return $default(_that.products,_that.total,_that.skip);case _:
  return null;

}
}

}

/// @nodoc


class _ProductPageEntity implements ProductPageEntity {
  const _ProductPageEntity({required final  List<ProductEntity> products, required this.total, required this.skip}): _products = products;
  

 final  List<ProductEntity> _products;
@override List<ProductEntity> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override final  int total;
@override final  int skip;

/// Create a copy of ProductPageEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductPageEntityCopyWith<_ProductPageEntity> get copyWith => __$ProductPageEntityCopyWithImpl<_ProductPageEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductPageEntity&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),total,skip);

@override
String toString() {
  return 'ProductPageEntity(products: $products, total: $total, skip: $skip)';
}


}

/// @nodoc
abstract mixin class _$ProductPageEntityCopyWith<$Res> implements $ProductPageEntityCopyWith<$Res> {
  factory _$ProductPageEntityCopyWith(_ProductPageEntity value, $Res Function(_ProductPageEntity) _then) = __$ProductPageEntityCopyWithImpl;
@override @useResult
$Res call({
 List<ProductEntity> products, int total, int skip
});




}
/// @nodoc
class __$ProductPageEntityCopyWithImpl<$Res>
    implements _$ProductPageEntityCopyWith<$Res> {
  __$ProductPageEntityCopyWithImpl(this._self, this._then);

  final _ProductPageEntity _self;
  final $Res Function(_ProductPageEntity) _then;

/// Create a copy of ProductPageEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? products = null,Object? total = null,Object? skip = null,}) {
  return _then(_ProductPageEntity(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,skip: null == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
