import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_ext.dart';
import '../../../../core/utils/app_style.dart';

class XExpandTile extends StatefulWidget {
  const XExpandTile({
    super.key,
    required this.title,
    required this.child,
    this.initialExpanded = false,
  });

  final Widget title;
  final Widget child;
  final bool initialExpanded;

  @override
  State<XExpandTile> createState() => _XExpandTileState();
}

class _XExpandTileState extends State<XExpandTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late bool isExpanded;

  @override
  void initState() {
    super.initState();

    isExpanded = widget.initialExpanded;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    if (isExpanded) {
      _controller.value = 1;
    }
  }

  void toggle() {
    setState(() => isExpanded = !isExpanded);

    isExpanded ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: xBoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.d),
      ),
      child: Column(
        children: [
          /// HEADER
          InkWell(
            borderRadius: BorderRadius.circular(12.d),
            onTap: toggle,
            child: Padding(
              padding: EdgeInsets.all(18.d),
              child: Row(
                children: [
                  Expanded(child: widget.title),

                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 260),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: isExpanded ? primaryColor : hintColor,
                      size: 24.d,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// BODY
          ClipRect(
            child: SizeTransition(
              sizeFactor: _expandAnimation,
              axisAlignment: -1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(18.d, 0, 18.d, 18.d),
                child: widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
