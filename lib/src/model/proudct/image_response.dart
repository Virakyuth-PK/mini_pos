import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/image_response.freezed.dart';

part 'gen/image_response.g.dart';

@unfreezed
abstract class ImageResponse with _$ImageResponse {
  @JsonSerializable(fieldRename: FieldRename.none)
  factory ImageResponse({
    int? id,
    String? name,
    String? filePath,
    String? thumbnailFilePath,
    bool? isThumbnail,
  }) = _ImageResponse;

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);
}
