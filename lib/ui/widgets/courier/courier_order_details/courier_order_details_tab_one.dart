import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_details_tabone_viewmodel.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_item_tile_widget.dart';

import 'courier_order_chat_widget.dart';
import 'package:easy_localization/easy_localization.dart';

import 'item_and_chat_tabbar_widget.dart';
import 'order_customer_horizontal_list_widget.dart';

class CourierOrderDetailsTabOne extends StatelessWidget {
  final OrderByStore orderByStore;
  CourierOrderDetailsTabOne({this.orderByStore});
  @override
  Widget build(BuildContext context) {
    return BaseView<CourierOrderDetailsTabOneViewModel>(
      onModelReady: (model)=>model.initialiseData(orderByStore),
      builder: (context,courierOrderDetailsTabOneViewModel,child){
        return Column(
          children: [
            Padding(
              padding: SizeConfig.paddingWithHighVerticalSpace,
              child: OrderCustomerHorizontalListWidget(
                clients: orderByStore.clients,
                getOpacity: courierOrderDetailsTabOneViewModel.clientViewOpacity,
                onChangeClient: (ClientDetails client) {
                  courierOrderDetailsTabOneViewModel.onSelectClient(client);
                },),
            ),


            Padding(
              padding: SizeConfig.sidepadding,
              child: ItemAndChatTabBarWidget(
                value: courierOrderDetailsTabOneViewModel.isChat,
                onChanged: (bool value){
                  courierOrderDetailsTabOneViewModel.onChangeValue(value);
                },

              ),
            ),
            SizeConfig.verticalSpaceSmall(),
            courierOrderDetailsTabOneViewModel.isChat ?Expanded(child: CourierOrderChatWidget()):
             Expanded(
              child: Padding(
                padding: SizeConfig.sidepadding,
                child: AppShapeItem(
                  child: Container(
                    color: Theme.of(context).toggleableActiveColor,
                    child: Padding(
                      padding: SizeConfig.innersidepadding,
                      child: ListView.builder(itemCount: orderByStore.products.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context,int index){
                        return CourierItemTileWidget(
                          enableQuantity: true,
                          product: orderByStore.products[index],
                          isBorder: index!=orderByStore.products.length-1,
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
            SizeConfig.verticalSpaceSmall(),
            Padding(
              padding: SizeConfig.sidepadding,
              child: ButtonWidget(onPressed: () {

              },
                buttonText: courierOrderDetailsTabOneViewModel.isChat
                    ?  AppStrings.FINISH_SHOPPING.tr():
                AppStrings.SHOPPING_NOW.tr(),
                gradient: courierOrderDetailsTabOneViewModel.isChat
                    ? AppColors.redGradient:AppColors.primaryGradient,),
            ),
            SizeConfig.verticalSpaceMedium(),
          ],
        );
      },
    );
  }
}
