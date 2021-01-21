import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_delivered_viewmodel.dart';
import 'package:storeangelApp/ui/screens/courier/courier_order/courier_order_delivered_summary_screen.dart';
import 'package:storeangelApp/ui/shared/CustomFloatingActionButtonExtended.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/stepback_dialog.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_action_button.dart';


class CurrentOrderFloatingButton extends StatelessWidget {
  final OrderOrPurchases order;
  final CourierOrderDeliveredViewModel courierOrderDeliveredViewModel;

  CurrentOrderFloatingButton({this.order, this.courierOrderDeliveredViewModel});

  @override
  Widget build(BuildContext context) {
    if (order.status == OrderPurchaseStatus.Proposal) {

    } else if (order.status == OrderPurchaseStatus.MoneyTransfer) {

    } else if (order.status == OrderPurchaseStatus.OrderDelivered) {
      return CustomFloatingActionButtonExtended(
        label: CourierOrderActionButton(
            firstButtonText: AppStrings.UNDO.tr(),
            firstButtonTap: (){
              MyUtils.showAppDialog(
                  context: context,
                  child: StepBackDialog(
                    onPressOk: () {
                      courierOrderDeliveredViewModel.updateOrderStatus(OrderPurchaseStatus.OrderRunning);
                      courierOrderDeliveredViewModel.navigatorPop();
                    },
                  ));
            },
            secondButtonText: AppStrings.PRICE_CHECKED.tr(),
            secondButtonTap: (){
              courierOrderDeliveredViewModel.navigateToScreen(CourierOrderDeliveredSummaryScreen.routeName, arguments: order);
            }
        ),
      );
    }
    return Container();
  }
}
