import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/category_response.freezed.dart';

part 'gen/category_response.g.dart';

@unfreezed
abstract class CategoryResponse with _$CategoryResponse {
  @JsonSerializable(fieldRename: FieldRename.none)
  factory CategoryResponse({
    String? code,
    String? nameEn,
    String? nameKh,
    String? image,
    int? displayOrder,
    bool? isActive,
  }) = _CategoryResponse;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
}
