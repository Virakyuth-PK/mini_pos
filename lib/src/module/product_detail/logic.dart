import 'package:get/get.dart';

import 'state.dart';

class ProductDetailLogic extends GetxController {
  final ProductDetailState state = ProductDetailState();

  @override
  void onInit() {
    var arg = Get.arguments;

    if (arg != null) {
      state.productDetail = arg;
    }
    super.onInit();
  }
}
