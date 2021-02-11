import 'package:flutter/material.dart';


class ReceiptClipper extends CustomClipper<Path> {


  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    double x = 0;
    double y = size.height;
    double yControlPoint = size.height * .99;
    double increment = size.width / 15;

    while (x < size.width) {
      print('object${x.toInt()}');
      path.quadraticBezierTo(
          x + increment / 2, yControlPoint, x + increment, y);

      x += increment;
    }

    path.lineTo(size.width, 0.0);

    while (x > 0) {
      path.quadraticBezierTo(
          x - increment / 2, size.height * .01, x - increment, 0);
      x -= increment;
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) {
    return old != this;
  }
}