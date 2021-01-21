import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order_details.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/store_order_details_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
                    actions: [
                      InkWell(
                          child: Icon(Icons.add, color: AppColors.whiteColor,),
                          onTap: () {

                          })
                    ],
                  ),
                ),
                SizeConfig.verticalSliverSmallSpace(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: SizeConfig.sidepadding,
                    child: StoreOrderDetailsWidget(orderByStore: widget.order,),
                  ),
                ),
                SliverFillRemaining(
                    child: TabBarView(
                        controller: controller,
                        children: <Widget>[
                          CourierOrderDetailsTabOne(
                            orderByStore: widget.order,
                          ),
                          CourierOrderDetailsTabTwo(orderByStore: widget.order,),
                          CourierOrderDetailsTabThree(orderByStore: widget.order,
                            courierOrderDetailsViewModel: courierOrderDetailsViewModel,)
                        ])
                ),

              ],
            );
          }
        },
      ),
    );
  }
}
