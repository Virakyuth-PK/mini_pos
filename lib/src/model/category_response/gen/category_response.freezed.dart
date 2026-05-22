// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../category_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryResponse {

 String? get code; set code(String? value); String? get nameEn; set nameEn(String? value); String? get nameKh; set nameKh(String? value); String? get image; set image(String? value); int? get displayOrder; set displayOrder(int? value); bool? get isActive; set isActive(bool? value);
/// Create a copy of CategoryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryResponseCopyWith<CategoryResponse> get copyWith => _$CategoryResponseCopyWithImpl<CategoryResponse>(this as CategoryResponse, _$identity);

  /// Serializes this CategoryResponse to a JSON map.
  Map<String, dynamic> toJson();




@override
String toString() {
  return 'CategoryResponse(code: $code, nameEn: $nameEn, nameKh: $nameKh, image: $image, displayOrder: $displayOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $CategoryResponseCopyWith<$Res>  {
  factory $CategoryResponseCopyWith(CategoryResponse value, $Res Function(CategoryResponse) _then) = _$CategoryResponseCopyWithImpl;
@useResult
$Res call({
 String? code, String? nameEn, String? nameKh, String? image, int? displayOrder, bool? isActive
});




}
/// @nodoc
class _$CategoryResponseCopyWithImpl<$Res>
    implements $CategoryResponseCopyWith<$Res> {
  _$CategoryResponseCopyWithImpl(this._self, this._then);

  final CategoryResponse _self;
  final $Res Function(CategoryResponse) _then;

/// Create a copy of CategoryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? nameEn = freezed,Object? nameKh = freezed,Object? image = freezed,Object? displayOrder = freezed,Object? isActive = freezed,}) {
  return _then(_self.copyWith(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,nameKh: freezed == nameKh ? _self.nameKh : nameKh // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: freezed == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryResponse].
extension CategoryResponsePatterns on CategoryResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryResponse value)  $default,){
final _that = this;
switch (_that) {
case _CategoryResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? code,  String? nameEn,  String? nameKh,  String? image,  int? displayOrder,  bool? isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryResponse() when $default != null:
return $default(_that.code,_that.nameEn,_that.nameKh,_that.image,_that.displayOrder,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? code,  String? nameEn,  String? nameKh,  String? image,  int? displayOrder,  bool? isActive)  $default,) {final _that = this;
switch (_that) {
case _CategoryResponse():
return $default(_that.code,_that.nameEn,_that.nameKh,_that.image,_that.displayOrder,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? code,  String? nameEn,  String? nameKh,  String? image,  int? displayOrder,  bool? isActive)?  $default,) {final _that = this;
switch (_that) {
case _CategoryResponse() when $default != null:
return $default(_that.code,_that.nameEn,_that.nameKh,_that.image,_that.displayOrder,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _CategoryResponse implements CategoryResponse {
   _CategoryResponse({this.code, this.nameEn, this.nameKh, this.image, this.displayOrder, this.isActive});
  factory _CategoryResponse.fromJson(Map<String, dynamic> json) => _$CategoryResponseFromJson(json);

@override  String? code;
@override  String? nameEn;
@override  String? nameKh;
@override  String? image;
@override  int? displayOrder;
@override  bool? isActive;

/// Create a copy of CategoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryResponseCopyWith<_CategoryResponse> get copyWith => __$CategoryResponseCopyWithImpl<_CategoryResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryResponseToJson(this, );
}



@override
String toString() {
  return 'CategoryResponse(code: $code, nameEn: $nameEn, nameKh: $nameKh, image: $image, displayOrder: $displayOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$CategoryResponseCopyWith<$Res> implements $CategoryResponseCopyWith<$Res> {
  factory _$CategoryResponseCopyWith(_CategoryResponse value, $Res Function(_CategoryResponse) _then) = __$CategoryResponseCopyWithImpl;
@override @useResult
$Res call({
 String? code, String? nameEn, String? nameKh, String? image, int? displayOrder, bool? isActive
});




}
/// @nodoc
class __$CategoryResponseCopyWithImpl<$Res>
    implements _$CategoryResponseCopyWith<$Res> {
  __$CategoryResponseCopyWithImpl(this._self, this._then);

  final _CategoryResponse _self;
  final $Res Function(_CategoryResponse) _then;

/// Create a copy of CategoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? nameEn = freezed,Object? nameKh = freezed,Object? image = freezed,Object? displayOrder = freezed,Object? isActive = freezed,}) {
  return _then(_CategoryResponse(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,nameKh: freezed == nameKh ? _self.nameKh : nameKh // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: freezed == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
