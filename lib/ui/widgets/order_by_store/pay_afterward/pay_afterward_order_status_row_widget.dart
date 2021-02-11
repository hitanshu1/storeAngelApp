import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/ui/shared/order_circle_icon.dart';

class PayAfterWardOrderStatusRowWidget extends StatelessWidget {
  final OrderPurchaseStatus status;

  PayAfterWardOrderStatusRowWidget(
      {@required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OrderCircleIcon(
            isSelected: status == OrderPurchaseStatus.OrderPlaced || status == OrderPurchaseStatus.MoneyTransfer,
            selectedIcon: StoreangelIcons.shopping_cart_order_full,
            nonSelectedIcon: StoreangelIcons.shopping_card_order_icon),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.green,
          ),
        ),
        OrderCircleIcon(
            isSelected: status == OrderPurchaseStatus.OrderRunning || status == OrderPurchaseStatus.OrderDelivered,
            selectedIcon: StoreangelIcons.change_to_courier_profile_full,
            nonSelectedIcon: StoreangelIcons.change_to_courier_profile_screen),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.green,
          ),
        ),
        OrderCircleIcon(
            isSelected: status == OrderPurchaseStatus.OrderPlaced,
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
      ],
    );
  }
}
