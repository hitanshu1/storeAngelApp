import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class CircularButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final double radius;
  final Color textColor;
  final double fontSize;
  final LinearGradient gradient;
  final GestureTapCallback onPressed;

  final double width;
  final Widget child;
  final FontWeight fontWeight;
  final double elevation;

  CircularButtonWidget({Key key,
    @required this.onPressed,
    this.buttonText,
    this.buttonColor,
    this.radius,
    this.textColor,
    this.fontSize,
    this.gradient,
    this.width, this.child, this.fontWeight, this.elevation})
      :assert(onPressed != null, 'Without an onPressed this button does make not a lot of sense. Please include!'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.buttonHeight,
      width: width != null ? width : SizeConfig.screenWidth,
      child: RaisedButton(
        elevation: elevation,
        padding: EdgeInsets.all(0),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.button_Radius),
        ),
        color: buttonColor ?? Colors.black,
        child: child != null ? child : Padding(
          padding: SizeConfig.sidepadding,
          child: FittedBox(
            child: Text(
              buttonText,
              maxLines: 1,
              style: TextStyle(color: textColor ?? AppColors.whiteColor, fontSize: fontSize ?? SizeConfig.fontSizeSmall,
                  fontWeight: fontWeight ?? fontWeight),
            ),
          ),
        ),
      ),
    );
  }
}
