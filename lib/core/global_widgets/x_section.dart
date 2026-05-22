import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/app_ext.dart';
import '../utils/app_style.dart';
import '../utils/text_size.dart';
import 'x_button.dart';

class XSection extends StatefulWidget {
  XSection({
    Key? key,
    required this.labelWidget,
    required this.child,
    this.canCollapse = true,
    this.isOpen = false,
    this.otherChild,
    this.isNeedIcon = true,
    this.onPress,
    this.afterOnPressCall,
    this.require = false,
  }) : super(key: key);
  final Widget labelWidget;
  final Widget child;
  Widget? otherChild;
  final bool canCollapse;
  final bool require;
  final bool isNeedIcon;
  final bool isOpen;
  final Function()? onPress;
  final Function(bool visible)? afterOnPressCall;

  @override
  State<XSection> createState() => _XSectionState();
}

class _XSectionState extends State<XSection> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        XButton(
          borderRadius: visible
              ? BorderRadius.only(
                  topLeft: Radius.circular(xRadiusValue),
                  topRight: Radius.circular(xRadiusValue),
                )
              : BorderRadius.circular(xRadiusValue),
          onPress:
              widget.onPress ??
              () {
                setState(() {
                  if (widget.canCollapse) {
                    visible = !visible;
                  }
                  if (widget.afterOnPressCall != null) {
                    widget.afterOnPressCall!(visible);
                  }
                });
              },
          child: Container(
            decoration: xBoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(xRadiusValue),
                topRight: Radius.circular(xRadiusValue),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: visible
                      ? BorderRadius.only(
                          topLeft: Radius.circular(xRadiusValue),
                          topRight: Radius.circular(xRadiusValue),
                        )
                      : BorderRadius.circular(xRadiusValue),
                  child: Row(
                    children: [
                      widget.labelWidget,
                      if (widget.require)
                        Text("*", style: XTextStyle.regular(color: Colors.red)),
                    ],
                  ),
                ),
                if (widget.isNeedIcon == true)
                  Row(
                    children: [
                      Icon(
                        visible
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_right_rounded,
                        size: 30.0.d,
                        color: Theme.of(context).hintColor,
                      ),
                      xSpaceH(size: 5.d),
                    ],
                  ),
              ],
            ),
          ),
        ),
        Visibility(
          maintainState: true,
          visible:
              // visible,
              widget.onPress != null && widget.isOpen ? widget.isOpen : visible,
          child: Container(
            decoration: xBoxDecoration(
              color: AppColor.white,
              borderRadius: visible
                  ? BorderRadius.only(
                      bottomRight: Radius.circular(xRadiusValue),
                      bottomLeft: Radius.circular(xRadiusValue),
                    )
                  : BorderRadius.zero,
            ),
            child: widget.child,
          ),
        ),
        Visibility(
          maintainState: true,
          visible:
              // visible,
              widget.onPress != null && widget.isOpen ? widget.isOpen : visible,
          child: widget.otherChild ?? SizedBox.shrink(),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    visible = widget.isOpen;
  }
}
