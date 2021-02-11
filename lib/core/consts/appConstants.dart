import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';

import '../enums/user_type.dart';
import 'appColors.dart';
import 'appString.dart';
import 'apptheme.dart';


class AppConstants {
  //todo Move Api keys into external folder
  static String faceBookClientID = "739736566948754";
  static const String googleApiKey = "AIzaSyAe_-BcQ0SfzSGi_agWugy2MPC9ay286v8";
  static const String googleQueryLink = 'https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=$googleApiKey&language=us&input=';
  static bool darkMode = false;
  static UserType userType = UserType.Customer;

//current location
  static double currentLatitude = 0.0;
  static double currentLogitute = 0.0;

//font size
  static const double fontSizeVeryLarge = 40;
  static const double fontSizeMedium = 20;
  static const double fontSizeSmall = 16;
  static const double fontSizeLarge = 24;
  static const double cardElevation = 3;

//radius
  static const double introGetStarted_button_Radius = 20.0;
  static const double backArrowContainreRightRadius = 25;
  static const double RadiusMedium = 20;
  static const double ContainerRoundCorner_Radius = 10;

  static const double ContainerMediumRoundCorner_Radius = 20;
  static const double button_Radius = 15.0;
  static const double appBar_Radius = 40;
  static const double radius = 3;
  static const double radiusSmall = 6;

//icon size
  static const double signUpDropDown_IconSize = 24;
  static const double mainTab_IconSize = 28;
  static const double iconHeightWidth = 350;
  static const double smallIconheight = 13;

  //signin page
  static const double RoundViewButtonRadius = 30;
  static const double EmailPasswordWidgetRadius = 20;

  //signup page
  static const double backArrowContainreHeight = 50;
  static const double backArrowContainreWidth = 60;
  static const double backArrowContainrheight = 70;

  static const double RoundSignupButton_ContainerHeight = 60;
  static const double ShadowBox_SpreadRadius = 5;
  static const double ShadowBox_BlurRadius = 10;
  static const double ShadowBox_WithOpacity = 0.1;
  static const double ShadowBox_Offset = 3;

  //DecideUserType Screen item widget
  static const double Image_height = 100;
  static const double Card_Height = 240;

  //margin -padding
  static const double Card_margin = 10;
  static const double TextField_Contentpading = 10.0;
  static const double TextField_Contentpading_top = 10.0;
  static const double marginMedium = 30.0;
  static const double marginsmall = 10.0;
  static const double marginSmallLarge = 12.0;
  static const double marginLarge = 80;
  static const double marginVerySmall = 2;
  static const double marginVerySmall1 = 5;
  static const double marginVeryVerySmall = 1;
  static const double margin15 = 15;

  //height-width
  static const double imageHeight_width_Very_small = 15;
  static const double imageHeight_width_small = 20;
  static const double imageHeight_width = 25;
  static const double ContainerHeight_width = 30;
  static const double ContainerHeight_widthLarge = 100;
  static const double ContainerHeight_widthLargeSmall = 160;
  static const double ContainerHeight_widthVeryLarg = 170;
  static const double ContainerHeight_widthVeryLarg1 = 130;
  static const double ContsinerHeight_WidthC140 = 140;
  static const double ContainerHeight_widthMedium = 55;
  static const double ContainerHeight_widthMediumlarge = 85;

  //signup round button
  static const double ShadowBox_SpreadRadius_medium = 7;
  static const double ShadowBox_BlurRadius_Medium = 7;
  static const double ShadowBox_WithOpacityMedium = 0.2;

  //listview
  static const double List_itemExtent = 360;

  //rattingbar
  static const int RatingBar_opacity = 50;
  static const int Ratingbar_item_count = 5;
  static const double Ratingbar_itemSize = 13.0;

  //dash line
  static const double dash_width = 7;
  static const double empty_width = 6;

  static Widget circulerProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  var _formatter = DateFormat.yMMMMd('en_US');

  String pickDate(DateTime picked) {
    if (picked != null) {
      String formatted = _formatter.format(picked,);
      return formatted;
    }
    return '';
  }

  String formattedDate(date) => DateFormat('yyyy-MM-dd – kk:mm').format(date);

  static String getTimeString(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final aDate = DateTime(date.year, date.month, date.day);

    if (aDate == today) {
      return '${AppStrings.TODAY_AT.tr()}${DateFormat('kk:mm').format(date)}';
    } else if (aDate == yesterday) {
      return '${AppStrings.YESTERDAY_AT.tr()}${DateFormat('kk:mm').format(date)}';
    } else if (aDate == tomorrow) {
      return '${AppStrings.TOMORROW_AT.tr()}${DateFormat('kk:mm').format(date)}';
    } else {
      return '${aDate.day}/${aDate.month}/${aDate.year} at ${DateFormat('kk:mm').format(date)}';
    }
  }

  static String getMonth(int month) {
    if (month == 1) {
      return 'Jan.';
    } else if (month == 2) {
      return 'Feb.';
    } else if (month == 3) {
      return 'Mar.';
    } else if (month == 4) {
      return 'Apr.';
    } else if (month == 5) {
      return 'May';
    } else if (month == 6) {
      return 'Jun';
    } else if (month == 7) {
      return 'Jul.';
    } else if (month == 8) {
      return 'Aug.';
    } else if (month == 9) {
      return 'Sep.';
    } else if (month == 10) {
      return 'Oct.';
    } else if (month == 11) {
      return 'Nov.';
    } else if (month == 12) {
      return 'Dec.';
    } else {
      return '';
    }
  }

  static Icon get addIcon {
    return Icon(
      Icons.add_circle,
      color: AppColors.green,
      size: SizeConfig.mediumIcon,
    );
  }

  static String changeDateformate(String dateString) {
    var dateTime = DateTime.parse(dateString);
    String date = '${DateFormat('dd.MM.yyyy').format(dateTime)}';
    return date;
  }

  static String messageTime(DateTime dateTime) {
    String time = DateFormat('KK:mm').format(dateTime);
    return time;
  }


  static String getStatusTitle(OrderOrPurchases order) {
    if (order.status == OrderPurchaseStatus.PlaceAOrder) {
      return AppStrings.PENDING_PAYMENT.tr();
    } else if (order.status == OrderPurchaseStatus.MoneyTransfer) {
      return AppStrings.PAYMENT_RECEIVED.tr();
    } else if (order.status == OrderPurchaseStatus.OrderPlaced) {
      return AppStrings.PURCHASE_ORDER.tr();
    }  else if (order.status == OrderPurchaseStatus.OrderRunning) {
      return AppStrings.DELIVERING_ORDER.tr();
    } else if (order.status == OrderPurchaseStatus.OrderDelivered) {
      return AppStrings.ORDER_DELIVERED.tr();
    } else {
      return '';
    }
  }


  static Border bottomBorder(BuildContext context) {
    return Border(
        bottom: BorderSide(
      color: Provider.of<AppThemeViewModel>(context).themeData == AppTheme.dark
          ? AppColors.thirdDarkColor
          : Theme.of(context).primaryColorLight,
    ));
  }

  static Color paymentIconBackgroundColor(BuildContext context) {
    return Provider.of<AppThemeViewModel>(context).themeData == AppTheme.dark
        ? AppColors.secondDarkCardColor
        : AppColors.whiteColor;
  }

  static double animationEndPoint(int position) {
    final int maxExtent = 150;
    if (position > maxExtent) {
      return 0.0;
    } else if (position <= 0) {
      return 1.0;
    }
    final value = 1 - position / maxExtent;
    return value;
  }
  static void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
