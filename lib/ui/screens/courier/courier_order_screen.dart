
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
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
import 'package:storeangelApp/ui/widgets/courier/courier_request/courier_store_list_widget.dart';

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
    return BaseView<CourierOrderViewModel>(
      onModelReady: (courierOrderViewModel) =>
          courierOrderViewModel.initialize(_scrollController),
      builder: (context, courierOrderViewModel, child) {
        if (courierOrderViewModel.state == ViewState.Busy) {
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
                  child: CourierStoreListWidget(stores: courierOrderViewModel.stores,),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: SizeConfig.sidepadding,
                child: TitleTextWidget(title: AppStrings.PREPARE_ORDERS.tr()),
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
                          order: courierOrderViewModel.orders[index],
                        ),
                        onTap: ()async{

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
            ),
                ),
            SliverToBoxAdapter(
              child: CourierOngoingOrderWidget(
                courierOrderViewModel: courierOrderViewModel,
                orderByStoreList:courierOrderViewModel.orderByStoreList,
              ),
            ),
            SizeConfig.verticalSliverSmallSpace(),
            SliverToBoxAdapter(
              child: Padding(
                padding: SizeConfig.sidepadding,
                child: TitleTextWidget(title: AppStrings.PURCHASES_DONE.tr()),
              ),
            ),
            SizeConfig.verticalSliverSmallSpace(),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, int index) {

                    return Padding(
                      padding: SizeConfig.sidepadding,
                      child: PurchasesOrderWidget(
                        order: courierOrderViewModel.orders[index],
                      ),
                    );
                  },
                  childCount: courierOrderViewModel.orders.length,
                )),

          ],
        );
      },
    );
  }
}
