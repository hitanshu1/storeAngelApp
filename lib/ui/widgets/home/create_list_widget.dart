import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class CreateListWidget extends StatelessWidget {
  final String name;
  final Color colorButton;
  final double radius;
  final Color textColor;
  final double fontsize;
  final GestureTapCallback onPressed;
  final String image;

  CreateListWidget(
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
      padding: EdgeInsets.only(
          top: AppConstants.TextField_Contentpading_top,
          bottom: AppConstants.TextField_Contentpading_top,
          left: AppConstants.marginMedium,
          right: AppConstants.marginMedium),
      decoration: BoxDecoration(
        color: colorButton ?? Colors.black,
        borderRadius: BorderRadius.circular(radius?? 0),
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
          Expanded(
            flex: 9,
            child: Text(
              name ?? "${AppStrings.NAME.tr()}",
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: fontsize?? AppConstants.fontSizeSmall,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: onPressed,
              child: Image.asset(
                image ?? AssetsPath.googleLogo,
                height: AppConstants.imageHeight_width,
                width: AppConstants.imageHeight_width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
