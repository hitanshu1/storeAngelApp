import 'package:flutter/material.dart';

import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';

class CustomTileWithIcon extends StatelessWidget {

  final IconData iconData;
  final String titleText;
  final EdgeInsets padding;
  final Color iconColor;
  final Function onTap;
  CustomTileWithIcon({this.titleText,this.padding,@required this.iconData,this.iconColor,this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!=null?padding:SizeConfig.sidepadding,
      child: AppShapeItem(
        child: GestureDetector(
          onTap:onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).toggleableActiveColor,
            ),
            child: Padding(
              padding: SizeConfig.paddingWithHighVerticalSpace,
              child: Row(

                children: [
                  SizeConfig.horizontalSpaceSmall(),
                  Icon(iconData,color: iconColor,),

                  SizeConfig.horizontalSpaceMedium(),
                  Text(titleText,style: AppStyles.BlackStyleFontw300_20(context),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
