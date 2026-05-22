import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_color.dart';
import '../utils/app_ext.dart';
import 'package:flutter/services.dart';

import '../utils/app_style.dart';

class XButton extends StatelessWidget {
  final String? toolTip;
  final GestureTapCallback? onPress;
  final GestureTapCallback? onLongPress;
  final Widget child;
  final BorderRadius? borderRadius;
  @override
  final ValueKey<String>? key;
  Color? color;

  XButton({
    this.toolTip,
    required this.onPress,
    required this.child,
    this.borderRadius,
    this.onLongPress,
    this.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: key,
      children: [
        child,
        Positioned.fill(
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(xRadiusValue),
            child: Material(
              color: Colors.transparent,
              child: toolTip == null
                  ? InkWell(
                      splashColor: color ?? _getColor(),
                      focusColor: color ?? _getColor(),
                      highlightColor: color ?? _getColor(),
                      overlayColor: WidgetStateColor.resolveWith(
                        (states) => color ?? _getColor(),
                      ),
                      onTap: () {
                        HapticFeedback.selectionClick(); // ✅ lowest haptic
                        onPress?.call();
                      },
                      onLongPress: onLongPress,
                    )
                  : Tooltip(
                      message: toolTip,
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.selectionClick(); // ✅ lowest haptic
                          onPress?.call();
                        },
                        onLongPress: onLongPress,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  _getColor() {
    if (Get.isDarkMode) {
      return Colors.white.withValues(alpha: 0.1);
    } else {
      return Theme.of(Get.context!).primaryColor.withValues(alpha: 0.1);
    }
  }
}
