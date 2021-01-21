import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class MediaRoundButtonWidget extends StatelessWidget {
  final String name;
  final Color colorButton;
  final double radius;
  final Color textColor;
  final double fontsize;
  final GestureTapCallback onPressed;
  final String image;

  MediaRoundButtonWidget(
      {@required this.name,
      this.colorButton,
      this.radius,
      this.textColor,
      this.fontsize,
      @required this.onPressed,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.RoundSignupButton_ContainerHeight,
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.all(AppConstants.TextField_Contentpading_top),
      decoration: BoxDecoration(
        color: colorButton ?? Colors.black,
        borderRadius: BorderRadius.circular(radius ?? 0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(AppConstants.ShadowBox_WithOpacity),
            spreadRadius: AppConstants.ShadowBox_SpreadRadius,
            blurRadius: AppConstants.ShadowBox_BlurRadius,
            offset: Offset(0, AppConstants.ShadowBox_Offset), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Image.asset(
              image ?? AssetsPath.googleLogo,
              height: AppConstants.imageHeight_width,
              width: AppConstants.imageHeight_width,
            ),
          ),
          Flexible(
            flex: 9,
            child: Center(
              child: Text(
                name ?? "name",
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: fontsize ?? AppConstants.fontSizeSmall,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
