import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

///Text in here does not need to be translated, when it is only shown without the AppStrings
class StorePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      children: <Widget>[
        Container(
          width: SizeConfig.screenWidth * .8,
          height: SizeConfig.screenHeight * .13,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.primaryColor, width: 1),
              boxShadow: [
                BoxShadow(color: AppColors.primaryColor.withOpacity(.2), blurRadius: 20, offset: Offset(-10, 10))
              ]),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.screenWidth * .02),
            child: Row(
              children: <Widget>[
                Image.asset(
                  AssetsPath.storePlaceholder,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * .03,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'REWE',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.fontSizeMedium,
                            color: AppColors.blackFontColor),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .01),
                        child: Text(
                          AppStrings.NUMBRECH_12.tr(),
                          style: TextStyle(
                              color: AppColors.darkGrayColor, fontSize: SizeConfig.fontSizeSmall, letterSpacing: 0.2),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .01),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '300 m',
                              style: TextStyle(color: AppColors.primaryColor, fontSize: SizeConfig.fontSizeSmall),
                            ),
                            Text(
                              ' | ',
                              style: TextStyle(color: AppColors.lightGrayDotColor, fontSize: SizeConfig.fontSizeSmall),
                            ),
                            Container(
                              height: SizeConfig.fontSizeSmall / 2,
                              width: SizeConfig.fontSizeSmall / 2,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blackFontColor),
                            ),
                            Text(
                              ' 9:00 - 22:00',
                              style: TextStyle(color: AppColors.blackFontColor, fontSize: SizeConfig.fontSizeSmall),
                            ),
                            Text(
                              ' | ',
                              style: TextStyle(color: AppColors.lightGrayDotColor, fontSize: SizeConfig.fontSizeSmall),
                            ),
                            Icon(Icons.person, color: AppColors.blackFontColor, size: SizeConfig.fontSizeSmall,),
                            Text(
                              ' 12',
                              style: TextStyle(color: AppColors.blackFontColor, fontSize: SizeConfig.fontSizeSmall),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: SizeConfig.screenWidth * .05,
          top: -SizeConfig.screenWidth * .07,
          child: Container(
            height: SizeConfig.screenWidth * .12,
            width: SizeConfig.screenWidth * .12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: AppColors.primaryColor.withOpacity(.2), blurRadius: 10, offset: Offset(0, 5))
              ],
            ),
            child: Container(
              height: SizeConfig.screenWidth * .05,
              width: SizeConfig.screenWidth * .05,
              margin: EdgeInsets.all(SizeConfig.screenWidth * .03),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: Padding(
                  padding: EdgeInsets.only(left: SizeConfig.screenWidth * .01, top: SizeConfig.screenWidth * .0),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: SizeConfig.screenWidth * .05,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
