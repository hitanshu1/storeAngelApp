
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';

import 'apptheme.dart';


class AppColors {

  static const Color primaryColor = Color(0xFF27BB8B);
  static const Color backgroundColor = Color(0xFFF0EBE6);
  static const Color backgroundDarkColor = Color(0xFF19191E);
  static const Color facebookButtonColor = Color(0xFF3b5998);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackFontColor = Color(0xFF333333);
  static const Color black = Color(0xFF000000);
  static final Color lightGreyColor = Colors.grey[400];
  static const Color lightGrayDotColor = Color(0xFFD8D8D8);
  static const Color darkCardColor = Color(0xFF313237);
  static const Color secondDarkCardColor = Color(0xFF46474e);
  static const Color thirdDarkColor = Color(0xFF575861);
  static const Color darkGrayColor = Color(0xFF777777);
  static const Color grayFont = Color(0xFF878787);
  static const Color grayDarkThemeFont = Color(0xFFd9d9d9);
  static const Color darkGrayLittleColor = Color(0xFF9B9B9B);
  static const Color lightGrayLittleColor = Color(0xFFDDDDDD);
  static const Color grayBackgroundColor = Color(0xFFF7F7F7);
  static final Color amber = Color(0xFFFcd303);
  static final Color red = Color(0xFFF81B08).withOpacity(1);
  static final Color veryLightGrayColor = Color(0xFFF6F6F6).withOpacity(1);
  static final Color activeColor = Color(0xFF28BE8C).withOpacity(1);
  static final Color bottomNavigationBarDarkColor = Color(0xFF23232a);
  static final Color bottomNavigationBarLightColor = backgroundColor;
  static const Color ownTextMessageColor = Color(0xFF969696);
  static final Color otherTextMessageColor = Colors.grey[300];
  static final Color blueVerifyColor = Color(0xFF1787E0);
  static final Color textBackgroundColor=Color(0XFFFFFFFF).withOpacity(.5);


  static  Color dividerColor(BuildContext context)=>
  Provider.of<AppThemeViewModel>(context).themeData == AppTheme.dark
  ? AppColors.backgroundColor
      : Theme.of(context).primaryColorLight;



  static const Color greenLigthColorMarkerCircle1 = Color.fromRGBO(
      39, 187, 139, 0.09);
  static const Color greenLigthColorMarkerCircle2 = Color.fromRGBO(
      39, 187, 139, 0.06);
  static const Color greenLigthColorMarkerCircle3 = Color.fromRGBO(
      39, 187, 139, 0.04);

  static const Color green = Color.fromRGBO(39, 187, 139, 1);
  static const LinearGradient blackGradient = LinearGradient(
      colors: [
        Color(0xFF555555),
        Color(0xFF878787),
      ],
      stops: [0.0, 1.0],
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter,
      tileMode: TileMode.repeated);
  static const LinearGradient primaryGradient= LinearGradient(
      colors: [
        Color(0xFF28BE8C),
        Color(0xFF28D287),
      ],
      stops: [0.0, 1.0],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 0.0),
      tileMode: TileMode.clamp);
  static const LinearGradient primarySecondGradient= LinearGradient(
      colors: [
        Color(0xFF28D287),
        Color(0xFF28BE8C),
      ],
      stops: [0.0, 1.0],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 0.0),
      tileMode: TileMode.clamp);
  static const LinearGradient amberGradient= LinearGradient(
      colors: [
        Color(0xFFFF6E3C),
        Color(0xFFFF8C3C),
      ],
      stops: [0.0, 1.0],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 0.0),
      tileMode: TileMode.clamp);
  static const LinearGradient blueGradient= LinearGradient(
      colors: [
        Color(0xFF1478B9),
        Color(0xFF1496B9),
      ],
      stops: [0.0, 1.0],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 0.0),
      tileMode: TileMode.clamp);
  static const LinearGradient redGradient= LinearGradient(
      colors: [
        Color(0xFFC82819),
        Color(0xFFE14623),
      ],
      stops: [0.0, 1.0],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 0.0),
      tileMode: TileMode.clamp);

  static LinearGradient getStatusColor(OrderPurchaseStatus status){
    if(status==OrderPurchaseStatus.Pending){
      return amberGradient;
    }
    return blueGradient;

  }
  static Color availableStatusColor(AvailableStatus availableStatus){
    if(availableStatus==AvailableStatus.plenty){
      return  AppColors.green;
    }else if(availableStatus ==AvailableStatus.few){
      return AppColors.amber;
    }else if(availableStatus==AvailableStatus.runOut){
      return  AppColors.red;
    }else{
      return AppColors.green;
    }
  }

}




