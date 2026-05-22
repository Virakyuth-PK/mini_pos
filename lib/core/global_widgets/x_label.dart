import '../utils/app_ext.dart';

import '../utils/app_style.dart';
import 'package:flutter/material.dart';

import '../utils/text_size.dart';

class XLabel extends StatelessWidget {
  const XLabel({
    Key? key,
    this.label,
    required this.child,
    this.errorText,
    this.require = false,
    this.labelSubWidget,
    this.belowLabelWidget,
    this.customLabelWidget,
    this.action,
    this.enable = true,
    this.labelPadding = EdgeInsets.zero,
    this.labelSize,
    this.gap,
  }) : super(key: key);

  final Widget child;
  final String? label;
  final String? errorText;
  final Widget? labelSubWidget, belowLabelWidget, customLabelWidget;
  final bool require;
  final bool enable;
  final Widget? action;
  final TextStyle? labelSize;
  final double? gap;
  final EdgeInsetsGeometry labelPadding;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enable,
      child: Opacity(
        opacity: enable ? 1 : 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customLabelWidget ??
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5.0.d,
                  children: [
                    Padding(
                      padding: labelPadding,
                      child: Text(
                        label ?? "",
                        style: labelSize ?? XTextStyle.regular(),
                      ),
                    ),
                    if (require)
                      Text("*", style: XTextStyle.regular(color: Colors.red)),
                    xSpaceH(),
                    if (labelSubWidget != null) labelSubWidget!,
                    if (action != null) const Spacer(),
                    if (action != null) action!,
                  ],
                ),
            if (belowLabelWidget != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  xSpaceV(size: 5.0.d),
                  belowLabelWidget!,
                ],
              ),
            xSpaceV(size: 5.0.d),
            if (gap != null) xSpaceV(),
            child,
            if (errorText != null)
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 10),
                child: Text(
                  errorText!,
                  style: XTextStyle.regular(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
