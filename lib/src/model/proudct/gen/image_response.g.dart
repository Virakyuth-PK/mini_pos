// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageResponse _$ImageResponseFromJson(Map<String, dynamic> json) =>
    _ImageResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      filePath: json['filePath'] as String?,
      thumbnailFilePath: json['thumbnailFilePath'] as String?,
      isThumbnail: json['isThumbnail'] as bool?,
    );

Map<String, dynamic> _$ImageResponseToJson(_ImageResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'filePath': instance.filePath,
      'thumbnailFilePath': instance.thumbnailFilePath,
      'isThumbnail': instance.isThumbnail,
    };
