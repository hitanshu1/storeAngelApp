
import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/models/app_initiale_value.dart';
import 'package:storeangelApp/core/services/base_api.dart';
import 'package:storeangelApp/core/services/sharedPreference.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class SettingViewModel extends BaseModel{
  final _imagePicker = ImagePicker();
  bool darkMode=false;
  bool hasBackgroundImage=false;
  bool symbols=false;
  bool publishAllItems=false;
  double width = 0;
  double height = 0;
  double opacity=1;
  List<String> languages=AppSampleData.languages_en;
  List<String>themeModes=[AppStrings.automatic,AppStrings.darkMode,AppStrings.lightMode];
  String selectedLanguage;
  String selectedMode=AppStrings.automatic;
  bool showAnimation=false;
  final _prefs = getIt<AppSharedPreferences>();
  
  void navigatorPop() {
    navigationService.pop();
  }
  Future<void> navigateToScreen(
      String routeName, {
        Object arguments,
      }) async{
    await navigationService.navigateTo(routeName, arguments: arguments);
  }


  void onChangeOpacity(val){
    setState(ViewState.Busy);
    opacity=val;
    _prefs.setDouble(AppSharedPreferences.opacity, val);
    setState(ViewState.Idle);
  }

  void changeMode(value,theme){
    setState(ViewState.Busy);
    darkMode=value;
    showAnimation=true;
    Timer(const Duration(milliseconds: 300), () {
      showAnimation=false;
      theme.setTheme(value?AppTheme.dark:AppTheme.light);

      _prefs.setBool(AppSharedPreferences.darkMode, value);
    });


    setState(ViewState.Idle);

  }
  void onSelectLanguage(String value,BuildContext context)async{
    setState(ViewState.Busy);
    if(languages[1]==value){
      context.locale = Locale('de');
      languages = AppSampleData.languages_de;
      await Future.delayed(Duration(milliseconds: 600));
      selectedLanguage = languages[1];
    }else{
      context.locale = Locale('en', 'US');
      languages = AppSampleData.languages_en;
      await Future.delayed(Duration(milliseconds: 600));
      selectedLanguage = languages[2];
    }
    print('local: ${context.locale}');

    setState(ViewState.Idle);
  }

  String getLanguage(BuildContext context) {
    if(Locale('en','US')==context.locale){
      selectedLanguage = languages[2];
      return selectedLanguage;
    }else if(Locale('de')==context.locale){
      selectedLanguage = languages[1];
      return selectedLanguage;
    }else{
      return AppStrings.SELECT_LANGUAGE.tr();
    }
  }

  void onChangeMode(String value,theme){
    setState(ViewState.Busy);

    selectedMode=value;
    if(value==AppStrings.automatic){
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      bool _mode = brightness == Brightness.dark;
      theme.setTheme(_mode?AppTheme.dark:AppTheme.light);
      _prefs.setString(AppSharedPreferences.themeMode, value);
    }else if(value==AppStrings.darkMode){
      theme.setTheme(AppTheme.dark);
      _prefs.setString(AppSharedPreferences.themeMode, value);
    }else if(value==AppStrings.lightMode){
      theme.setTheme(AppTheme.light);
      _prefs.setString(AppSharedPreferences.themeMode, value);
    }



    setState(ViewState.Idle);
  }

  void onDataInitialize(BuildContext context)async{
    setState(ViewState.Busy);
    AppInitialValue value=await _prefs.getAppInitialValues();
    darkMode=value.darkMode;
    String val=await _prefs.getStringInPref(AppSharedPreferences.themeMode);
    if(themeModes.contains(val)){
      selectedMode=val;
    }

    if(context.locale.countryCode=='de'){
      languages = AppSampleData.languages_de;
    }
    
    hasBackgroundImage = value?.isBackgroundImageActive??false;
    
    //Set background image if possible
    if(value?.isBackgroundImageActive??false){
      try {
        _imageFile = File(value.backGroundImagePath);
      } catch (e) {
        print(e);
      }
    }

    double opacityValue = await _prefs.getDoubleInPref(AppSharedPreferences.opacity);
    if(opacityValue!=null) opacity = opacityValue;

    setState(ViewState.Idle);
  }

  void changeShowSymbols(value){
    setState(ViewState.Busy);
    symbols=value;
    setState(ViewState.Idle);
  }
  void changePublishValue(value){
    setState(ViewState.Busy);
    publishAllItems=value;
    setState(ViewState.Idle);
  }

  File _imageFile;
  File get imageFile =>_imageFile;

  Future<bool> openCamera() async {
    setState(ViewState.Busy);
    try {
      final _image = await _imagePicker.getImage(source: ImageSource.camera);

      //Select and save new image
      await selectAndSaveNewImage(File(_image.path));

      navigatorPop();
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }


  Future<bool> changeShowBackGroundImage(bool value)async{
    if(_imageFile?.path?.isNotEmpty??false){
      await _prefs.setBool(AppSharedPreferences.isBackgroundImageActive, value);

      hasBackgroundImage = true;
      setState(ViewState.Idle);
      return true;
    }

    hasBackgroundImage = false;
    setState(ViewState.Idle);
    return false;
  }

  Future<void> removeImage(AppThemeViewModel appThemeViewModel)async{
    _imageFile = null;
    await _prefs.setString(AppSharedPreferences.backgroundImage, null);
    await _prefs.setBool(AppSharedPreferences.isBackgroundImageActive, false);

    setState(ViewState.Idle);

  }

  Future<bool> getGalleryImage() async {
    setState(ViewState.Busy);
    try {
      final _image = await _imagePicker.getImage(source: ImageSource.gallery);

      //Select and save new image
      await selectAndSaveNewImage(File(_image.path));

      //Remove Dialog and update state
      navigatorPop();
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }

  Future<void> selectAndSaveNewImage(File imageFile)async{
    final String path = (await getApplicationDocumentsDirectory()).path;

    //Create new imageFile of Image
    final File localImage = await imageFile.copy('$path/${AppSharedPreferences.backgroundImage}.jpg');

    //save image to application
    await _prefs.setString(AppSharedPreferences.backgroundImage, localImage.path);

    //Updates the widget in screen
    _imageFile = imageFile;
  }
}