import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';


class SignUpCourierSocialMedia extends StatelessWidget {
  final String name;
  final Color colorButton;
  final double radius;
  final Color textColor;
  final double fontSize;
  final GestureTapCallback onPressed;
  final String image;
  final Color filterColor;

  SignUpCourierSocialMedia(
      {@required this.name,
        @required this.onPressed,
        this.colorButton,
        this.radius,
        this.textColor,
        this.fontSize,
        this.image, this.filterColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: AppShapeItem(
        child: Container(
          decoration: BoxDecoration(
            color: colorButton == null ? Colors.black : colorButton,
            
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizeConfig.verticalSpaceSmall(),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(filterColor??Colors.transparent, filterColor!=null?BlendMode.srcATop:BlendMode.color),
                    child: Image.asset(
                      image ?? AssetsPath.googleLogo,
                    ),
                  ),
                ),
              ),
              //here is the width taken for the height, because the button gets its size from the width not from the screenHeight
              SizedBox(height: SizeConfig.screenWidth*.01,),
              Text(name ?? AppStrings.BUTTON.tr(),
                  style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: fontSize ?? SizeConfig.fontSizeSmall)),
              SizeConfig.verticalSpaceSmall(),
            ],
          ),
        ),
      ),
      onTap: onPressed,
    );
  }
}
