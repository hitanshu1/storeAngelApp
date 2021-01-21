import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';

class CustomTile extends StatelessWidget {
  final String leadingText;
  final String tradingText;
  final TextStyle leadingStyle;
  final TextStyle tradingStyle;
  final bool isFixLeading;
  final String subtitle;
  final EdgeInsets padding;
  final Widget tradingWidget;
  final LinearGradient linearGradient;
  CustomTile({this.isFixLeading:false,this.subtitle,@required this.leadingText,this.tradingWidget,this.tradingText,this.padding,this.linearGradient,
  this.leadingStyle,this.tradingStyle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!=null?padding:SizeConfig.sidepadding,
      child: AppShapeItem(
        child: Container(

          decoration: BoxDecoration(
            color: linearGradient!=null?null:Theme.of(context).toggleableActiveColor,
            gradient: linearGradient
          ),
          child: Padding(
            padding: SizeConfig.paddingWithHighVerticalSpace,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isFixLeading?Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                    width: SizeConfig.screenWidth*.4,
                        child: Text(leadingText,style: leadingStyle??AppStyles.BlackStyleWithBold800Font_20(context),)),
                    SizeConfig.horizontalSpaceSmall(),
                    tradingWidget!=null?tradingWidget:tradingText!=null?Expanded(child: Text(tradingText,style: tradingStyle??AppStyles.GrayStyleItalicFont16(context))):Container()
                  ],
                ):Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(leadingText,style: leadingStyle??AppStyles.BlackStyleWithBold800Font_20(context),)),
                    tradingWidget!=null?tradingWidget:tradingText!=null?Text(tradingText,style: tradingStyle??AppStyles.GrayStyleItalicFont16(context)):Container()
                  ],
                ),
                subtitle!=null?SizeConfig.verticalSpaceSmall():Container(),
                subtitle!=null?Text(subtitle,style: AppStyles.GrayStyleItalicFontSmaller(context),):Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
