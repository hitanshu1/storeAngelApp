import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_details_two_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order_details.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_details/item_list_with_price_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_details/tab_two_client_details_widget.dart';
import 'order_customer_horizontal_list_widget.dart';

class CourierOrderDetailsTabTwo extends StatelessWidget {
  final OrderByStore orderByStore;
  final bool showAllTogether;
  CourierOrderDetailsTabTwo({this.orderByStore,this.showAllTogether});
  @override
  Widget build(BuildContext context) {
    return BaseView<CourierOrderDetailsTwoViewModel>(
      onModelReady: (model)=>model.initialiseData(orderByStore),
      builder: (context,courierOrderDetailTwoViewModel,child){
        if(courierOrderDetailTwoViewModel.state==ViewState.Busy){
          return AppConstants.circulerProgressIndicator();
        }
        return MultiSliver(
          children: [
            SizeConfig.verticalSliverSmallSpace(),
            SliverToBoxAdapter(
              child: Padding(
                padding: SizeConfig.paddingWithHighVerticalSpace,
                child: OrderCustomerHorizontalListWidget(
                  orderByStore: orderByStore,
                  clients: orderByStore.clients,

                  isSelectAll: false,
                  getOpacity: courierOrderDetailTwoViewModel.clientViewOpacity,
                  checkSelected: courierOrderDetailTwoViewModel.isSelected,
                  onChangeClient: (ClientDetails client) {
                    courierOrderDetailTwoViewModel.onSelectClient(client);
                  },),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:SizeConfig.padding,
                child: TitleTextWidget(title: AppStrings.PLEASE_CHECK_THE_PRICE.tr()+":"),
              ),
            ),
            SizeConfig.verticalSliverSmallSpace(),
            SliverToBoxAdapter(
              child: Padding(
                padding: SizeConfig.sidepadding,
                child: AppShapeItem(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).toggleableActiveColor
                    ),
                    child: Padding(
                      padding: SizeConfig.padding,
                      child: Row(
                        children: [
                          Expanded(child: Text(AppStrings.CALCULATED_PAYMENT.tr()+":",
                          style: AppStyles.BlackStyleFont_20(context),)),
                          Container(
                            width: 70,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Text(AppStrings.euroSymbol+NumberService.addAfterCommaTwoZeros(NumberService.totalPrice(courierOrderDetailTwoViewModel.products, context), context),
                            style: AppStyles.BlackStyleFont16Light(context),)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizeConfig.verticalSliverSmallSpace(),
            showAllTogether?SliverPadding(
              padding: SizeConfig.sidepadding,
              sliver: ItemListWithPriceWidget(
                products: courierOrderDetailTwoViewModel.products,),
            ):SliverPadding(
              padding: SizeConfig.sidepadding,
              sliver: MultiSliver(
                children: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {

                        return TabTwoClientDetailsWidget(
                          clientDetails: orderByStore.participants[index].clientDetails,
                          products: courierOrderDetailTwoViewModel.orderByStore.participants[index].products,
                        );
                      },
                      childCount: courierOrderDetailTwoViewModel.orderByStore.participants.length,
                    ),
                  ),
                  SizeConfig.verticalSliverMediumSpace(),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Consumer<CourierOrderDetailsViewModel>(builder: (context,model,child){
                return Padding(
                  padding: SizeConfig.padding,
                  child: ButtonWidget(onPressed: (){
                    model.onChangeView(CourierOrderView.DeliveryAddress);

                  },buttonText: AppStrings.CHECK_PRICES.tr(),),
                );
              }),
            ),

          ],
        );
      },
    );
  }
}
