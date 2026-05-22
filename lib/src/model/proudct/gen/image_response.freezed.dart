// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../image_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageResponse {

 int? get id; set id(int? value); String? get name; set name(String? value); String? get filePath; set filePath(String? value); String? get thumbnailFilePath; set thumbnailFilePath(String? value); bool? get isThumbnail; set isThumbnail(bool? value);
/// Create a copy of ImageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageResponseCopyWith<ImageResponse> get copyWith => _$ImageResponseCopyWithImpl<ImageResponse>(this as ImageResponse, _$identity);

  /// Serializes this ImageResponse to a JSON map.
  Map<String, dynamic> toJson();




@override
String toString() {
  return 'ImageResponse(id: $id, name: $name, filePath: $filePath, thumbnailFilePath: $thumbnailFilePath, isThumbnail: $isThumbnail)';
}


}

/// @nodoc
abstract mixin class $ImageResponseCopyWith<$Res>  {
  factory $ImageResponseCopyWith(ImageResponse value, $Res Function(ImageResponse) _then) = _$ImageResponseCopyWithImpl;
@useResult
$Res call({
 int? id, String? name, String? filePath, String? thumbnailFilePath, bool? isThumbnail
});




}
/// @nodoc
class _$ImageResponseCopyWithImpl<$Res>
    implements $ImageResponseCopyWith<$Res> {
  _$ImageResponseCopyWithImpl(this._self, this._then);

  final ImageResponse _self;
  final $Res Function(ImageResponse) _then;

/// Create a copy of ImageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? filePath = freezed,Object? thumbnailFilePath = freezed,Object? isThumbnail = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,filePath: freezed == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String?,thumbnailFilePath: freezed == thumbnailFilePath ? _self.thumbnailFilePath : thumbnailFilePath // ignore: cast_nullable_to_non_nullable
as String?,isThumbnail: freezed == isThumbnail ? _self.isThumbnail : isThumbnail // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageResponse].
extension ImageResponsePatterns on ImageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageResponse value)  $default,){
final _that = this;
switch (_that) {
case _ImageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ImageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? name,  String? filePath,  String? thumbnailFilePath,  bool? isThumbnail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageResponse() when $default != null:
return $default(_that.id,_that.name,_that.filePath,_that.thumbnailFilePath,_that.isThumbnail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? name,  String? filePath,  String? thumbnailFilePath,  bool? isThumbnail)  $default,) {final _that = this;
switch (_that) {
case _ImageResponse():
return $default(_that.id,_that.name,_that.filePath,_that.thumbnailFilePath,_that.isThumbnail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? name,  String? filePath,  String? thumbnailFilePath,  bool? isThumbnail)?  $default,) {final _that = this;
switch (_that) {
case _ImageResponse() when $default != null:
return $default(_that.id,_that.name,_that.filePath,_that.thumbnailFilePath,_that.isThumbnail);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _ImageResponse implements ImageResponse {
   _ImageResponse({this.id, this.name, this.filePath, this.thumbnailFilePath, this.isThumbnail});
  factory _ImageResponse.fromJson(Map<String, dynamic> json) => _$ImageResponseFromJson(json);

@override  int? id;
@override  String? name;
@override  String? filePath;
@override  String? thumbnailFilePath;
@override  bool? isThumbnail;

/// Create a copy of ImageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageResponseCopyWith<_ImageResponse> get copyWith => __$ImageResponseCopyWithImpl<_ImageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageResponseToJson(this, );
}



@override
String toString() {
  return 'ImageResponse(id: $id, name: $name, filePath: $filePath, thumbnailFilePath: $thumbnailFilePath, isThumbnail: $isThumbnail)';
}


}

/// @nodoc
abstract mixin class _$ImageResponseCopyWith<$Res> implements $ImageResponseCopyWith<$Res> {
  factory _$ImageResponseCopyWith(_ImageResponse value, $Res Function(_ImageResponse) _then) = __$ImageResponseCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? name, String? filePath, String? thumbnailFilePath, bool? isThumbnail
});




}
/// @nodoc
class __$ImageResponseCopyWithImpl<$Res>
    implements _$ImageResponseCopyWith<$Res> {
  __$ImageResponseCopyWithImpl(this._self, this._then);

  final _ImageResponse _self;
  final $Res Function(_ImageResponse) _then;

/// Create a copy of ImageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? filePath = freezed,Object? thumbnailFilePath = freezed,Object? isThumbnail = freezed,}) {
  return _then(_ImageResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,filePath: freezed == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String?,thumbnailFilePath: freezed == thumbnailFilePath ? _self.thumbnailFilePath : thumbnailFilePath // ignore: cast_nullable_to_non_nullable
as String?,isThumbnail: freezed == isThumbnail ? _self.isThumbnail : isThumbnail // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
