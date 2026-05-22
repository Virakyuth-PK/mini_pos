// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../promotion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PromotionResponse _$PromotionResponseFromJson(Map<String, dynamic> json) =>
    _PromotionResponse(
      id: (json['id'] as num?)?.toInt(),
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      displayHomeScreen: json['displayHomeScreen'] as bool?,
      typeId: (json['typeId'] as num?)?.toInt(),
      title: json['title'] as String?,
      detail: json['detail'] as String?,
      bannerFileId: (json['bannerFileId'] as num?)?.toInt(),
      photoFileId: (json['photoFileId'] as num?)?.toInt(),
      promotionId: json['promotionId'],
      bannerFile: json['bannerFile'] == null
          ? null
          : ImageResponse.fromJson(json['bannerFile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromotionResponseToJson(_PromotionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'displayHomeScreen': instance.displayHomeScreen,
      'typeId': instance.typeId,
      'title': instance.title,
      'detail': instance.detail,
      'bannerFileId': instance.bannerFileId,
      'photoFileId': instance.photoFileId,
      'promotionId': instance.promotionId,
      'bannerFile': instance.bannerFile?.toJson(),
    };
