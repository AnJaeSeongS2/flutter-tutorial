import 'package:flutter/material.dart';

class LoginBackground extends CustomPainter {
  final bool isJoin;

  LoginBackground({required this.isJoin});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = isJoin ? Colors.red : Colors.blue;//paint = Paint() with set color as Colors.blue and
    canvas.drawCircle(Offset(size.width*0.5, size.height*0.15), size.height*0.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
