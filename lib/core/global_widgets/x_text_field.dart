import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/app_color.dart' as app_color;
import '../utils/app_ext.dart';
import '../utils/text_field_decoration.dart';
import '../utils/text_size.dart';

enum SecureType {
  star('*'),
  dot('•'),
  hash('#'),
  plus('+'),
  none('');

  final String char;

  const SecureType(this.char);
}

class XTextField extends StatelessWidget {
  XTextField({
    super.key,
    this.initialValue,
    this.enable = true,
    required this.onChanged,
    this.keyboardType,
    this.textInputAction,
    required this.hintText,
    this.maxLines,
    this.hintColor,
    this.suffixIcon,
    this.maxLength,
    this.inputFormatters,
    this.hasShadow = false,
    this.borderColor,
    this.fillColor,
    this.autofocus = false,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.textController,
    this.borderRadius,
    this.prefixIcon,
    this.errorMessage,
    this.forceError = false,
    this.textStyle,
    this.textAlign,
    this.validator,
    this.onlyBottom = false,
    this.isDense = false,
    this.suffixPadding,
    this.contentPadding,
    this.onSuffixIconPress,
    this.secureType = SecureType.dot,
  });

  factory XTextField.showOnly({
    required hintText,
    Widget? suffixIcon,
    TextStyle? textStyle,
    Color? hintColor,
  }) {
    return XTextField(
      initialValue: null,
      onChanged: null,
      hintText: hintText,
      textStyle: textStyle,
      hintColor: hintColor,
      enable: false,
      autofocus: false,
      suffixIcon: suffixIcon,
    );
  }

  final initialValue;
  final enable;
  final Function(String value)? validator;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;
  final hintText;
  final hintColor;
  final textInputAction;
  final TextInputType? keyboardType;
  final maxLines;
  final Widget? suffixIcon;
  final maxLength;
  final inputFormatters;
  final textController;
  final bool autofocus;
  final bool hasShadow;
  final bool obscureText;
  final Color? borderColor;
  final Color? fillColor;
  final BorderRadius? borderRadius;
  final Widget? prefixIcon;
  final String? errorMessage;
  final bool forceError;
  final bool onlyBottom;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final EdgeInsets? suffixPadding;
  final SecureType? secureType;
  final Function()? onSuffixIconPress;
  final EdgeInsets? contentPadding;
  final bool? isDense;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: primaryColor,
      initialValue: initialValue,
      obscureText: obscureText,
      controller: textController,
      enabled: enable,
      textAlign: textAlign ?? TextAlign.start,
      autofocus: autofocus,
      validator: validator != null ? (value) => validator!(value ?? "") : null,
      onChanged: enable == false ? null : (value) => onChanged!(value),
      decoration: xTextFieldDecoration(
        hintText: hintText,
        contentPadding: contentPadding ?? EdgeInsets.all(20.d),
        hintStyle: XTextStyle.regular(color: app_color.hintColor),
        hasShadow: hasShadow,
        isDense: isDense,
        onlyBottom: onlyBottom,
        prefixIcon: prefixIcon,
        borderColor: borderColor,
        suffixIcon: suffixIcon,
        suffixPadding: suffixPadding,
        fillColor: fillColor,
        onSuffixIconPress: onSuffixIconPress,
        borderRadius: borderRadius ?? BorderRadius.circular(16.d),
        errorMessage: errorMessage,
        forceError: forceError,
        errorStyle: XTextStyle.regular(color: Colors.red),
      ),
      style: textStyle ?? XTextStyle.regular(color: AppColor.primaryColor),
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
