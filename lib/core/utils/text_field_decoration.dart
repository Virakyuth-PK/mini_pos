import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos/core/utils/text_size.dart';

import '../utils/app_ext.dart';
import 'decorated_input_border.dart';

InputDecoration xTextFieldDecoration({
  String? hintText,
  String? errorMessage,
  TextStyle? hintStyle,
  TextStyle? errorStyle,
  EdgeInsets? contentPadding,
  Widget? suffixIcon,
  Widget? prefixIcon,
  VoidCallback? onSuffixIconPress,
  Color? fillColor,
  Color? borderColor,
  BorderRadius? borderRadius,
  bool hasShadow = true,
  bool isShowCounter = false,
  int? maxLength,
  bool hideFocuseBorderColor = false,
  bool forceError = false,
  bool onlyBottom = false,
  bool? isDense,
  EdgeInsets? suffixPadding,
}) {
  return InputDecoration(
    errorStyle: errorStyle ?? XTextStyle.regular(color: Colors.red),
    filled: true,
    prefixIcon: prefixIcon,
    isDense: isDense,
    fillColor: fillColor ?? Colors.white,
    disabledBorder: getBorder(
      Colors.transparent,
      hasShadow: hasShadow,
      borderRadius: borderRadius,
      onlyBottom: onlyBottom,
    ),
    focusedBorder: hideFocuseBorderColor
        ? getBorder(
            Colors.transparent,
            hasShadow: hasShadow,
            borderRadius: borderRadius,
            onlyBottom: onlyBottom,
          )
        : getBorder(
            forceError == true
                ? Colors.red
                : Theme.of(Get.context!).primaryColor,
            hasShadow: hasShadow,
            borderRadius: borderRadius,
            onlyBottom: onlyBottom,
          ),
    enabledBorder: forceError == true
        ? getBorder(
            Colors.red,
            hasShadow: hasShadow,
            borderRadius: borderRadius,
            onlyBottom: onlyBottom,
          )
        : getBorder(
            borderColor ?? Colors.transparent,
            hasShadow: hasShadow,
            borderRadius: borderRadius,
            onlyBottom: onlyBottom,
          ),
    focusedErrorBorder: getBorder(
      Colors.red,
      hasShadow: hasShadow,
      borderRadius: borderRadius,
      onlyBottom: onlyBottom,
    ),
    errorBorder: getBorder(
      Colors.red,
      hasShadow: hasShadow,
      borderRadius: borderRadius,
      onlyBottom: onlyBottom,
    ),
    hintText: hintText,
    counter: isShowCounter && maxLength != null ? null : const SizedBox(),
    contentPadding:
        contentPadding ??
        EdgeInsets.symmetric(vertical: 10..d, horizontal: 10..d),
    hintStyle:
        hintStyle ??
        Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
          color: Theme.of(Get.context!).hintColor,
        ),
    suffixIcon: suffixIcon == null
        ? null
        : ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onSuffixIconPress,
                child: Padding(
                  padding: suffixPadding ?? const EdgeInsets.all(10.0),
                  child: suffixIcon,
                ),
              ),
            ),
          ),
  );
}

InputBorder getBorder(
  Color color, {
  bool hasShadow = true,
  bool onlyBottom = false,
  BorderRadius? borderRadius,
}) {
  if (onlyBottom) {
    return UnderlineInputBorder(borderSide: BorderSide(color: color));
  }

  final border = OutlineInputBorder(
    borderRadius: borderRadius ?? BorderRadius.circular(10.0),
    borderSide: BorderSide(color: color),
  );
  if (!hasShadow) {
    return border;
  }
  return DecoratedInputBorder(
    child: border,
    shadow: const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.09019607843137255),
      offset: Offset(0, 2),
      blurRadius: 5,
    ),
  );
}
