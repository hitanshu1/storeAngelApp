import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_details_two_viewmodel.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_details/item_list_with_price_widget.dart';

import 'order_customer_horizontal_list_widget.dart';

class CourierOrderDetailsTabTwo extends StatelessWidget {
  final OrderByStore orderByStore;
  CourierOrderDetailsTabTwo({this.orderByStore});
  @override
  Widget build(BuildContext context) {
    return BaseView<CourierOrderDetailsTwoViewModel>(
      onModelReady: (model)=>model.initialiseData(orderByStore),
      builder: (context,courierOrderDetailTwoViewModel,child){
        if(courierOrderDetailTwoViewModel.state==ViewState.Busy){
          return AppConstants.circulerProgressIndicator();
        }
        return Column(
          children: [
            SizeConfig.verticalSpaceSmall(),
            Padding(
              padding: SizeConfig.paddingWithHighVerticalSpace,
              child: OrderCustomerHorizontalListWidget(
                clients: orderByStore.clients,
                getOpacity: courierOrderDetailTwoViewModel.clientViewOpacity,
                onChangeClient: (ClientDetails client) {
                  courierOrderDetailTwoViewModel.onSelectClient(client);
                },),
            ),
            Padding(
              padding: SizeConfig.sidepadding,
              child: AppShapeItem(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor
                  ),
                  child: Padding(
                    padding: SizeConfig.padding,
                    child: Row(
                      children: [
                        Expanded(child: Text(AppStrings.CALCULATED_PAYMENT.tr())),
                        Container(
                          width: 70,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: Text('12')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizeConfig.verticalSpaceSmall(),

            Expanded(child: Padding(
              padding: SizeConfig.sidepadding,
              child: ItemListWithPriceWidget(products: orderByStore.products,),
            )),
            Padding(
              padding: SizeConfig.padding,
              child: ButtonWidget(onPressed: (){

              },buttonText: AppStrings.CHECK_PRICES.tr(),),
            ),

          ],
        );
      },
    );
  }
}
