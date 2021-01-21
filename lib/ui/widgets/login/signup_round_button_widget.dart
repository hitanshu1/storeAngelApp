import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/ui/shared/app_tile_shape.dart';

class SignInRoundButtonWidget extends StatelessWidget {
  final String name;
  final Color buttonColor;
  final double radius;
  final Color textColor;
  final double fontSize;
  final GestureTapCallback onTap;

  SignInRoundButtonWidget({
    @required this.name,
    @required this.onTap,
    this.buttonColor,
    this.radius,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: AppTileShape(
          child: Container(
            height: SizeConfig.screenHeight * 0.07,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              color: buttonColor == null ? Colors.black : buttonColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(AppConstants.ShadowBox_WithOpacityMedium),
                  blurRadius: 10,
                  offset: Offset(0, 10), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Text(
                name ?? "name",
                style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: fontSize ?? AppConstants.fontSizeSmall),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
