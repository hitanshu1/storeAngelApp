import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';

class ButtonWithIcon extends StatelessWidget {
  final String buttonText;
  final LinearGradient buttonColor;
  final double radius;
  final Color textColor;
  final double fontSize;
  final GestureTapCallback onPressed;
  final double height;
  final Color iconColor;
  final bool space;
  final double weight;
  final IconData icon;
  final double iconSize;

  ButtonWithIcon(
      {Key key,
        @required this.buttonText,
        @required this.onPressed,
        this.buttonColor,
        this.weight,
        this.radius,
        this.textColor,
        this.fontSize,
        this.icon,
        this.iconSize,
        this.iconColor,
        this.space:false,
        this.height})
      : assert(buttonText != null, 'You need to include the buttonText for this button'),
        assert(onPressed != null, 'Without an onPressed this button does make not a lot of sense. Please include!'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: AppShapeItem(
        child: Container(
          decoration: BoxDecoration(

            gradient: buttonColor??AppColors.primaryGradient,
          ),
          height: SizeConfig.buttonHeight,
          width: weight??SizeConfig.screenWidth,
          child:  Padding(
            padding: SizeConfig.innerpadding,
            child: Row(
              children: [
                Opacity(opacity: 0,child: Icon(icon)),
                Expanded(child: Text(buttonText,textAlign: TextAlign.center,
                style: TextStyle(color: textColor),)),
                Icon(icon,color: iconColor,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
