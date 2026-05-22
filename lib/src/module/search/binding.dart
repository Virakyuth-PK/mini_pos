import 'package:get/get.dart';
import 'package:mini_pos/src/data/repo/product_repo.dart';

import 'logic.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductRepo());
    Get.lazyPut(() => SearchLogic());
  }
}
