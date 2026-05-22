import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../gen/fonts.gen.dart';
import 'app_color.dart';
import 'app_const.dart';
import 'app_ext.dart';

class XFontSize {
  static const double _base = 10;

  static double _step(int level) =>
      (Get.context == null) ? _base + (level * 2) : (_base + (level * 2)).d;

  // region Small
  ///10
  static double get xXS10 => _step(0);

  ///12
  static double get xS12 => _step(1);

  ///14
  static double get s14 => _step(2);

  // endregion

  // region Medium
  ///16
  static double get m16 => _step(3);

  ///18
  static double get l18 => _step(4);

  // endregion

  // region Large
  ///20
  static double get xL20 => _step(5);

  ///22
  static double get xxL22 => _step(6);

  ///24
  static double get xxxL24 => _step(7);

  // endregion

  // region Display / Hero
  ///26
  static double get displayS26 => _step(8);

  ///28
  static double get displayM28 => _step(9);

  ///30
  static double get displayL30 => _step(10);
  // endregion
}

class XTextStyle {
  // Private constructor to prevent instantiation
  XTextStyle._();

  // Private method to determine the color based on the theme mode
  static Color _resolveColor(Color? color) {
    return color ?? (Get.isDarkMode ? Colors.white : Color(0xff56575A));
  }

  // Default font family getter
  static String? getFontFamily() {
    return Get.locale?.languageCode == AppConst.khmerCode
        ? FontFamily.krasar
        : FontFamily.sFProDisplay;
  }

  /// Bold
  static TextStyle bold({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      fontSize: fontSize ?? XFontSize.m16,
      color: color ?? _resolveColor(color),
      fontWeight: fontWeight ?? FontWeight.bold,
      fontFamily: fontFamily ?? getFontFamily(),
    );
  }

  /// Regular
  static TextStyle regular({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      fontSize: fontSize ?? XFontSize.s14,
      color: color ?? _resolveColor(color),
      fontWeight: fontWeight ?? FontWeight.normal,
      fontFamily: fontFamily ?? getFontFamily(),
    ).copyWith();
  }

  /// Medum
  static TextStyle medium({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      fontSize: fontSize ?? XFontSize.m16,
      color: color ?? _resolveColor(color),
      fontWeight: fontWeight ?? FontWeight.normal,
      fontFamily: fontFamily ?? getFontFamily(),
    ).copyWith();
  }

  /// Medum
  static TextStyle large({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      fontSize: fontSize ?? XFontSize.xL20,
      color: color ?? _resolveColor(color),
      fontWeight: fontWeight ?? FontWeight.normal,
      fontFamily: fontFamily ?? getFontFamily(),
    ).copyWith();
  }
}
