import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LineDrawer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = Color.fromARGB(230, 243, 54, 50);

    var path = Path();
    path.lineTo(size.width * 0.20, 0);
    path.lineTo(size.width * 0.80, 0);
    path.lineTo(0, size.height * 0.9);

    canvas.drawPath(path, paint);

    paint.color = Color.fromARGB(255, 66, 199, 244);
    var path2 = Path();

    path2.moveTo(0, size.height / 2);
    path2.lineTo(size.width * 1.2, size.height);
    path2.lineTo(0, size.height * 1.5);

    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
