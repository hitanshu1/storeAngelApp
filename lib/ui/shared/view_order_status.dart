import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';

class ViewOrderStatusWidget extends StatelessWidget {
  final OrderPurchaseStatus status;
  ViewOrderStatusWidget({@required this.status});

  Widget get statusWidget{
  switch (status) {
  case OrderPurchaseStatus.PlaceAOrder:
  return Center(child: Icon(StoreangelIcons.timer,
    color: AppColors.whiteColor,size: SizeConfig.mediumIcon,));
    case OrderPurchaseStatus.OrderPlaced:
      return Center(child: Icon(StoreangelIcons.shopping_basket,
        color: AppColors.whiteColor,size: SizeConfig.mediumIcon,));
    case OrderPurchaseStatus.Purchasing:
      return Center(child: Icon(StoreangelIcons.shopping_basket,
        color: AppColors.whiteColor,size: SizeConfig.mediumIcon,));
    case OrderPurchaseStatus.OrderRunning:
      return Center(child: Icon(StoreangelIcons.change_to_courier_profile_screen,
        color: AppColors.whiteColor,size: SizeConfig.mediumIcon,));
    case OrderPurchaseStatus.OrderDelivered:
      return Center(child: Icon(StoreangelIcons.shoppingBasket,
        color: AppColors.whiteColor,size: SizeConfig.mediumIcon,));
    case OrderPurchaseStatus.InOrder:
      return Center(child: Icon(StoreangelIcons.card,
        color: AppColors.whiteColor,size: SizeConfig.mediumIcon*.6));
  default:
  return  Center(child: Icon(StoreangelIcons.card,
    color: AppColors.whiteColor,size: SizeConfig.mediumIcon*.6,));
  }
}

  @override
  Widget build(BuildContext context) {
    return statusWidget;
  }
}
