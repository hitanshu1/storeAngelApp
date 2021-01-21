import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class ButtonSocialMedia extends StatelessWidget {
  final String name;
  final Color colorButton;
  final double radius;
  final Color textColor;
  final double fontSize;
  final GestureTapCallback onPressed;
  final String image;

  ButtonSocialMedia(
      {@required this.name,
      this.colorButton,
      this.radius,
      this.textColor,
      this.fontSize,
      @required this.onPressed,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.07,
      padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.04,
          right: SizeConfig.screenWidth * 0.04,
          top: SizeConfig.screenHeight * 0.02,
          bottom: SizeConfig.screenHeight * 0.02),
      decoration: BoxDecoration(
        color: colorButton ?? Colors.black,
        borderRadius: BorderRadius.circular(radius ?? 0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Image.asset(
              image ?? AssetsPath.fbLogo,
              height: SizeConfig.screenHeight * 0.02,
              width: SizeConfig.screenWidth * 0.04,
            ),
          ),
          Flexible(
            flex: 2,
            child: SizeConfig.verticalSpaceSmall(),
          ),
          Flexible(
            flex: 9,
            child: Text(name ?? "name",
                style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: fontSize ?? SizeConfig.fontSizeSmall)),
          )
        ],
      ),
    );
  }
}
