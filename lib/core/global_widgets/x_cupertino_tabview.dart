import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/app_ext.dart';
import '../utils/app_style.dart';
import '../utils/text_size.dart';

enum TabViewRadius { left, center, right }

class TabViewParam {
  final String? icon;

  final String label;

  const TabViewParam({this.icon, required this.label});
}

class XCupertinoTabview extends StatefulWidget {
  final List<TabViewParam> tabView;
  final ValueChanged<int> onChanged;
  final Color? inActiveBackground;
  final Color? activeBackground;
  double? radius;
  int? initialIndex;
  final Function(int)? onTap;

  XCupertinoTabview({
    super.key,
    required this.tabView,
    required this.onChanged,
    this.inActiveBackground,
    this.activeBackground,
    this.onTap,
    this.radius,
    this.initialIndex = 0,
  });

  @override
  State<XCupertinoTabview> createState() => _XCupertinoTabviewState();
}

class _XCupertinoTabviewState extends State<XCupertinoTabview> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex ?? 0;
  }

  @override
  void didUpdateWidget(covariant XCupertinoTabview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialIndex != oldWidget.initialIndex &&
        widget.initialIndex != _currentIndex) {
      setState(() {
        _currentIndex = widget.initialIndex ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * .4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius ?? xRadiusValue),
        child: CupertinoSlidingSegmentedControl<int>(
          padding: xPadding(),
          children: {
            for (int i = 0; i < widget.tabView.length; i++)
              i: _buildSegment(
                context: context,
                label: widget.tabView[i].label,
                svgIconPath: widget.tabView[i].icon ?? '',
                radius: _getTabRadius(i),
                isSelected: i == _currentIndex,
              ),
          },
          thumbColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          groupValue: _currentIndex,
          onValueChanged: (onValue) {
            widget.onChanged.call(onValue ?? 0);
            setState(() {
              _currentIndex = onValue ?? 0;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSegment({
    required BuildContext context,
    String? svgIconPath,
    required String label,
    required bool isSelected,
    required TabViewRadius radius,
  }) {
    final theme = Theme.of(context);
    final textColor = isSelected
        ? theme.cardColor
        : theme.textTheme.bodyMedium?.color;
    final bgColor = isSelected
        ? widget.activeBackground ?? theme.primaryColor
        : widget.inActiveBackground ?? theme.cardColor;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 6..d, vertical: 6..d),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: _getBorderRadius(radius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...[
            if (svgIconPath == null && svgIconPath == '')
              SvgPicture.asset(
                svgIconPath!,
                colorFilter: ColorFilter.mode(bgColor, BlendMode.srcIn),
                width: 16,
              ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: XTextStyle.regular(color: textColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  TabViewRadius _getTabRadius(int index) {
    if (index == 0) return TabViewRadius.left;
    if (index == widget.tabView.length - 1) return TabViewRadius.right;
    return TabViewRadius.center;
  }

  BorderRadius _getBorderRadius(TabViewRadius radius) {
    switch (radius) {
      case TabViewRadius.left:
        return BorderRadius.only(topLeft: xRadius, bottomLeft: xRadius);
      case TabViewRadius.right:
        return BorderRadius.only(topRight: xRadius, bottomRight: xRadius);

      default:
        return BorderRadius.zero;
    }
  }
}
