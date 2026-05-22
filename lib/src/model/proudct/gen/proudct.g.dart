// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../proudct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Proudct _$ProudctFromJson(Map<String, dynamic> json) => _Proudct(
  barcode: json['barcode'] as String?,
  oldBarcode: json['oldBarcode'],
  sku: json['sku'] as String?,
  storeId: json['storeId'] as String?,
  barcodeType: json['barcodeType'],
  nameEn: json['nameEn'] as String?,
  nameKh: json['nameKh'] as String?,
  mobileNameEn: json['mobileNameEn'],
  mobileNameKh: json['mobileNameKh'],
  divisionCode: json['divisionCode'],
  departmentCode: json['departmentCode'] as String?,
  categoryCode: json['categoryCode'] as String?,
  subCategoryCode: json['subCategoryCode'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  discountTypeId: (json['discountTypeId'] as num?)?.toInt(),
  discountValue: (json['discountValue'] as num?)?.toDouble(),
  offerPrice: (json['offerPrice'] as num?)?.toDouble(),
  isPLU: json['isPLU'] as bool?,
  thumbnailImage: json['thumbnailImage'] == null
      ? null
      : ImageResponse.fromJson(json['thumbnailImage'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProudctToJson(_Proudct instance) => <String, dynamic>{
  'barcode': instance.barcode,
  'oldBarcode': instance.oldBarcode,
  'sku': instance.sku,
  'storeId': instance.storeId,
  'barcodeType': instance.barcodeType,
  'nameEn': instance.nameEn,
  'nameKh': instance.nameKh,
  'mobileNameEn': instance.mobileNameEn,
  'mobileNameKh': instance.mobileNameKh,
  'divisionCode': instance.divisionCode,
  'departmentCode': instance.departmentCode,
  'categoryCode': instance.categoryCode,
  'subCategoryCode': instance.subCategoryCode,
  'price': instance.price,
  'discountTypeId': instance.discountTypeId,
  'discountValue': instance.discountValue,
  'offerPrice': instance.offerPrice,
  'isPLU': instance.isPLU,
  'thumbnailImage': instance.thumbnailImage?.toJson(),
};
