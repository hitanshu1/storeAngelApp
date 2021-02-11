import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';

import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';

class CustomTileWithIcon extends StatelessWidget {

  final IconData iconData;
  final String titleText;
  final EdgeInsets padding;
  final Color iconColor;
  final Function onTap;
  final double iconSize;
  final TextStyle style;
  CustomTileWithIcon({this.style,this.titleText,this.iconSize,this.padding,@required this.iconData,this.iconColor,this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!=null?padding:SizeConfig.sidepadding,
      child: AppShapeItem(

        child: GestureDetector(
          onTap:onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Provider.of<AppThemeViewModel>(context).themeData == AppTheme.dark
                  ?Theme.of(context).toggleableActiveColor:AppColors.cardColor,
            ),
            child: Padding(
              padding: SizeConfig.paddingWithHighVerticalSpace,
              child: Row(

                children: [
                  SizeConfig.horizontalSpaceSmall(),
                  Icon(iconData,color: iconColor,size: iconSize??SizeConfig.iconSize,),

                  SizeConfig.horizontalSpaceMedium(),
                  Text(titleText,style:style?? AppStyles.BlackStyleFontw300_20(context),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
