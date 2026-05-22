import 'dart:io';
import 'package:get/get.dart';

import '../utils/app_color.dart';
import '../utils/app_ext.dart';
import 'package:flutter/material.dart';

import '../utils/app_style.dart';
import '../utils/text_size.dart';
import 'x_button.dart';

Future xShowModalBottomSheet({
  bool useRootNavigator = true,
  bool isDismissible = true,
  bool isScrollControlled = true,
  double initialChildSize = 0.7,
  double maxChildSize = 1.0,
  double minChildSize = 0.4,
  Color? backgroundColor,
  Widget? customBottomWidget,
  bool expand = false,
  bool useSafeArea = true,
  bool isGradientBgColor = false,

  // bottom
  Color? backgroundColorBottom,
  String? bottomWidgetTitle,
  bool showBottomButton = false,
  int? bottomButtonRadius,
  Function()? onTapBottomButton,
  EdgeInsets? bottomPadding,
  required Widget Function(
    BuildContext context,
    ScrollController scrollController,
  )
  body,
}) async {
  return await showModalBottomSheet(
    context: Get.context!,
    useRootNavigator: useRootNavigator,
    useSafeArea: false,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    sheetAnimationStyle: AnimationStyle(
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      reverseCurve: Curves.easeOut,
    ),
    isScrollControlled: isScrollControlled,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) => PopScope(
      canPop: isDismissible,
      child: SafeArea(
        bottom: false,
        top: useSafeArea,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom.d,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: initialChildSize,
            maxChildSize: maxChildSize,
            minChildSize: minChildSize,
            expand: expand,
            shouldCloseOnMinExtent: isDismissible,
            builder: (context, scrollController) => Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8..d),
                  decoration: BoxDecoration(
                    color: isGradientBgColor
                        ? null
                        : backgroundColor ??
                              Theme.of(context).scaffoldBackgroundColor,
                    gradient: isGradientBgColor
                        ? xGradient(
                            colors: [
                              primaryColorLight.lightenColor(),
                              Colors.white.lightenColor(),
                              primaryColorLight.lightenColor(),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            stops: [.1, .5, .9],
                          )
                        : null,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18..d),
                      topRight: Radius.circular(18..d),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8..d),
                        child: Container(
                          height: 4..d,
                          width: 32..d,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18..d),
                            color: hintColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: SizedBox(
                            width: Get.width,
                            child: body(context, scrollController),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom:
                      (MediaQuery.of(context).viewInsets.bottom > 0 ||
                          Platform.isIOS)
                      ? 0
                      : 28.d,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.0.d),
                    padding: EdgeInsets.all(10.0.d),
                    child: showBottomButton
                        ? customBottomWidget ??
                              XButton(
                                borderRadius: BorderRadius.circular(10..d),
                                onPress: onTapBottomButton,
                                child: Container(
                                  margin: bottomPadding,
                                  height: kBottomNavigationBarHeight * 0.8,
                                  width: double.infinity,
                                  decoration: xBoxDecoration(
                                    color:
                                        backgroundColorBottom ?? primaryColor,
                                    borderRadius: BorderRadius.circular(10..d),
                                  ),
                                  child: Center(
                                    child: Text(
                                      bottomWidgetTitle ?? "Unknown",
                                      style: XTextStyle.regular(
                                        color: Theme.of(context).cardColor,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                        : SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
