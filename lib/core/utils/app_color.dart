// ignore: unnecessary_import
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/logic.dart';

//region App Color

ThemeData get themeData => Theme.of(Get.context!);

Color primaryColorContext([BuildContext? context]) {
  return Theme.of(context ?? Get.context!).primaryColor;
}

ColorScheme get colorScheme => Theme.of(Get.context!).colorScheme;

Color get primaryColor => primaryColorContext(Get.context!);

Color get primaryColorLight => themeData.primaryColorLight;

Color get primaryColorDark => themeData.primaryColorDark;

Color get backgroundColor => themeData.scaffoldBackgroundColor;

Color get iconColor => themeData.iconTheme.color!;

Color get hintColor => themeData.hintColor;

Color get shadowColor => themeData.shadowColor;

Color get cardColor => themeData.cardColor;

Color get errorColor => Colors.red;

Color get textColor => Get.isDarkMode ? Colors.white : Colors.black;

Color get borderColor => Get.isDarkMode ? Colors.white : Colors.black;

Color get shimmerColor => Get.isDarkMode ? Colors.white : Colors.black;
//endregion

class AppColor {
  static const Color secondaryColor = Color(0xff263238);
  static const Color white = Colors.white;

  // static const Color primaryDarkColor = Color(0xff00602C);
  static const Color primaryColor = CompanyColor.CHIPMONG_RETAIL;
  static const Color hintColor = Color(0xff999999);
  static const Color blue = Color(0xff16478E);
  static const Color reject = Color(0xffDD7176);
  static const Color approve = Color(0xff54B4FF);
  static const Color disableColor = Color(0xffbababa);
  static const Color completeColor = Color(0xff00A63E);
  static const Color pendingColor = Color(0xffF18A00);

  static var cancelColor = Color(0xffd3d3d3);

  static const Color warningColor = Color(0xffF2B705);
  static const Color errorColor = Color(0xffff0b0b);
  static const Color successColor = Color(0xff34C759);

  static const Color elearnColor = Color(0xFFAD93DE);
  static const Color secondaryPrimarySchool = Color(0xFFE6EAFF);

  static Color? scaffoldBackgroundColor = Color(0x13603294);
  static Color? iconColor = Color(0xff393E53);
  static Color? iconColorUnSelected = Color(0xff99A1AF);
  static Color? iconColorWhite = Color(0xffffffff);
  static Color? cardPrimaryColor = Color(0xFFF0FDF4);
  static Color? cardSecondaryColor = Color(0xFFDCFCE7);
  static Color? blueLight = Color(0xFFDBEAFE);

  static Color? disabledColor = Color(0xFFF9FAFB);
}

class CompanyColor {
  static const CHIPMONG_GROUP = Color(0xFF009041);
  static const CHIPMONG_INDUSTRIES = Color(0xFFF15323);
  static const CHIPMONG_INSEE = Color(0xFFD51F36);
  static const CHIPMONG_RETAIL = Color(0xFFE0115F);
  static const CHIPMONG_LAND = Color(0xFF16478E);
  static const CHIPMONG_TRADING = Color(0xFF958C8D);
  static const KHMER_BEVERAGES = Color(0xFFD51F36);
  static const CHIPMONG_CMCG = Color(0xFF603294);
}
