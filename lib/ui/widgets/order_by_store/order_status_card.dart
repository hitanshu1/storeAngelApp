import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/ui/widgets/orderDelivered/order_status_row_widget.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/pay_afterward/pay_afterward_order_status_row_widget.dart';

class OrderStatusCard extends StatelessWidget {
  final OrderPurchaseStatus status;
  final bool prePaid;

  OrderStatusCard({this.status, this.prePaid: true});

  String get title {
    if (status == OrderPurchaseStatus.Proposal) {
      return AppStrings.PAYMENT_IS_PENDING.tr();
    } else if (status == OrderPurchaseStatus.MoneyTransfer) {
      return AppStrings.COURIER_RECEIVED_PAYMENT.tr();
    } else if (status == OrderPurchaseStatus.OrderAccepted) {
      return AppStrings.SHOPPING_IN_PROGRESS.tr();
    } else if (status == OrderPurchaseStatus.OrderRunning) {
      return AppStrings.YOUR_PURCHASE_WILL_BE_DELIVERED_SOON.tr();
    } else {
      return '';
    }
  }

  Widget cardView(OrderPurchaseStatus status, BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppStyles.GreenStyleWithBoldFont_24(context),
        ),
        SizeConfig.CVerticalSpacevMedium(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth*.07),
          child: prePaid
              ? OrderStatusRowWidget(
                  status: status,
                )
              : PayAfterWardOrderStatusRowWidget(
                  status: status,
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConfig.sidepadding,
      child: cardView(status, context),
    );
  }
}
