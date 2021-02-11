
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'dart:io' show Platform;

class IconService{

  static IconData getStatusIcon(OrderPurchaseStatus status){
    if(status==OrderPurchaseStatus.PlaceAOrder){
      return StoreangelIcons.timer;
    }else if(status==OrderPurchaseStatus.OrderRunning){
      return StoreangelIcons.change_to_courier_profile_screen;
    }
    return StoreangelIcons.shoppingBasket;
  }
  static IconData get backIcon{
    if (Platform.isAndroid) {
      return Icons.arrow_back;
    } else{
      return Icons.arrow_back_ios;
    }
  }
}