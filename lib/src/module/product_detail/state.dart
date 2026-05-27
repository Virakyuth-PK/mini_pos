import '../../model/proudct/proudct.dart';

class ProductDetailState {
  Proudct? productDetail;


  String get productInfo  {
    return productDetail?.toJson().entries
        .where((e) => e.value != null && e.value.toString().isNotEmpty)
        .map((e) {
      final key = e.key
          .replaceAllMapped(
        RegExp(r'([A-Z])'),
            (match) => ' ${match.group(1)}',
      )
          .trim();

      return '$key: ${e.value}';
    })
        .join('\n') ??
        "";
  }


}
