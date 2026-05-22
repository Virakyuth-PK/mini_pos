import 'package:flutter/material.dart';

class XTriangleContainer extends StatelessWidget {
  final double width;
  final double height;
  Color backgroundColor = Colors.white;

  XTriangleContainer({
    super.key,
    required this.width,
    required this.height,
    backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TrianglePainter(backgroundColor: backgroundColor),
      size: Size(width, height),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color backgroundColor;

  TrianglePainter({super.repaint, required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
