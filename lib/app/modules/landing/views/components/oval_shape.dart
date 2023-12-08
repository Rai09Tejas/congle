import 'package:flutter/material.dart';

class OvalTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create a Paint object for the oval shape
    Paint ovalPaint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.stroke;

    // Calculate the center of the oval
    Offset center = Offset(size.width / 2, size.height / 2);

    // Calculate the radius of the oval (half of the minimum dimension)
    double radius = size.shortestSide / 2;

    // Draw the oval using a Rect
    canvas.drawOval(Rect.fromCircle(center: center, radius: radius), ovalPaint);

    // Create a Paint object for the text
    TextSpan span = const TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
      ),
      text: "Oval Text",
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Layout the text
    tp.layout();
    tp.paint(
        canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
