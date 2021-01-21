import 'package:flutter/material.dart';

class ChatRightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width-20,10)
      ..lineTo(size.width-20,size.height-5)
      ..quadraticBezierTo(size.width-22, size.height, size.width-30, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
class ChatLeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width,size.height)
      ..lineTo(30,size.height)
      ..quadraticBezierTo(22, size.height-2, 20, size.height-10)
      ..lineTo(20,10)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}
class ChatTextFieldClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(size.width, 0)
      ..quadraticBezierTo(size.width-20, size.height/2, size.width,size.height)
      ..lineTo(size.width,size.height)
      ..lineTo(0,size.width)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}