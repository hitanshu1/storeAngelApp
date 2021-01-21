import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/ui/shared/order_circle_icon.dart';

class OrderStatusRowWidget extends StatelessWidget {
  final OrderPurchaseStatus status;
  OrderStatusRowWidget(
      {this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OrderCircleIcon(
              isSelected: status == OrderPurchaseStatus.Proposal,
              selectedIcon: StoreangelIcons.hourglass_full,
              nonSelectedIcon: StoreangelIcons.hourglass1),
          Expanded(
            child: Container(
              height: 1,
              color: AppColors.green,
            ),
          ),
          OrderCircleIcon(
              isSelected: status == OrderPurchaseStatus.MoneyTransfer,
              selectedIcon: StoreangelIcons.credit_card_order_flow_icon_full,
              nonSelectedIcon: StoreangelIcons.credit_card_order_flow_icon),
          Expanded(
            child: Container(
              height: 1,
              color: AppColors.green,
            ),
          ),
          OrderCircleIcon(
              isSelected: status == OrderPurchaseStatus.OrderAccepted || status == OrderPurchaseStatus.PriceCheck,
              selectedIcon: StoreangelIcons.shopping_cart_order_full,
              nonSelectedIcon: StoreangelIcons.shopping_card_order_icon),
          Expanded(
            child: Container(
              height: 1,
              color: AppColors.green,
            ),
          ),
          OrderCircleIcon(
              isSelected: status == OrderPurchaseStatus.OrderRunning,
              selectedIcon: StoreangelIcons.change_to_courier_profile_full,
              nonSelectedIcon: StoreangelIcons.change_to_courier_profile_screen),
        ],
      ),
    );
  }
}
