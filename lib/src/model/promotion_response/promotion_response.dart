import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mini_pos/src/model/proudct/image_response.dart';

part 'gen/promotion_response.freezed.dart';

part 'gen/promotion_response.g.dart';

@unfreezed
abstract class PromotionResponse with _$PromotionResponse {
  @JsonSerializable(fieldRename: FieldRename.none)
  factory PromotionResponse({
    int? id,
    String? startDate,
    String? endDate,
    bool? displayHomeScreen,
    int? typeId,
    String? title,
    String? detail,
    int? bannerFileId,
    int? photoFileId,
    dynamic promotionId,
    ImageResponse? bannerFile,
  }) = _PromotionResponse;

  factory PromotionResponse.fromJson(Map<String, dynamic> json) =>
      _$PromotionResponseFromJson(json);
}
