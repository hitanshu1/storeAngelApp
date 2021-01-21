import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/mobileSize.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AppIntroductionPagerItem extends StatelessWidget {
  final String image;
  final String headerText;
  final String subtext;
  final double position;
  final double imageHeight;
  final Widget placeHolder;
  final bool hasLargeGradient;

  AppIntroductionPagerItem(this.image, this.headerText, this.subtext,
      {this.position, this.imageHeight, this.placeHolder, this.hasLargeGradient: true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: SizeConfig.horizontalGap, right: SizeConfig.horizontalGap),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                height: imageHeight ?? SizeConfig.screenHeight * 0.6,
                width: SizeConfig.screenWidth,
                child: Image.asset(
                  image ?? AssetsPath.googleLogo,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                bottom: SizeConfig.screenHeight * .035,
                left: SizeConfig.screenWidth * .1,
                child: placeHolder ?? Container(),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * .04,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
                Column(
                  children: <Widget>[
                    Text(headerText ?? '',
                        maxLines: 2,
                        style: AppStyles.BlackStyleWithBoldFont_24(context),
                        textScaleFactor: SizeConfig.mobileSize == MobileSize.small ?1:1.3,
                        textAlign: TextAlign.center),
                    Container(padding: EdgeInsets.all(SizeConfig.screenHeight * 0.014)),
                    AutoSizeText(subtext ?? '',
                      minFontSize: 10,
                      maxFontSize: AppStyles.BlackStyleFont_20(context).fontSize,
                      maxLines: 3,
                      textScaleFactor: SizeConfig.mobileSize == MobileSize.small ?1:1.2,
                      style: AppStyles.BlackStyleFont_20(context).copyWith(height: 1.4), textAlign: TextAlign.center,),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
