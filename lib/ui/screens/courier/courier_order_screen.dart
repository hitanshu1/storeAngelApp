import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order/courier_onging_order_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order/prepare_order_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order/purchases_order_widget.dart';
import 'package:storeangelApp/ui/widgets/courier_order/courier_order_store_list.dart';
import 'courier_order/courier_order_delivered_summary_screen.dart';
import 'courier_order_details_screen.dart';

class CourierOrderScreen extends StatefulWidget {
  @override
  _CourierOrderScreenState createState() => _CourierOrderScreenState();
}

class _CourierOrderScreenState extends State<CourierOrderScreen> {
  final ScrollController _scrollController = ScrollController();




  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    UserModel user=Provider.of<UserModel>(context);

    return BaseView<CourierOrderViewModel>(
      onModelReady: (courierOrderViewModel) =>
          courierOrderViewModel.initialize(_scrollController,user.id),
      builder: (context, courierOrderViewModel, child) {
        if (courierOrderViewModel.state == ViewState.Busy){
          return CustomScaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: AppConstants.circulerProgressIndicator());
        }
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AppHeader(
                height: SizeConfig.smallHeaderSize,
                title:AppStrings.YOUR_ORDERS.tr() ,

              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: SizeConfig.paddingWithHighVerticalSpace,
                child: SizedBox(
                  height: SizeConfig.smallImageheight,
                  child: CourierOrderStoreListWidget(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: SizeConfig.sidepadding,
                child: TitleTextWidget(title: AppStrings.READY_ORDERS.tr()),
              ),
            ),
            SizeConfig.verticalSliverSmallSpace(),
            courierOrderViewModel.orders.length>0?SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, int index) {

                    return Padding(
                      padding: SizeConfig.sidepadding,
                      child: InkWell(
                        child: PrepareOrderWidget(
                          order: courierOrderViewModel.orders[index],index: index,
                        ),
                        onTap: ()async{
                          courierOrderViewModel.navigateToScreen(CourierOrderDetailsScreen.routeName, context,
                              arguments: courierOrderViewModel.orders[index]);

                        },
                      ),
                    );
                  },
                  childCount: courierOrderViewModel.orders.length,
                )):SliverToBoxAdapter(
                  child: Padding(
              padding:SizeConfig.paddingWithHighVerticalSpace.copyWith(
                    bottom: SizeConfig.screenHeight*.05
              ),
              child: Text(AppStrings.THERE_ARE_NO_PURCHASES_ON.tr(),
                  style: AppStyles.BlackStyleFont_20(context),
                  textAlign: TextAlign.center,),
            ),),
            SizeConfig.verticalSliverSmallSpace(),
            SliverToBoxAdapter(
              child: CourierOngoingOrderWidget(
                courierOrderViewModel: courierOrderViewModel,
                orderByStoreList:courierOrderViewModel.runningOrders,
              ),
            ),
            SizeConfig.verticalSliverSmallSpace(),
            SliverToBoxAdapter(
              child: Padding(
                padding: SizeConfig.sidepadding,
                child: TitleTextWidget(title: AppStrings.FINISHED_ORDERS.tr()),
              ),
            ),
            SizeConfig.verticalSliverSmallSpace(),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, int index) {

                    return Padding(
                      padding: SizeConfig.sidepadding,
                      child: InkWell(
                        onTap: (){
                          courierOrderViewModel.navigateToScreen(
                              CourierOrderDeliveredSummaryScreen.routeName, context,
                              arguments: courierOrderViewModel.pastedOrders[index]);
                        },
                        child: PurchasesOrderWidget(
                          order: courierOrderViewModel.pastedOrders[index],
                        ),
                      ),
                    );
                  },
                  childCount: courierOrderViewModel.pastedOrders.length,
                )),

          ],
        );
      },
    );
  }
}
