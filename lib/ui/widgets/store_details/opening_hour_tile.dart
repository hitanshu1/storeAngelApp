
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';

import 'package:easy_localization/easy_localization.dart';
class OpeningHourTile extends StatelessWidget {


  Widget viewTime(String title,String subTitle,BuildContext context,{bool isActive:false,TextStyle style}){
    return Padding(
      padding: SizeConfig.smallerVerticalPadding3,
      child: Row(
        children: [
          SizedBox(width: SizeConfig.screenWidth*.3,
              child: Text(title,style: style??AppStyles.BlackStyleFont_20(context),)),
          Text(subTitle,style: style??AppStyles.BlackStyleFont_20(context),)
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: SizeConfig.sidepadding,
        child: AppShapeItem(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).toggleableActiveColor
            ),

            child: Padding(
              padding: SizeConfig.padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeConfig.verticalSpaceSmall(),
                  Text(AppStrings.OPENING_HOUR.tr()+":",style: AppStyles.BlackStyleWithBold800Font_20(context),),
                  SizeConfig.verticalSpaceSmall(),
                  viewTime(AppStrings.MONDAY.tr(), '7:00 - 22:00 Uhr',context),
                  viewTime(AppStrings.TUESDAY.tr(), '7:00 - 22:00 Uhr',context),
                  viewTime(AppStrings.WEDNESDAY.tr(), '7:00 - 22:00 Uhr',context),
                  viewTime(AppStrings.THURSDAY.tr(), '7:00 - 22:00 Uhr',context),
                  viewTime(AppStrings.FRIDAY.tr(), '7:00 - 22:00 Uhr',context,style: AppStyles.GreenStyle_Font20(context)),
                  viewTime(AppStrings.SATURDAY.tr(), '7:00 - 22:00 Uhr',context),
                  viewTime(AppStrings.SUNDAY.tr(), '7:00 - 22:00 Uhr',context),
                ],
              ),
            ),
          ),

        ),
      ),
    );
  }
}
