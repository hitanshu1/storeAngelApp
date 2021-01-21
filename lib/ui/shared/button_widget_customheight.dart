import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class ButtonWidgetCustomHeight extends StatelessWidget {
  final Color colorButton;
  final double radius;
  final Color textColor;
  final double fontSize;
  final GestureTapCallback onPressed;
  final double height;
  final String name;

  ButtonWidgetCustomHeight(
      {@required this.name,
      this.colorButton,
      this.radius,
      this.textColor,
      this.fontSize,
      @required this.onPressed,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? SizeConfig.screenHeight * 0.07,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(.1),
          blurRadius: 15,
          offset: Offset(0,7),
        ),BoxShadow(
          color: Colors.black.withOpacity(.1),
          blurRadius: 15,
          offset: Offset(0,-7),
        )]
      ),
      child: FlatButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        color: colorButton ?? Colors.black,
        child: Text(
          name,
          style: TextStyle(color: textColor ?? Colors.white, fontSize: fontSize ?? SizeConfig.fontSizeSmall, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
