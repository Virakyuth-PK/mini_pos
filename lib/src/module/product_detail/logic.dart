import 'package:get/get.dart';

import '../../../core/services/gemini_service.dart';
import 'state.dart';

class ProductDetailLogic extends GetxController {
  final ProductDetailState state = ProductDetailState();

  @override
  void onInit() {
    var arg = Get.arguments;

    if (arg != null) {
      state.productDetail = arg;
      update();
    }
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    // await ProductDetailAiClient().askAiAboutProduct(
    //   rawProductJson: state.productDetail!.toJson(),
    //   userQuestion: "How to use this product?",
    // );
  }
}
