import 'dart:ui';

import 'package:get/get.dart';
import '../utils/app_const.dart';
import 'state.dart';

class AppLogic extends GetxController {
  final AppState state = AppState();

  @override
  Future<void> onInit() async {
    super.onInit();
    await Get.updateLocale(Locale(AppConst.khmerCode));
  }

  @override
  onReady() async {
    // await getUser();
    super.onReady();
  }

  Future<void> logoutFunction() async {}

  // Future<void> getUser({String? userId}) async {
  //   final userResponse = await LoginLocal().getData();
  //   if (userResponse != null) {
  //     state.userResponse = userResponse;
  //     update();
  //   }
  // }
}
