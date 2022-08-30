import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SignInUpLogoWidget extends StatelessWidget {
  const SignInUpLogoWidget({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
          width,
          (width * 0.7453416149068323)
              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
      painter: RPSCustomPainter(),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 43, 86, 110)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(
        Offset(size.width * 0.50, 0),
        Offset(size.width, size.height * 0.98),
        [Color(0x6F2b566e), Color(0xFF2b566e)],
        [0.00, 1.00]);

    Path path0 = Path();
    path0.moveTo(0, size.height * 0.8440833);
    path0.quadraticBezierTo(size.width * 0.2018012, size.height * 0.9815417,
        size.width * 0.4347826, size.height * 0.9583333);
    path0.quadraticBezierTo(size.width * 0.7686957, size.height * 0.9334583,
        size.width * 0.9992547, size.height * 0.5546250);
    path0.lineTo(size.width, 0);
    path0.lineTo(0, size.height * 0.0015833);
    path0.lineTo(0, size.height * 0.8440833);
    path0.close();

    canvas.drawPath(path0, paint0);

    Paint paint1 = Paint()
      ..color = const Color.fromARGB(
          255, 43, 86, 110) //Color.fromARGB(255, 212, 214, 215)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    paint1.shader = ui.Gradient.linear(
        Offset(0, size.height * 0.79),
        Offset(size.width, size.height * 0.79),
        [Color(0x2F2b566e), Color(0xFF2b566e)],
        [0.00, 1.00]);

    Path path1 = Path();
    path1.moveTo(0, size.height * 0.7958333);
    path1.quadraticBezierTo(size.width * 0.0526087, size.height * 0.8597083,
        size.width * 0.1708075, size.height * 0.9333333);
    path1.cubicTo(
        size.width * 0.3874534,
        size.height * 1.0342083,
        size.width * 0.5020807,
        size.height * 0.9988750,
        size.width * 0.6211180,
        size.height * 0.9541667);
    path1.quadraticBezierTo(size.width * 0.8570497, size.height * 0.8520000,
        size.width, size.height * 0.5537917);

    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
