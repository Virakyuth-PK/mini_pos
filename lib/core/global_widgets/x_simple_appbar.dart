import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../utils/app_color.dart' as app_color;
import '../utils/app_ext.dart';
import '../utils/app_style.dart';
import '../utils/text_size.dart';

class XSimpleAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? iconColor;
  final Widget? leadingWidget;
  final Function()? onBack;
  final int? titleMaxLine;
  final bool centerTitle;

  const XSimpleAppbar({
    super.key,
    required this.title,
    this.actions,
    this.iconColor,
    this.leadingWidget,
    this.backgroundColor,
    this.titleColor,
    this.onBack,
    this.centerTitle = true,
    this.titleMaxLine,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:
          leadingWidget ??
          IconButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateColor.resolveWith(
                (states) => Colors.white12,
              ),
            ),
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 30.0.d,
              color: iconColor ?? Colors.white,
            ),
            onPressed:
                onBack ??
                () {
                  HapticFeedback.selectionClick(); // ✅ lowest haptic
                  Get.back();
                },
          ),
      backgroundColor: backgroundColor ?? app_color.primaryColor,
      surfaceTintColor: backgroundColor ?? app_color.primaryColor,
      shadowColor: app_color.shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(xRadiusValue),
          bottomRight: Radius.circular(xRadiusValue),
        ),
      ),
      title: Text(
        title,
        maxLines: titleMaxLine ?? 1,
        style: XTextStyle.large(
          fontWeight: FontWeight.w500,
          color: titleColor ?? Colors.white,
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
    );
  }
}
