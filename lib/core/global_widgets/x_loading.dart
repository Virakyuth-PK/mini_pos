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
    return Center(
      child:  Image.asset(
        // Assets.icon.logoSolidDevWhite.path,
        Assets.gif.cmrtLoading.path,
        width: Get.width * 0.25,
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
