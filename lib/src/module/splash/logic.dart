import 'package:get/get.dart';

import '../../../route/app_route.dart';
import 'state.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();

  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    super.onReady();
    await onAuthed();
  }

  Future<void> onAuthed() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    // Get.offNamed(AppRoute.login);
    Get.offNamed(AppRoute.home);
  }
}
