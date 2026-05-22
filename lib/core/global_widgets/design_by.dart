import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../gen/assets.gen.dart';
import '../../src/module/splash/logic.dart';
import '../utils/app_color.dart';
import '../utils/app_ext.dart';
import '../utils/text_size.dart';

class DesignBy extends StatelessWidget {
  const DesignBy({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4.d,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.svg.cmtrLogo, width: 80.d),
        Container(height: 30.d, width: 1.d, color: AppColor.hintColor),
        Row(
          spacing: 5.d,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.svg.cmgsvg, width: 25.d),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Developed By", style: XTextStyle.regular()),
                Row(
                  spacing: 5.d,
                  children: [
                    Text("Chipmong", style: XTextStyle.regular()),
                    Text(
                      "Group",
                      style: XTextStyle.regular(
                        color: CompanyColor.CHIPMONG_GROUP,
                      ),
                    ),
                    Text(
                      // Get.find<SplashLogic>().state.appVersion.value,
                      'v1.0.1',
                      textAlign: TextAlign.center,
                      style: XTextStyle.regular(color: AppColor.hintColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
