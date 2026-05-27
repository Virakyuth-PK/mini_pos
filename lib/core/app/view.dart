import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mini_pos/core/app/service/barcode_scanner_service.dart';
import 'package:mini_pos/core/app/state.dart';

import '../../flavors.dart';
import '../../gen/fonts.gen.dart';
import '../../route/app_route.dart';
import '../global_widgets/x_button.dart';
import '../global_widgets/x_loading.dart';
import '../utils/app_color.dart';
import '../utils/app_const.dart';
import '../utils/app_ext.dart';
import 'logic.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final AppLogic appLogic = Get.find<AppLogic>();
  final AppState appState = Get.find<AppLogic>().state;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920), // your UI design size
      minTextAdapt: true,
      child: KeyboardDismisser(
        gestures: const [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: GetMaterialApp(
          title: FConfig.name,
          themeMode: ThemeMode.system,
          theme: ThemeData(
            brightness: Brightness.light,
            fontFamily: Get.locale?.languageCode == AppConst.khmerCode
                ? FontFamily.montserrat
                : FontFamily.krasar,
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            primaryColor: AppColor.primaryColor,
            primaryColorDark: AppColor.primaryColor.darkenColor(),
            primaryColorLight: AppColor.primaryColor.lightenColor(),
            iconTheme: IconThemeData(
              color: AppColor.iconColorUnSelected,
              size: 20.d,
            ),
            hintColor: AppColor.iconColorUnSelected,
          ),
          initialRoute: AppRoute.splash,
          getPages: AppRoute.pages,
          defaultTransition: Transition.cupertino,
          debugShowCheckedModeBanner: false,
          transitionDuration: const Duration(milliseconds: 500),
          builder: EasyLoading.init(
            builder: (context, child) {
              return Overlay(
                initialEntries: [
                  if (child != null) ...[
                    OverlayEntry(
                      builder: (context) => MediaQuery(
                        data: MediaQuery.of(
                          context,
                        ).copyWith(textScaler: const TextScaler.linear(1.0)),
                        child: _flavorBanner(
                          child: LoaderOverlay(
                            overlayWidgetBuilder: (progress) => xLoading(),
                            child: GlobalBarcodeListener(child: child),
                          ),
                          show: kDebugMode == false,
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _flavorBanner({required Widget child, bool show = true}) {
    var con = show == true
        ? Banner(
            location: BannerLocation.bottomEnd,
            message: FConfig.name.toUpperCase(),
            color: AppColor.primaryColor,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              letterSpacing: 1.0,
            ),
            textDirection: TextDirection.ltr,
            child: child,
          )
        : Container(child: child);

    return con;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _easyLoadingConfig();
    });
  }

  void _easyLoadingConfig() {
    EasyLoading.instance
      ..indicatorWidget = xLoading()
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.transparent
      ..boxShadow = [const BoxShadow(color: Colors.transparent)]
      ..maskColor = Colors.black26
      ..indicatorColor = primaryColorContext(context)
      ..textColor = Colors.white
      ..progressColor = Colors.transparent
      ..maskType = EasyLoadingMaskType.custom;
  }
}
