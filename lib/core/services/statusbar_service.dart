import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';

enum StatusBarType { Gray, Dark, Light, White, OffGray, DoubleGray }

class StatusBarService {
  static void changeColor(Color color) {
    FlutterStatusbarcolor.setStatusBarColor(color);
  }

  static void changeStatusBarColor(StatusBarType statusBarType, BuildContext context) async{
    final _themeModel = Provider.of<AppThemeViewModel>(context, listen: false);
    final _appTheme = _themeModel.themeData;

//    switch(statusBarType){
//      case StatusBarType.Gray:
//        FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).backgroundColor);
//        break;
//      case StatusBarType.Dark:
//        FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).backgroundColor);
//        break;
//      case StatusBarType.Light:
//        await FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).cardColor);
//        break;
//      case StatusBarType.White:
//        FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).buttonColor);
//        break;
//      case StatusBarType.OffGray:
//        FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).cardColor);
//        break;
//      case StatusBarType.DoubleGray:
//        FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).cardColor);
//        break;
//      default:
//        FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).backgroundColor);
//    }






    //Sets icon color
    if (_appTheme == AppTheme.dark) {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.dark));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,));
    }
  }
}
