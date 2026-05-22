import 'package:get/get.dart';
import 'package:mini_pos/src/data/repo/product_repo.dart';

import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  final ProductRepo _productRepo = Get.find<ProductRepo>();

  void onChangeCategory(int index) {
    state.currentIndex.value = index;
    update();
  }
}
