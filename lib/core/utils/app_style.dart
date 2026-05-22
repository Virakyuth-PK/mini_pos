import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_color.dart';
import 'app_ext.dart';

BoxDecoration xBoxDecoration({
  Color? color,
  double? borderWidth,
  Color? borderColor,
  Color? shadowColor,
  bool hasShadow = false,
  bool hasBorder = false,
  Gradient? gradient,
  BorderRadius? borderRadius,
  BoxShape? shape,
  List<BoxShadow>? boxShadow,
  double? blurRadius,
  double? spreadRadius,
  bool shadowAngleTop = false,
}) => BoxDecoration(
  color: color ?? backgroundColor,
  shape: shape ?? BoxShape.rectangle,
  gradient: gradient,
  borderRadius: shape == null ? borderRadius ?? xBorderRadius : null,
  boxShadow: hasShadow == true
      ? [
          BoxShadow(
            color: shadowColor ?? Color(0xFF6B7280).withOpacity(0.08),
            blurRadius: 28.d,
            offset: const Offset(0, 2),
          ),
        ]
      : boxShadow,
  border: hasBorder == true
      ? Border.all(
          color: borderColor ?? Colors.white.withValues(alpha: 0.25),
          width: borderWidth ?? 1,
        )
      : null,
);

/// Default : 15.0.d
xSpaceV({double? size}) => SizedBox(height: size ?? 15.0.d);

/// Default : 10.0.d
xSpaceH({double? size}) => SizedBox(width: size ?? 10.0.d);

/// Creates a linear gradient with customizable color, stops, and alignment.
///
/// This function generates a linear gradient that transitions from a specified
/// color to a darker shade of that color. The gradient's direction and the
/// distribution of color stops can be customized using the provided parameters.
///
/// Parameters:
/// - [color]: The base color for the gradient. If not provided, the primary color is used.
/// - [stops]: A list of values from 0.0 to 1.0 that define the position of color stops.
///            Defaults to [0.3, 0.8] if not provided.
/// - [begin]: The starting point of the gradient. Defaults to [Alignment.topLeft]
///            if not provided.
/// - [end]: The end point of the gradient. Defaults to [Alignment.bottomRight]
///          if not provided.
///
/// Returns:
/// A [LinearGradient] configured with the specified parameters.

LinearGradient xGradient({
  Color? color,
  List<Color>? colors,
  List<double>? stops,
  AlignmentGeometry? begin,
  AlignmentGeometry? end,
}) {
  color = color ?? primaryColor;
  return LinearGradient(
    colors: colors ?? [color, color.darkenColor(0.7)],
    stops: stops ?? [0.3, 0.8],
    begin: begin ?? Alignment.topLeft,
    end: end ?? Alignment.bottomRight,
  );
}

double get xRadiusValue => 12.d;

/// Base padding size, defaults to 5.0 scaled by device pixel density.
var paddingSize = 5.d;

BorderRadiusGeometry get xBorderRadius => BorderRadius.circular(xRadiusValue);

Radius get xRadius => Radius.circular(xRadiusValue);

//with d already
EdgeInsetsGeometry xPadding({
  double left = 20,
  double right = 20,
  double top = 20,
  double bottom = 20,
  double multiply = 1,
}) => EdgeInsetsGeometry.only(
  top: (top * multiply).d,
  left: (left * multiply).d,
  bottom: (bottom * multiply).d,
  right: (right * multiply).d,
);

/// Horizontal padding: 15.0 on each side.
EdgeInsets xPaddingH() => EdgeInsets.symmetric(horizontal: paddingSize);

EdgeInsets xXPaddingH() => EdgeInsets.symmetric(horizontal: paddingSize * 2);

EdgeInsets xXXPaddingH() => EdgeInsets.symmetric(horizontal: paddingSize * 3);

/// All sides padding: 25.0 (paddingSize * 5).
EdgeInsets xXXLPadding() => EdgeInsets.all(paddingSize * 5);

/// All sides padding: 20.0 (paddingSize * 4).
EdgeInsets xXLPadding() => EdgeInsets.all(paddingSize * 4);

/// All sides padding: 15.0 (paddingSize * 3).
EdgeInsets xLPadding() => EdgeInsets.all(paddingSize * 3);

/// All sides padding: 10.0 (paddingSize * 2).
EdgeInsets xMPadding() => EdgeInsets.all(paddingSize * 2);

/// All sides padding: 5.0 (paddingSize).
EdgeInsets xSPadding() => EdgeInsets.all(paddingSize);

EdgeInsets xXSPadding() => EdgeInsets.all(paddingSize / 2);

EdgeInsets xXXSPadding() => EdgeInsets.all(paddingSize / 3);
