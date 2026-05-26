import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/app/logic.dart';
import 'core/app/service/barcode_scanner_service.dart';
import 'core/app/view.dart';
import 'core/config/local/x_network_image_cache_manager.dart';
import 'core/config/network/interceptor/api_interceptor.dart';
import 'core/services/connection_service.dart';
import 'core/utils/app_log.dart';

Future<void> main() async {
  // screen response
  await ScreenUtil.ensureScreenSize();
  // landscape and portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initService();
  runApp(const AppPage());
}

Future<void> initService() async {
  await Get.putAsync(() => ConnectionService().init(), permanent: true);

  // delay 1 seconds to ensure context fully loaded
  await 1.delay();
  Get.put(AppLogic(), permanent: true);
  Get.put(BarcodeScannerService(), permanent: true);
  Get.put(ApiInterceptor(), permanent: true);
  await Get.putAsync(() => ConnectionService().init());
  Get.put(XNetworkImageCacheManager.instance, permanent: true);
  xLog(message: "All services started ✅");
}
