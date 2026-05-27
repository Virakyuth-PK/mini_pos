import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mini_pos/core/global_widgets/x_button.dart';
import 'package:mini_pos/core/utils/app_color.dart';
import 'package:mini_pos/core/utils/app_style.dart';
import '../../../core/global_widgets/x_text_field.dart';
import '../../../core/utils/app_ext.dart';
import '../../../gen/assets.gen.dart';
import '../../../translation/app_locale.dart';

class BottomNavWidget extends StatelessWidget {
  BottomNavWidget({
    super.key,
    this.enableAIMode = false,
    required this.onSubmit,
  });
  final bool? enableAIMode;
  final Function(String v) onSubmit;

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColor.secondaryColor.withValues(alpha: .1)),
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 12.d, horizontal: 12.d),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8.d,
          children: [
            XButton(
              borderRadius: BorderRadius.circular(80.d),
              onPress: () {
                Get.back();
              },
              child: Container(
                decoration: xBoxDecoration(
                  color: Colors.grey.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(80.d),
                ),
                width: 58.d,
                height: 58.d,
                child: Center(
                  child: SvgPicture.asset(Assets.svg.backIcon, width: 28.d),
                ),
              ),
            ),
            _textField(),
          ],
        ),
      ),
    );
  }

  Widget _textField() {
    return Expanded(
      child: XTextField(
        textController: controller,
        onChanged: (v) {},
        maxLines: 1,
        onFieldSubmitted: (v) {
          onSubmit.call(v);
        },
        hintText: enableAIMode == true
            ? AppLocale.askAI.tr
            : AppLocale.searchProduct.tr,
        borderRadius: BorderRadius.circular(80),
        fillColor: Colors.grey.withValues(alpha: .09),
        suffixIcon: Container(
          padding: EdgeInsets.all(8.d),
          decoration: xBoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SvgPicture.asset(
              enableAIMode == true
                  ? Assets.svg.sendIcon
                  : Assets.svg.searchIcon,
              width: 24.d,
            ),
          ),
        ),
        onSuffixIconPress: () {
          final v = controller.text;
          onSubmit.call(v);
        },
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(90),
            child: Image.asset(
              Assets.icon.logoSolidProdWhite.path,
              width: 42.d,
            ),
          ),
        ),
      ),
    );
  }
}
