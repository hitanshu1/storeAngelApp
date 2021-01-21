
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';

class IconService{

  static IconData getStatusIcon(OrderPurchaseStatus status){
    if(status==OrderPurchaseStatus.Pending){
      return StoreangelIcons.timer;
    }
    return StoreangelIcons.shopping_cart_order_full;
  }
}