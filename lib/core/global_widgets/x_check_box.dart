import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/app_color.dart';
import '../utils/app_ext.dart';
import '../utils/app_style.dart';
import '../utils/text_size.dart';

class XCheckBox extends StatelessWidget {
  final bool? value;
  final String? label;
  final bool isReadOnly;
  final void Function(bool?) onChanged;
  double? width, height;
  bool tristate;

  XCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.width,
    this.tristate = false,
    this.height,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width ?? 30.d,
          height: height ?? 30.d,
          child: Transform.scale(
            scale: 1.4,
            child: Checkbox(
              value: value,
              tristate: tristate,
              activeColor: isReadOnly
                  ? AppColor.hintColor
                  : Theme.of(Get.context!).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0.d), // rounded corners
              ),
              side: WidgetStateBorderSide.resolveWith(
                (states) => BorderSide(
                  width: 1.0,
                  color: isReadOnly == true
                      ? AppColor.hintColor
                      : Theme.of(Get.context!).primaryColor,
                ),
              ),
              onChanged: isReadOnly == true
                  ? null
                  : (bool? isChecked) {
                      HapticFeedback.selectionClick();
                      onChanged(isChecked);
                    },
            ),
          ),
        ),
        if ((label ?? "").isNotEmpty) ...[
          xSpaceH(size: 10.0.d),
          Expanded(child: Text(label ?? "", style: XTextStyle.regular())),
        ],
      ],
    );
  }
}

class SquareRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;

  const SquareRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onChanged(value);
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(4), // square with rounded corners
        ),
        child: isSelected
            ? Center(child: Icon(Icons.check, size: 16, color: Colors.white))
            : null,
      ),
    );
  }
}
