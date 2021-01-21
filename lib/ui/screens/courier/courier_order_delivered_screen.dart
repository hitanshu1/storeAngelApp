import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_delivered_viewmodel.dart';
import 'package:storeangelApp/ui/screens/courier/courier_order/courier_current_order_tabscreen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/widgets/courier/currentOrderDelivered/courier_order_delivered_bottombar.dart';
import 'package:storeangelApp/ui/widgets/courier/currentOrderDelivered/currentOrderFloatingButtonWidget.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';

import 'courier_order/courier_chattab_screen.dart';
import 'courier_order/courier_detailstab_screen.dart';

class CourierOrderDeliveredScreen extends StatefulWidget {
  static const String routeName = 'courierOrderDeliveredScreen';
  final CourierOrderDeliveredScreenArgument argument;

  CourierOrderDeliveredScreen({this.argument});

  @override
  _CourierOrderDeliveredScreenState createState() => _CourierOrderDeliveredScreenState();
}

class _CourierOrderDeliveredScreenState extends State<CourierOrderDeliveredScreen> {
  bool expanded = false;
  bool showTitle = false;

  Widget _viewList(CourierOrderDeliveredViewModel model) {
    if (model.currentIndex == 1) {
      return CourierChatTabScreen(
        order: widget.argument.order,
      );
    } else if (model.currentIndex == 2) {
      return CourierDetailsTabScreen(
        order: widget.argument.order,
      );
    } else {
      return CourierCurrentOrderTabScreen(
        order: widget.argument.order,
        isExpanded: showTitle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Light, context);
    return BaseView<CourierOrderDeliveredViewModel>(
      onModelReady: (courierOrderDeliveredViewModel) =>
          courierOrderDeliveredViewModel.initialize(widget.argument.order, widget.argument.initialIndex),
      builder: (context, courierOrderDeliveredViewModel, child) {
        if (courierOrderDeliveredViewModel.state == ViewState.Busy) {
          return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: AppConstants.circulerProgressIndicator());
        }
        return CustomScaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: _viewList(courierOrderDeliveredViewModel),
          floatingActionButtonLocation:
              expanded ? FloatingActionButtonLocation.endFloat : FloatingActionButtonLocation.miniCenterFloat,
          floatingActionButtonAnimator: NoScalingAnimation(),
          floatingActionButton: courierOrderDeliveredViewModel.currentIndex == 0
              ? CurrentOrderFloatingButton(
                  order: courierOrderDeliveredViewModel.order,
                  courierOrderDeliveredViewModel: courierOrderDeliveredViewModel,
                )
              : Container(),
          bottomNavigationBar: CourierOrderDeliveredBottomNavigationBar(
            currentIndex: courierOrderDeliveredViewModel.currentIndex,
            onSelectIndex: (int index) {
              courierOrderDeliveredViewModel.onSelectIndex(index);
            },
          ),
        );
      },
    );
  }
}

class CourierOrderDeliveredScreenArgument {
  final OrderOrPurchases order;
  final initialIndex;

  CourierOrderDeliveredScreenArgument({this.order, this.initialIndex});
}
