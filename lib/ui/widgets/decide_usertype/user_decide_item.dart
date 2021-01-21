import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class UserDecideItem extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  final Color colorButton;
  final double radius;
  final Color textColor;
  final double fontsize;
  final GestureTapCallback onPressed;
  final String image;
  final String itemButtonText;
  bool isReverse;

  UserDecideItem({
    @required this.image,
    @required this.titleText,
    @required this.subtitleText,
    @required this.onPressed,
    this.itemButtonText,
    this.colorButton,
    this.radius,
    this.textColor,
    this.fontsize,
    this.isReverse:false,
  }):assert(image!=null, 'Image is either not loading or you havent passed one to me');

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: EdgeInsets.all(SizeConfig.screenHeight * 0.01),
      child: Container(
        padding: EdgeInsets.only(
            left: SizeConfig.screenWidth * 0.03,
            right: SizeConfig.screenWidth * 0.03,
            top: SizeConfig.screenHeight * 0.01,
            bottom: SizeConfig.screenHeight * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.introGetStarted_button_Radius),
        ),
        height: SizeConfig.screenHeight * 0.35,
        // width: double.infinity,
        child: Column(
          children: [
            SizeConfig.verticalSpaceSmall(),
            SizedBox(
              height:  SizeConfig.screenHeight * 0.2 ,
              child: isReverse?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:SizeConfig.screenWidth*.06),
                      child: AutoSizeText(
                        subtitleText,
                        minFontSize: 8,
                        maxFontSize: SizeConfig.fontSizeMedium,
                        style: AppStyles.BlackStyleFont_20(context).copyWith(height: 1.4),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ViewAppImage(
                    height: SizeConfig.screenHeight * 0.2,
                    width: SizeConfig.screenWidth * 0.35,
                    assetUrl: image,
                    boxFit: BoxFit.contain,
                  ),

                  //  ),
                ],

              ):Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ViewAppImage(
                    height: SizeConfig.screenHeight * 0.2,
                    width: SizeConfig.screenWidth * 0.35,
                    assetUrl: image,
                    boxFit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth*.06),
                      child: AutoSizeText(
                        subtitleText,
                        minFontSize: 8,
                        maxFontSize: SizeConfig.fontSizeMedium,
                        style: AppStyles.BlackStyleFont_20(context).copyWith(height: 1.4),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  //  ),
                ],

              ),
            ),
            SizeConfig.verticalSpaceMedium(),
            ButtonWidget(
              buttonText: titleText,
              onPressed: onPressed,

            ),

          ],
        ),
      ),
    );
  }
}
