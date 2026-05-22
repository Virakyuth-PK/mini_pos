import 'package:get/get.dart';

import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  void onChangeCategory(int index) {
    state.currentIndex.value = index;
    update();
  }
}
