import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mini_pos/core/utils/text_size.dart';

import 'package:toastification/toastification.dart';
import '../../gen/assets.gen.dart';
import '../global_widgets/x_button.dart';
import '../utils/app_color.dart';
import '../utils/app_ext.dart';
import '../utils/app_style.dart';

xSnackBar({
  required String title,
  required String message,
  Color? backgroundColor,
  Color? textColor,
  Widget? icon,
  Widget? iconTrailing,
  Duration? autoCloseDuration,
  Decoration? decoration,
  int? maxLine = 10,
  Function()? onPress,
}) {
  toastification.show(
    dismissDirection: DismissDirection.vertical,
    closeButton: ToastCloseButton(
      buttonBuilder: (context, onClose) => XButton(
        onPress: () => onClose(),
        onLongPress: () => toastification.dismissAll(),
        child: Center(
          child: Icon(CupertinoIcons.clear, color: hintColor, size: 20.d),
        ),
      ),
    ),
    callbacks: ToastificationCallbacks(
      onTap: (value) {
        if (onPress != null) {
          onPress();
        }
      },
    ),
    autoCloseDuration: autoCloseDuration ?? Duration(seconds: 2),
    context: Get.context,
    title: Text(
      title,
      style: XTextStyle.regular(fontWeight: FontWeight.bold, color: textColor),
    ),
    description: Text(
      message,
      style: XTextStyle.regular(color: textColor, fontSize: XFontSize.xS12),
      maxLines: maxLine,
    ),
    dragToClose: true,
    style: ToastificationStyle.flat,
    backgroundColor: backgroundColor,
    margin: EdgeInsets.symmetric(horizontal: 1.d),
    alignment: Alignment.topCenter,
    icon: icon ?? Image.asset(Assets.icon.logoSolidProdWhite.path, width: 30.d),
    type: ToastificationType.custom(
      title,
      primaryColor,
      Icons.warning_amber_rounded,
    ),
  );
}
