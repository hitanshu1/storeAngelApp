import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order_details.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_offers/courier_order_dialog.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_details/courier_order_details_store_tile_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_details/courier_order_details_tab_one.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_details/courier_order_details_tab_three.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_details/courier_order_details_tab_two.dart';

class CourierOrderDetailsScreen extends StatefulWidget {
  static const String routeName = 'courierOrderDetailsScreen';
  final OrderByStore order;
  CourierOrderDetailsScreen({this.order});

  @override
  _CourierOrderDetailsScreenState createState() => _CourierOrderDetailsScreenState();
}

class _CourierOrderDetailsScreenState extends State<CourierOrderDetailsScreen>  with SingleTickerProviderStateMixin {
  TabController controller;


  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  int currentIndex = 0;
  Widget detailsWidget(CourierOrderView view, bool showAllTogether) {
    switch (view) {
      case CourierOrderView.ProductListAndChat:
        return CourierOrderDetailsTabOne(
          orderByStore: widget.order, showAllTogether: showAllTogether,
        );
      case CourierOrderView.CheckPrices:
        return CourierOrderDetailsTabTwo(orderByStore: widget.order,showAllTogether:showAllTogether);
      case CourierOrderView.DeliveryAddress:
        return CourierOrderDetailsTabThree(orderByStore: widget.order,
        );
      default:
        return CourierOrderDetailsTabOne(
          orderByStore: widget.order,
        );
    }
  }


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resizeToAvoidBottomInset: false,
      body: BaseView<CourierOrderDetailsViewModel>(
        onModelReady: (model) => model.initialiseData(widget.order),
        builder: (context, courierOrderDetailsViewModel, child) {
          if (courierOrderDetailsViewModel.state == ViewState.Busy) {
            return AppConstants.circulerProgressIndicator();
          } else {
            return CustomScrollView(

              slivers: [
                SliverToBoxAdapter(
                  child: AppHeader(
                    height: SizeConfig.smallHeaderSize,
                    isBack: true,
                    title: AppStrings.YOUR_SHOPPING_LISTS.tr(),
                    actions: widget.order.clients.length > 1 &&courierOrderDetailsViewModel.view!=CourierOrderView.DeliveryAddress?[
                    IconButton(icon: Icon(
                        courierOrderDetailsViewModel.showAllTogether
                            ? StoreangelIcons.separateList
                            : StoreangelIcons.listTogether,
                        color: AppColors.whiteColor,), onPressed: () {
                        courierOrderDetailsViewModel.onToggleShowAll();
                      })
                    ]:null,

                    onBackPress: courierOrderDetailsViewModel.view==CourierOrderView.DeliveryAddress?(){
                      MyUtils.showAppDialog(
                        context: context,
                        child: CustomDialog(
                          title: AppStrings.REVERT_PURCHASE_ORDER.tr(),
                          subTitle: AppStrings.WHEN_YOU_HAVENOT_STARTED.tr(),
                          onPressOk: () {
                            courierOrderDetailsViewModel.onCancel();
                          },
                        ),
                      );
                    }:null,
                  ),
                ),
                SizeConfig.verticalSliverMediumSpace(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: SizeConfig.sidepadding,
                    child: CourierOrderDetailsStoreTileWidget(),
                  ),
                ),
                detailsWidget(courierOrderDetailsViewModel.view,
                    courierOrderDetailsViewModel.showAllTogether)


              ],
            );
          }
        },
      ),
    );
  }
}
