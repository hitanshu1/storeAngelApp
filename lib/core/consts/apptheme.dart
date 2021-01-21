import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

import 'appColors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    fontFamily: 'Roboto',
    backgroundColor: AppColors.backgroundColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    canvasColor: AppColors.backgroundColor,
    cardColor: AppColors.whiteColor,
    textTheme: TextTheme(
        bodyText2: TextStyle(fontSize: SizeConfig.fontSizeMedium, color: AppColors.blackFontColor),
        headline6: TextStyle(color: Colors.black.withOpacity(.7)),
        headline5: TextStyle(color: Colors.black.withOpacity(.9)),
        headline3: TextStyle(color: Colors.black38),
        subtitle2: TextStyle(
          fontSize: 12,
          color: AppColors.darkGrayColor,
        ),
        subtitle1: TextStyle(fontSize: 16, color: AppColors.whiteColor),
      headline4: TextStyle(fontSize: SizeConfig.fontSizeSmall, color: AppColors.grayFont)
    ),
    primaryColor: AppColors.primaryColor,
    selectedRowColor: AppColors.grayBackgroundColor.withOpacity(1),
    accentColor: AppColors.primaryColor,
    focusColor: AppColors.black,
    splashColor: AppColors.primaryColor.withOpacity(.15),
    highlightColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.black,
        opacity: 1.0,
        size:24.0),
    primaryColorLight: AppColors.lightGrayLittleColor,
    colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
    buttonColor: AppColors.whiteColor,
    primarySwatch: Colors.green,
    primaryColorDark: AppColors.lightGreyColor,
    secondaryHeaderColor: AppColors.backgroundColor,
    disabledColor: AppColors.black.withOpacity(.3),
    toggleableActiveColor: AppColors.textBackgroundColor,
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      backgroundColor: AppColors.bottomNavigationBarLightColor,
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: AppColors.primaryColor,
    ),
    dividerColor: AppColors.grayFont,
  );

  static ThemeData dark = ThemeData(
    fontFamily: 'Roboto',
    backgroundColor: AppColors.backgroundDarkColor,
    scaffoldBackgroundColor: AppColors.backgroundDarkColor,
    canvasColor: AppColors.backgroundDarkColor,
    cardColor: AppColors.darkCardColor,
    bottomAppBarColor: AppColors.backgroundDarkColor,
    bottomAppBarTheme: BottomAppBarTheme(color: AppColors.backgroundDarkColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: AppColors.bottomNavigationBarDarkColor),
    buttonColor: AppColors.backgroundDarkColor,
    disabledColor: AppColors.black.withOpacity(.3),
    iconTheme: IconThemeData(color: AppColors.whiteColor,
        opacity: 1.0,
        size:24.0),
    textTheme: TextTheme(
        bodyText2: TextStyle(fontSize: SizeConfig.fontSizeMedium, color: AppColors.whiteColor),
        subtitle2: TextStyle(fontSize: 12, color: AppColors.grayDarkThemeFont),
        subtitle1: TextStyle(fontSize: 16, color: AppColors.grayDarkThemeFont),
        headline6: TextStyle(color: AppColors.grayDarkThemeFont),
        headline5: TextStyle(color: AppColors.grayDarkThemeFont),
        headline3: TextStyle(color: Colors.white60),
        headline4: TextStyle(fontSize: SizeConfig.fontSizeSmall, color: AppColors.whiteColor.withOpacity(.85))),
    focusColor: AppColors.whiteColor,
    primaryColor: AppColors.primaryColor,
    selectedRowColor: Colors.grey[700],
    accentColor: AppColors.primaryColor,
    splashColor: AppColors.primaryColor.withOpacity(.15),
    highlightColor: Colors.transparent,
    toggleableActiveColor: AppColors.secondDarkCardColor,
    colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
    primaryColorLight: AppColors.secondDarkCardColor,
    secondaryHeaderColor:  Colors.grey[800],
    primarySwatch: Colors.green,
    primaryColorDark: AppColors.whiteColor,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: AppColors.primaryColor,
    ),
    dividerColor: AppColors.whiteColor,
  );
}
