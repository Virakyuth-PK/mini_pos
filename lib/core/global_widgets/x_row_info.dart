import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../translation/app_locale.dart';
import '../utils/app_color.dart';
import '../utils/app_ext.dart';
import '../utils/text_size.dart';

class XRowInfo extends StatelessWidget {
  final String title;
  final String? value;
  final IconData? icon;
  final TextStyle? valueStyle;

  XRowInfo({
    super.key,
    required this.title,
    this.value,
    this.icon,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.d),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2.d,
        children: [
          Row(
            spacing: 4.d,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...[if (icon != null) Icon(icon, size: 16.d, color: hintColor)],
              SizedBox(
                width: 140.d,
                child: Text(
                  title,
                  style: XTextStyle.regular(color: AppColor.secondaryColor),
                ),
              ),
              Text(
                ":",
                style: XTextStyle.regular(color: AppColor.secondaryColor),
              ),
            ],
          ),
          Expanded(
            // width: Get.width / 2.2,
            child: Padding(
              padding: EdgeInsets.only(left: 4.d),
              child: Text(
                value ?? AppLocale.unknown.tr,
                style: valueStyle ?? XTextStyle.medium(color: textColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
