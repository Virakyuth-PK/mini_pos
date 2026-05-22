import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../translation/app_locale.dart';
import '../utils/app_color.dart';
import '../utils/app_ext.dart';
import '../utils/text_size.dart';

class XColumInfo extends StatelessWidget {
  final String? title;
  final String? value;
  final IconData? icon;
  final double? width;

  const XColumInfo({super.key, this.title, this.value, this.icon, this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2.d,
      children: [
        Row(
          spacing: 4.d,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (icon != null) Icon(icon, size: 16.d, color: hintColor),
            Text(
              title ?? "",
              style: XTextStyle.regular(
                color: AppColor.secondaryColor.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        SizedBox(
          width: width ?? Get.width / 2.2,
          child: Padding(
            padding: EdgeInsets.only(left: 4.d),
            child: Text(
              value ?? AppLocale.unknown.tr,
              style: XTextStyle.medium(color: textColor),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
