import 'package:flutter/cupertino.dart';

class DashedDivider extends StatelessWidget {
  final Color color;
  final double dashWidth;
  final double dashHeight;
  final double spacing;

  const DashedDivider({
    super.key,
    required this.color,
    this.dashWidth = 4,
    this.dashHeight = 1,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count =
        (constraints.maxWidth / (dashWidth + spacing)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
                (_) => Container(
              width: dashWidth,
              height: dashHeight,
              color: color,
            ),
          ),
        );
      },
    );
  }
}