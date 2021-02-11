import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

//Styles are sorted by color
class AppStyles {

  //Green color
  static TextStyle GreenStyleWithBold900_Font40(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor,fontSize: SizeConfig.fontSizeLargeExtraLarge,fontWeight:FontWeight.w900);
  static TextStyle GreenStyleWithBold800_Font16(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeSmall, fontWeight: FontWeight.w800);
  static TextStyle GreenStyleWithBold600_Font16(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeSmall, fontWeight: FontWeight.w600);
  static TextStyle GreenStyleWith_Font16(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeSmall);
  static TextStyle GreenStyleWithBold800_Font20(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w800);
  static TextStyle GreenStyleWithBold300_Font20(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w300);
  static TextStyle GreenStyleWithBold800_Font26(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w800);
  static TextStyle GreenStyleWithBold800_Font30(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeLarge, fontWeight: FontWeight.w800);
  static TextStyle GreenStyleWithBold900Font_36(BuildContext context)=>TextStyle(color: Theme.of(context).primaryColor,fontSize:SizeConfig.fontSizeLargeVeryLarge,fontWeight:FontWeight.w900);
  static TextStyle GreenStyleWithBold700Font_36(BuildContext context)=>TextStyle(color: Theme.of(context).primaryColor,fontSize:SizeConfig.screenHeight*.03,fontWeight:FontWeight.w700);
  static TextStyle GreenStyle_Font10(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeVerySmall);
  static TextStyle GreenStyle_Font20(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeMedium,);
  static TextStyle GreenStyle_Font20Italic(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeMedium,
  fontStyle: FontStyle.italic);
  static TextStyle GreenStyle_Font16(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeSmall,);
  static TextStyle GreenStyle_FontW50014(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor,fontSize: SizeConfig.fontSizeSmallVeryMedium,fontWeight: FontWeight.w500);
  static TextStyle GreenStyleWithBoldFont_24(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeLarger, fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor);
  static TextStyle GreenStyleWithw500Font_24(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeLarger, fontWeight: FontWeight.w500,color: Theme.of(context).primaryColor);

  static TextStyle GreenStyleWithNormalFont_24(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w300,color:Theme.of(context).primaryColor);
  static TextStyle GreenStyleWithBoldFont_C20(BuildContext context)=>TextStyle(fontSize: SizeConfig.forntSize20, fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor);

  static TextStyle GreenStyleWithBold800_Font40(BuildContext context)=>TextStyle(color:Theme.of(context).primaryColor,fontSize:SizeConfig.fontSizeLargeExtraLarge,fontWeight:FontWeight.w800);
  static TextStyle  GreenStyleFontWeight500_d24(BuildContext context) =>TextStyle(fontSize:SizeConfig.screenHeight*.022,color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500);




//black color
  static TextStyle BlackStyle_Font12(BuildContext context)=>TextStyle(color: Theme.of(context).focusColor, fontSize: 12);
  static TextStyle BlackStyleWithBold700_Font40(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLargeExtraLarge,fontWeight:FontWeight.w700);
  static TextStyle BlackStyleWithBold900_Font40(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLargeExtraLarge,fontWeight:FontWeight.w900);
  static TextStyle BlackStyleWithBold700_C30(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: 30,fontWeight:FontWeight.w700);
  static TextStyle BlackStyleWithBold800Font_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall, fontWeight: FontWeight.w800,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold600Font_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall, fontWeight: FontWeight.w600,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold800Font_12(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmallVeryMedium, fontWeight: FontWeight.w700,color: Theme.of(context).focusColor);
  static  BlackStyleWithBold700Font_18(BuildContext context)=>TextStyle(fontWeight: FontWeight.w700,fontSize: 12 ,
      color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold800Font_20(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w800,
      color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold800ItalicFont20(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w800,
      color: Theme.of(context).focusColor,fontStyle: FontStyle.italic);

  static TextStyle BlackStyleWithBold500Font_10(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w500,
      color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold600Font_20(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w600,
      color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold700Font_14(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeSmallVeryMedium, fontWeight: FontWeight.w700,
      color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold500Font_14(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeSmallVeryMedium, fontWeight: FontWeight.w500,
      color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithFont_15(BuildContext context)=>TextStyle(fontSize: 13, fontWeight: FontWeight.normal,
      color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBoldW700Font_15(BuildContext context)=>TextStyle(fontSize: 13, fontWeight: FontWeight.w500,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold900Font_20(BuildContext context)=>TextStyle(color: Theme.of(context).focusColor,
      fontSize:SizeConfig.fontSizeMedium,fontWeight:FontWeight.w900);
  static TextStyle BlackStyleWithBold700Font_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall, fontWeight: FontWeight.w700,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleFont_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall,color: Theme.of(context).focusColor);
  static TextStyle BlackUnderlineStyleFont_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall,fontWeight: FontWeight.w500,
      color: Theme.of(context).focusColor,decoration: TextDecoration.underline);
  static TextStyle BlackStyleFontW600_12(BuildContext context) =>TextStyle(fontSize:12,color: Theme.of(context).focusColor,fontWeight: FontWeight.w600);
  static TextStyle BlackStyleW500Font_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall,color: Theme.of(context).focusColor,
  fontWeight: FontWeight.w500);
  static TextStyle BlackStyleW500FontC16(BuildContext context) =>TextStyle(fontSize:16,color: Theme.of(context).focusColor,
      fontWeight: FontWeight.w500);
  static TextStyle  BlackStyleFont_20(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeMedium,color: Theme.of(context).focusColor);
  static TextStyle  BlackStyleFontw600_c13(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeMedium,color: Theme.of(context).focusColor,fontWeight: FontWeight.w600);
  static TextStyle  BlackStyleFontWeightSmall_20(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeMedium,color: Theme.of(context).focusColor, fontWeight: FontWeight.w400);
  static TextStyle  BlackStyleFontWeightSmall_24(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeLarge,color: Theme.of(context).focusColor, fontWeight: FontWeight.w300);
  static TextStyle BlackStyleFont_14(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmallVeryMedium,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold500_Font16(BuildContext context)=>TextStyle(color: Theme.of(context).focusColor, fontSize: SizeConfig.fontSizeSmall, fontWeight: FontWeight.w500);
  static TextStyle BlackStyleWithBold800Font_24(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeLarge, fontWeight: FontWeight.w800,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBoldFont_24(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeLarge, fontWeight: FontWeight.bold,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold600Font_24(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeLarge, fontWeight: FontWeight.w600,color:Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold_Font36(BuildContext context) =>TextStyle(color:Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLargeVeryLarge,fontWeight:FontWeight.bold);
  static TextStyle BlackStyleWithW500Font36(BuildContext context) =>TextStyle(color:Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLargeVeryLarge,fontWeight:FontWeight.w500);
  static TextStyle BlackStyleWithBold_FontC20(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.forntSize20,fontWeight:FontWeight.bold);
  static TextStyle BlackStyleWithNormal_Font36(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,
      fontSize: SizeConfig.fontSizeLargest,fontWeight:FontWeight.w300);
  static TextStyle BlackStyleWithBold_Font30(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLargest,fontWeight:FontWeight.bold);
  static TextStyle BlackStyle_Font10(BuildContext context)=> TextStyle(color:Theme.of(context).focusColor, fontSize: SizeConfig.fontSizeVerySmall);
  static TextStyle  BlackStyleFont_24(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeLarge,color: Theme.of(context).focusColor,);
  static TextStyle  BlackStyleFontWeight500_24(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeLarge,color: Theme.of(context).focusColor,
      fontWeight: FontWeight.w500);
  static TextStyle  BlackStyleFontWeight400_24(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeLarge,color: Theme.of(context).focusColor,
      fontWeight: FontWeight.w400);
  static TextStyle BlackStyleFont300_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall,color: Theme.of(context).focusColor,fontWeight: FontWeight.w500);
  static TextStyle BlackStyleFontBold_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall,color: Theme.of(context).focusColor,fontWeight: FontWeight.bold);

  static TextStyle  BlackStyleFontw300_20(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeMedium,color: Theme.of(context).focusColor,fontWeight: FontWeight.w300);

  static TextStyle  BlackStyleFontWeight500_13(BuildContext context) =>TextStyle(fontSize:13,color: Theme.of(context).focusColor, fontWeight: FontWeight.w500);
  static TextStyle  BlackStyleFontWeightSmall_12(BuildContext context) =>TextStyle(fontSize:12,color: Theme.of(context).focusColor, fontWeight: FontWeight.w400);
  static TextStyle  BlackStyleFontWeightSmall_15(BuildContext context) =>TextStyle(fontSize:15,color: Theme.of(context).focusColor, fontWeight: FontWeight.w300);
  static TextStyle  BlackStyleFontWeightSmall_17(BuildContext context) =>TextStyle(fontSize:17,color: Theme.of(context).focusColor, fontWeight: FontWeight.w300);
  static TextStyle BlackStyleFont_12(BuildContext context) =>TextStyle(fontSize:10,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleW600Font_12(BuildContext context) =>TextStyle(fontSize:10,color: Theme.of(context).focusColor,fontWeight: FontWeight.w600);
  static TextStyle  BlackStyleFont_c16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeLarge,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithw500_FontC18(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLarger,fontWeight:FontWeight.w500);
  static TextStyle BlackStyleWithBold_FontC18(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLarger,fontWeight:FontWeight.bold);
  static TextStyle BlackStyleNormal_FontC18(BuildContext context) =>TextStyle(color:Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLarger);

  static TextStyle LightBlackStyleNormal_FontC18(BuildContext context) =>TextStyle(color:Colors.black38,fontSize: SizeConfig.fontSizeLarger);

//white color
  static TextStyle BlackStyle_Font16(BuildContext context)=>TextStyle(fontSize:SizeConfig.fontSizeSmall,color:Theme.of(context).focusColor );
  static TextStyle BlackStyleW300Font16(BuildContext context)=>TextStyle(fontSize:SizeConfig.fontSizeSmall,color:Theme.of(context).focusColor,fontWeight: FontWeight.w300 );
  static TextStyle BlackStyleFont16Light(BuildContext context)=>TextStyle(fontSize:SizeConfig.fontSizeSmall,color:Theme.of(context).focusColor,fontWeight: FontWeight.w100,
  fontStyle: FontStyle.normal);
  static TextStyle BlackStyleFont20Light(BuildContext context)=>TextStyle(fontSize:SizeConfig.fontSizeMedium,color:Theme.of(context).focusColor,fontWeight: FontWeight.w100,
      fontStyle: FontStyle.normal);
  static TextStyle BlackStyleFont20W300(BuildContext context)=>TextStyle(fontSize:SizeConfig.fontSizeMedium,color:Theme.of(context).focusColor,fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal);
  static TextStyle BlackStyleFont16W300(BuildContext context)=>TextStyle(fontSize:SizeConfig.fontSizeSmall,color:Theme.of(context).focusColor,fontWeight: FontWeight.w300,
  );
  static TextStyle BlackStyle_WithW300_Font24(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeLarge,color:Theme.of(context).focusColor,fontWeight: FontWeight.w300,);
  static TextStyle WhiteStyle_Font16=TextStyle(fontSize:SizeConfig.fontSizeSmall,color: Colors.white);
  static TextStyle WhiteStyle_FontSmall=TextStyle(fontSize:SizeConfig.fontSizeSmall,color: Colors.white);
  static TextStyle WhiteStyle_Font20=TextStyle(fontSize: SizeConfig.fontSizeMedium,color:Colors.white,);
  static TextStyle WhiteStyle_WithBold900_Font20=TextStyle(fontSize: SizeConfig.fontSizeMedium,color:Colors.white,fontWeight: FontWeight.w900,);
  static TextStyle WhiteStyle_WithBold900_Font24=TextStyle(fontSize: SizeConfig.fontSizeLarge,color:Colors.white,fontWeight: FontWeight.w900,);
  static TextStyle WhiteStyle_WithBold_Font24=TextStyle(fontSize: SizeConfig.fontSizeLarge,color:Colors.white,fontWeight: FontWeight.bold,);
  static TextStyle WhiteStyle_WithBold900_Font36=TextStyle(fontSize: SizeConfig.fontSizeLargest,color:Colors.white,fontWeight: FontWeight.w900,);
  static TextStyle WhiteStyleWithFont24=TextStyle(fontSize: SizeConfig.fontSizeLarge,color:Colors.white,fontWeight: FontWeight.normal,);
  static TextStyle WhiteStyle_WithBold700_Font20=TextStyle(fontSize: SizeConfig.fontSizeMedium,color:Colors.white,fontWeight: FontWeight.w700,);
  static TextStyle WhiteStyleWithBold600_Font16= TextStyle(color:AppColors.whiteColor, fontSize: SizeConfig.fontSizeSmall, fontWeight: FontWeight.w600);
  static TextStyle WhiteStyleWithBold800_Font16= TextStyle(color:AppColors.whiteColor, fontSize: SizeConfig.fontSizeSmall, fontWeight: FontWeight.w800);
  //gray color
  static TextStyle GrayStyleWithBold800ItalicFont16(BuildContext context)=> TextStyle(color:Theme.of(context).textTheme.headline6.color, fontSize: SizeConfig.fontSizeSmall, fontWeight: FontWeight.w800,
      fontStyle: FontStyle.italic);
  static TextStyle GrayStyleWithBold800ItalicFont16LowOpacity(BuildContext context)=> TextStyle(color:Theme.of(context).textTheme.headline6.color.withOpacity(.3), fontSize: SizeConfig.fontSizeSmall, fontWeight: FontWeight.w800,
      fontStyle: FontStyle.italic);
  static TextStyle GrayStyle_Font20(BuildContext context)=>TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: SizeConfig.fontSizeMedium);
  static TextStyle GrayStyle_Font20W800(BuildContext context)=>TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: SizeConfig.fontSizeMedium,fontWeight: FontWeight.w800);
  static TextStyle GrayStyleWithBold500_Font16(BuildContext context)=>TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: SizeConfig.fontSizeSmall, fontWeight: FontWeight.w500);
  static TextStyle GrayStyle_Font16(BuildContext context)=>TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: SizeConfig.fontSizeSmall);
  static TextStyle GrayStyleItalicFont16(BuildContext context)=>TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: SizeConfig.fontSizeSmall,
  fontStyle: FontStyle.italic,fontWeight: FontWeight.w100);
  static TextStyle GrayStyleItalicFont20(BuildContext context)=>TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: SizeConfig.fontSizeMedium,
      fontStyle: FontStyle.italic,fontWeight: FontWeight.w100);
  static TextStyle GrayStyleItalicFontSmaller(BuildContext context)=>TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: SizeConfig.fontSizeSmaller,
      fontStyle: FontStyle.italic,fontWeight: FontWeight.w100);
  static TextStyle GrayStyle_FontMedium(BuildContext context)=>TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: SizeConfig.fontSizeMedium);
  static TextStyle GrayStyle_Font9(BuildContext context)=>TextStyle(color:Theme.of(context).textTheme.headline6.color, fontSize: 9);
  static TextStyle GrayStyle_Font24(BuildContext context)=>TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: SizeConfig.fontSizeLarge);
  static TextStyle GrayStyle_Font12(BuildContext context)=>TextStyle(color:Theme.of(context).textTheme.headline6.color, fontSize: 12);
  static TextStyle GrayStyle_FontC12W600(BuildContext context)=>TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: 12,fontWeight: FontWeight.w600);
  static TextStyle GrayStyle_Font10(BuildContext context)=>TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: 10);
  static TextStyle GrayStyleWithBold300_Font20(BuildContext context)=> TextStyle(color:Theme.of(context).textTheme.headline6.color, fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w300);
  static TextStyle GrayLightStyleWithBold500_Font20(BuildContext context)=> TextStyle(color:AppColors.grayLight, fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w500);


  //dark gray
  static TextStyle  GrayStyleFont_c16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeLarge,color: AppColors.lightGreyColor);


  //dark gray little
  static TextStyle darkGrayLittleStyle_Font10=TextStyle(color: AppColors.darkGrayLittleColor, fontSize: SizeConfig.fontSizeVerySmall);


  //dynamic

  static TextStyle GreenStyleWithw500Font_d24(BuildContext context)=>TextStyle(fontSize: SizeConfig.screenHeight*.022, fontWeight: FontWeight.w500,color: Theme.of(context).primaryColor);
  static TextStyle  BlackStyleFontWeight500_d24(BuildContext context) =>TextStyle(fontSize:SizeConfig.screenHeight*.022,color: Theme.of(context).focusColor, fontWeight: FontWeight.w500);
  static TextStyle  GrayStyleFontWeight500_d24(BuildContext context) =>TextStyle(fontSize:SizeConfig.screenHeight*.022,color: Theme.of(context).textTheme.headline6.color.withOpacity(.5), fontWeight: FontWeight.w500);

  static TextStyle  grayStyleFontWeight300_d02(BuildContext context) =>TextStyle(fontSize:SizeConfig.screenHeight*.02,color: Theme.of(context).textTheme.headline6.color, fontWeight: FontWeight.w300);
  static TextStyle  grayStyleFontWeight300_d02Italic(BuildContext context) =>TextStyle(fontSize:SizeConfig.screenHeight*.02,fontStyle: FontStyle.italic,color: Theme.of(context).textTheme.headline6.color, fontWeight: FontWeight.w300);
  static TextStyle BlackStyleWithBold700_D30(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.screenHeight*.04,fontWeight:FontWeight.w700);
  static TextStyle GreenStyleWithw500Font_d20(BuildContext context)=>TextStyle(fontSize: SizeConfig.screenHeight*.024, fontWeight: FontWeight.w500,color: Theme.of(context).primaryColor);
  static TextStyle BlackStyleWithw500_Fontd18(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.screenHeight*.024,fontWeight:FontWeight.w500);

  static TextStyle RedStyle_WithBold900_Font20=TextStyle(fontSize: SizeConfig.fontSizeMedium,color:AppColors.red,fontWeight: FontWeight.w900,);

}