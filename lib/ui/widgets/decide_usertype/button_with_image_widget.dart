import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class ItemButtonWithImage extends StatelessWidget {
  final String name;
  final Color colorButton;
  final double radius;
  final Color textColor;
  final double fontSize;
  final GestureTapCallback onPressed;
  final String image;

  ItemButtonWithImage(
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
      width: SizeConfig.screenWidth,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 6,
            child: Text(
              name ?? "${AppStrings.NAME.tr()}",
              style: TextStyle(color: textColor ?? Colors.white, fontSize: fontSize ?? SizeConfig.fontSizeSmall),
              textAlign: TextAlign.center,
            ),
          ),
          Flexible(
            flex: 1,
            child: SizeConfig.VerticalSpaceSmallMedium(),
          ),
          Flexible(
            flex: 6,
            child: Image.asset(
              image ?? AssetsPath.nextIcon,
              height: AppConstants.imageHeight_width_Very_small,
              width: AppConstants.imageHeight_width_small,
            ),
          ),
        ],
      ),
    );
  }
}
