import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/models/app_initiale_value.dart';

class AppSharedPreferences {
  static const String pref_isLogin_key = 'login';
  static const String pref_uid_key = 'uid';
  static const String longitude = 'longitude';
  static const String latitude = 'latitude';
  static const String currentAddress = 'currentAddress';
  static const String darkMode = 'darkMode';
  static const String isAlreadyString = 'isAlready';
  static const String themeMode = 'themeMode';
  static const String backgroundImage = 'backgroundImage';
  static const String isBackgroundImageActive = 'isBackgroundImageActive';
  static const String opacity = 'opacity';

  Future<AppInitialValue> getAppInitialValues() async {
    String mode = await getStringInPref(themeMode);
    bool _darkMode = false;

    //Get Dark Mode
    if (mode == AppStrings.automatic) {
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      _darkMode = brightness == Brightness.dark;
    } else if (mode == AppStrings.darkMode) {
      _darkMode = true;
    } else if (mode == AppStrings.lightMode) {
      _darkMode = false;
    } else {
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      _darkMode = brightness == Brightness.dark;
    }

    //Get is Already logged in
    bool isAlready = await getBoolInPref(isAlreadyString);

    //Get hasBackgroundImage
    String _backgroundImagePath;
    bool _isBackgroundImageActive = await getBoolInPref(isBackgroundImageActive);
    if (_isBackgroundImageActive) {
       _backgroundImagePath = await getStringInPref(backgroundImage);
    }

    double opacity = 1;
    double opacityValue = await getDoubleInPref(AppSharedPreferences.opacity);
    print('opacityTxt: $opacityValue');
    if(opacityValue!=null) opacity = opacityValue;

    return AppInitialValue(
        darkMode: _darkMode ?? false,
        isAlready: isAlready ?? true,
        opacity: opacity,
        isBackgroundImageActive: _isBackgroundImageActive ?? false,
        backGroundImagePath: _backgroundImagePath);
  }

  Future setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future setBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future setInteger(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  Future setDouble(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  Future<String> getStringInPref(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? "";
  }

  Future<bool> getBoolInPref(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(key) ?? false;
  }

  Future<int> getIntegerInPref(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key) ?? 0;
  }

  Future<double> getDoubleInPref(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(key)??null;
  }

  clearAllPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }
}
