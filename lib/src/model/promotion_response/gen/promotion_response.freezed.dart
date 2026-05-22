// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../promotion_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PromotionResponse {

 int? get id; set id(int? value); String? get startDate; set startDate(String? value); String? get endDate; set endDate(String? value); bool? get displayHomeScreen; set displayHomeScreen(bool? value); int? get typeId; set typeId(int? value); String? get title; set title(String? value); String? get detail; set detail(String? value); int? get bannerFileId; set bannerFileId(int? value); int? get photoFileId; set photoFileId(int? value); dynamic get promotionId; set promotionId(dynamic value); ImageResponse? get bannerFile; set bannerFile(ImageResponse? value);
/// Create a copy of PromotionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PromotionResponseCopyWith<PromotionResponse> get copyWith => _$PromotionResponseCopyWithImpl<PromotionResponse>(this as PromotionResponse, _$identity);

  /// Serializes this PromotionResponse to a JSON map.
  Map<String, dynamic> toJson();




@override
String toString() {
  return 'PromotionResponse(id: $id, startDate: $startDate, endDate: $endDate, displayHomeScreen: $displayHomeScreen, typeId: $typeId, title: $title, detail: $detail, bannerFileId: $bannerFileId, photoFileId: $photoFileId, promotionId: $promotionId, bannerFile: $bannerFile)';
}


}

/// @nodoc
abstract mixin class $PromotionResponseCopyWith<$Res>  {
  factory $PromotionResponseCopyWith(PromotionResponse value, $Res Function(PromotionResponse) _then) = _$PromotionResponseCopyWithImpl;
@useResult
$Res call({
 int? id, String? startDate, String? endDate, bool? displayHomeScreen, int? typeId, String? title, String? detail, int? bannerFileId, int? photoFileId, dynamic promotionId, ImageResponse? bannerFile
});


$ImageResponseCopyWith<$Res>? get bannerFile;

}
/// @nodoc
class _$PromotionResponseCopyWithImpl<$Res>
    implements $PromotionResponseCopyWith<$Res> {
  _$PromotionResponseCopyWithImpl(this._self, this._then);

  final PromotionResponse _self;
  final $Res Function(PromotionResponse) _then;

/// Create a copy of PromotionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? displayHomeScreen = freezed,Object? typeId = freezed,Object? title = freezed,Object? detail = freezed,Object? bannerFileId = freezed,Object? photoFileId = freezed,Object? promotionId = freezed,Object? bannerFile = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,displayHomeScreen: freezed == displayHomeScreen ? _self.displayHomeScreen : displayHomeScreen // ignore: cast_nullable_to_non_nullable
as bool?,typeId: freezed == typeId ? _self.typeId : typeId // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,bannerFileId: freezed == bannerFileId ? _self.bannerFileId : bannerFileId // ignore: cast_nullable_to_non_nullable
as int?,photoFileId: freezed == photoFileId ? _self.photoFileId : photoFileId // ignore: cast_nullable_to_non_nullable
as int?,promotionId: freezed == promotionId ? _self.promotionId : promotionId // ignore: cast_nullable_to_non_nullable
as dynamic,bannerFile: freezed == bannerFile ? _self.bannerFile : bannerFile // ignore: cast_nullable_to_non_nullable
as ImageResponse?,
  ));
}
/// Create a copy of PromotionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImageResponseCopyWith<$Res>? get bannerFile {
    if (_self.bannerFile == null) {
    return null;
  }

  return $ImageResponseCopyWith<$Res>(_self.bannerFile!, (value) {
    return _then(_self.copyWith(bannerFile: value));
  });
}
}


/// Adds pattern-matching-related methods to [PromotionResponse].
extension PromotionResponsePatterns on PromotionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PromotionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PromotionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PromotionResponse value)  $default,){
final _that = this;
switch (_that) {
case _PromotionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PromotionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PromotionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? startDate,  String? endDate,  bool? displayHomeScreen,  int? typeId,  String? title,  String? detail,  int? bannerFileId,  int? photoFileId,  dynamic promotionId,  ImageResponse? bannerFile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PromotionResponse() when $default != null:
return $default(_that.id,_that.startDate,_that.endDate,_that.displayHomeScreen,_that.typeId,_that.title,_that.detail,_that.bannerFileId,_that.photoFileId,_that.promotionId,_that.bannerFile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? startDate,  String? endDate,  bool? displayHomeScreen,  int? typeId,  String? title,  String? detail,  int? bannerFileId,  int? photoFileId,  dynamic promotionId,  ImageResponse? bannerFile)  $default,) {final _that = this;
switch (_that) {
case _PromotionResponse():
return $default(_that.id,_that.startDate,_that.endDate,_that.displayHomeScreen,_that.typeId,_that.title,_that.detail,_that.bannerFileId,_that.photoFileId,_that.promotionId,_that.bannerFile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? startDate,  String? endDate,  bool? displayHomeScreen,  int? typeId,  String? title,  String? detail,  int? bannerFileId,  int? photoFileId,  dynamic promotionId,  ImageResponse? bannerFile)?  $default,) {final _that = this;
switch (_that) {
case _PromotionResponse() when $default != null:
return $default(_that.id,_that.startDate,_that.endDate,_that.displayHomeScreen,_that.typeId,_that.title,_that.detail,_that.bannerFileId,_that.photoFileId,_that.promotionId,_that.bannerFile);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _PromotionResponse implements PromotionResponse {
   _PromotionResponse({this.id, this.startDate, this.endDate, this.displayHomeScreen, this.typeId, this.title, this.detail, this.bannerFileId, this.photoFileId, this.promotionId, this.bannerFile});
  factory _PromotionResponse.fromJson(Map<String, dynamic> json) => _$PromotionResponseFromJson(json);

@override  int? id;
@override  String? startDate;
@override  String? endDate;
@override  bool? displayHomeScreen;
@override  int? typeId;
@override  String? title;
@override  String? detail;
@override  int? bannerFileId;
@override  int? photoFileId;
@override  dynamic promotionId;
@override  ImageResponse? bannerFile;

/// Create a copy of PromotionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PromotionResponseCopyWith<_PromotionResponse> get copyWith => __$PromotionResponseCopyWithImpl<_PromotionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PromotionResponseToJson(this, );
}



@override
String toString() {
  return 'PromotionResponse(id: $id, startDate: $startDate, endDate: $endDate, displayHomeScreen: $displayHomeScreen, typeId: $typeId, title: $title, detail: $detail, bannerFileId: $bannerFileId, photoFileId: $photoFileId, promotionId: $promotionId, bannerFile: $bannerFile)';
}


}

/// @nodoc
abstract mixin class _$PromotionResponseCopyWith<$Res> implements $PromotionResponseCopyWith<$Res> {
  factory _$PromotionResponseCopyWith(_PromotionResponse value, $Res Function(_PromotionResponse) _then) = __$PromotionResponseCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? startDate, String? endDate, bool? displayHomeScreen, int? typeId, String? title, String? detail, int? bannerFileId, int? photoFileId, dynamic promotionId, ImageResponse? bannerFile
});


@override $ImageResponseCopyWith<$Res>? get bannerFile;

}
/// @nodoc
class __$PromotionResponseCopyWithImpl<$Res>
    implements _$PromotionResponseCopyWith<$Res> {
  __$PromotionResponseCopyWithImpl(this._self, this._then);

  final _PromotionResponse _self;
  final $Res Function(_PromotionResponse) _then;

/// Create a copy of PromotionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? displayHomeScreen = freezed,Object? typeId = freezed,Object? title = freezed,Object? detail = freezed,Object? bannerFileId = freezed,Object? photoFileId = freezed,Object? promotionId = freezed,Object? bannerFile = freezed,}) {
  return _then(_PromotionResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,displayHomeScreen: freezed == displayHomeScreen ? _self.displayHomeScreen : displayHomeScreen // ignore: cast_nullable_to_non_nullable
as bool?,typeId: freezed == typeId ? _self.typeId : typeId // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,bannerFileId: freezed == bannerFileId ? _self.bannerFileId : bannerFileId // ignore: cast_nullable_to_non_nullable
as int?,photoFileId: freezed == photoFileId ? _self.photoFileId : photoFileId // ignore: cast_nullable_to_non_nullable
as int?,promotionId: freezed == promotionId ? _self.promotionId : promotionId // ignore: cast_nullable_to_non_nullable
as dynamic,bannerFile: freezed == bannerFile ? _self.bannerFile : bannerFile // ignore: cast_nullable_to_non_nullable
as ImageResponse?,
  ));
}

/// Create a copy of PromotionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImageResponseCopyWith<$Res>? get bannerFile {
    if (_self.bannerFile == null) {
    return null;
  }

  return $ImageResponseCopyWith<$Res>(_self.bannerFile!, (value) {
    return _then(_self.copyWith(bannerFile: value));
  });
}
}

// dart format on
