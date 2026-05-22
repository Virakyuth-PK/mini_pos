import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mini_pos/src/model/proudct/image_response.dart';

part 'gen/proudct.freezed.dart';

part 'gen/proudct.g.dart';

@unfreezed
abstract class Proudct with _$Proudct {
  @JsonSerializable(fieldRename: FieldRename.none)
  factory Proudct({
    String? barcode,
    dynamic oldBarcode,
    String? sku,
    String? storeId,
    dynamic barcodeType,
    String? nameEn,
    String? nameKh,
    dynamic mobileNameEn,
    dynamic mobileNameKh,
    dynamic divisionCode,
    String? departmentCode,
    String? categoryCode,
    String? subCategoryCode,
    double? price,
    ImageResponse? thumbnailImage,
  }) = _Proudct;

  factory Proudct.fromJson(Map<String, dynamic> json) =>
      _$ProudctFromJson(json);
}
