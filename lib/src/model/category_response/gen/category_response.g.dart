// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    _CategoryResponse(
      code: json['code'] as String?,
      nameEn: json['nameEn'] as String?,
      nameKh: json['nameKh'] as String?,
      image: json['image'] as String?,
      displayOrder: (json['displayOrder'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$CategoryResponseToJson(_CategoryResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'nameEn': instance.nameEn,
      'nameKh': instance.nameKh,
      'image': instance.image,
      'displayOrder': instance.displayOrder,
      'isActive': instance.isActive,
    };
