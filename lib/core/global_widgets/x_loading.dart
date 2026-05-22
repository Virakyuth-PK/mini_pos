import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

import '../../flavors.dart';
import '../../gen/assets.gen.dart';
import '../utils/app_color.dart';
import '../utils/app_ext.dart';
import '../utils/app_style.dart';

class xLoading extends StatelessWidget {
  xLoading({Key? key, this.size = 100, this.color}) : super(key: key);

  final double size;
  final Color? color;
  final listColor = [primaryColor, Colors.white];
  var borderColor = [
    Color(0xffFFCC00),
    Color(0xffD4AF37),
    Color(0xffB8860B),
    Color(0xff996515),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Padding(
        padding: xPadding(multiply: .05),
        child: ZoAnimatedGradientBorder(
          borderRadius: xRadiusValue * 2.9,
          animationCurve: Curves.linear,
          glowOpacity: 1,
          borderThickness: 1,
          gradientColor: borderColor,
          animationDuration: Duration(seconds: 2),
          child: ClipRRect(
            borderRadius: xBorderRadius,
            child: Stack(
              children: [
                Opacity(
                  opacity: .75,
                  child: AnimateGradient(
                    primaryBeginGeometry: const AlignmentDirectional(0, 1),
                    primaryEndGeometry: const AlignmentDirectional(0, 2),
                    secondaryBeginGeometry: const AlignmentDirectional(2, 0),
                    secondaryEndGeometry: const AlignmentDirectional(0, -0.8),
                    textDirectionForGeometry: TextDirection.rtl,
                    duration: Duration(seconds: 2),
                    primaryColors: listColor,
                    secondaryColors: listColor.reversed.toList(),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: .center,
                    mainAxisAlignment: .center,
                    children: [
                      Image.asset(
                        Assets.icon.logoSolidProdWhite.path,
                        width: Get.width * 0.75,
                      ),
                      LoadingAnimationWidget.stretchedDots(
                        size: 50.d,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingFullscreen {
  static void startLoading() => Get.dialog(
    xLoading(),
    useSafeArea: false,
    barrierColor: Colors.transparent,
    barrierDismissible: false,
  );

  static void stopLoading() => Get.close(1);
}
