import 'package:flutter/material.dart';
import 'package:storeangelApp/core/models/app_initiale_value.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class AppThemeViewModel extends BaseModel {
  ThemeData _themeData;
  AppInitialValue initialThemeSettings;

  AppThemeViewModel(this._themeData, this.initialThemeSettings);

  ThemeData get themeData =>_themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;
    setState(ViewState.Idle);
  }

  void changeThemeSettings({bool darkMode, bool isAlready, bool isBackgroundImageActive, String backgroundImagePath,double opacity}) {
    initialThemeSettings = AppInitialValue(
        darkMode: darkMode ?? initialThemeSettings.darkMode,
        isAlready: isAlready ?? initialThemeSettings.isAlready,
        isBackgroundImageActive: isBackgroundImageActive ?? initialThemeSettings.isBackgroundImageActive,
        backGroundImagePath: backgroundImagePath ?? initialThemeSettings.backGroundImagePath,
    opacity: opacity??initialThemeSettings.opacity);
    setState(ViewState.Idle);
  }
}
