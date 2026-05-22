import 'package:get/get.dart';
import 'package:mini_pos/src/data/repo/product_repo.dart';

import '../../data/repo/promotion_repo.dart';
import 'logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PromotionRepo());
    Get.lazyPut(() => ProductRepo());
    Get.lazyPut(() => HomeLogic());
  }
}
