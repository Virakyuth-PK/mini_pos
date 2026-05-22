import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mini_pos/core/utils/text_size.dart';

import '../../../gen/assets.gen.dart';
import '../../translation/app_locale.dart';
import '../utils/app_style.dart';
import 'app_color.dart' as app_color;
import 'app_ext.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({
    super.key,
    this.sizeErrorWidget,
    this.message,
    this.isNeedShowFullScreen = false,
    this.isNeedRestart = false,
    this.customWidgetError,
    this.customHeight,
    this.backgroundColor,
    this.messageTextColor,
  });

  final double? sizeErrorWidget;
  final double? customHeight;
  final String? message;
  final Widget? customWidgetError;
  final bool isNeedShowFullScreen;
  final bool isNeedRestart;
  final Color? backgroundColor;
  final Color? messageTextColor;

  @override
  Widget build(BuildContext context) {
    var content = Container(
      decoration: xBoxDecoration(
        color: backgroundColor ?? app_color.backgroundColor,
      ),
      height: isNeedShowFullScreen ? Get.height * 0.85 : customHeight,
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: (sizeErrorWidget ?? 100.0.d),
            child:
                customWidgetError ??
                SvgPicture.asset(
                  Assets.svg.emptyData,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).hintColor,
                    BlendMode.srcIn,
                  ),
                ),
          ),
          xSpaceV(size: 5.0.d),
          Text(
            message ?? AppLocale.noResultFound.tr,
            textAlign: TextAlign.center,
            style: XTextStyle.regular(
              color: messageTextColor ?? Theme.of(context).hintColor,
            ),
          ),
        ],
      ),
    );
    return content;
  }
}
