import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_details_tabone_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order_details.dart';
import 'package:storeangelApp/ui/screens/courier/courier_item_details_screen.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/sliver_app_shape_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_item_tile_widget.dart';
import 'package:storeangelApp/ui/widgets/order_details_and_chat/client_details_tile.dart';
import 'courier_order_chat_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'courier_order_details_tab_one_clientlist_widget.dart';
import 'item_and_chat_tabbar_widget.dart';
class CourierOrderDetailsTabOne extends StatelessWidget {
  final OrderByStore orderByStore;
  final bool showAllTogether;
  CourierOrderDetailsTabOne({this.orderByStore,this.showAllTogether});
  @override
  Widget build(BuildContext context) {
    return BaseView<CourierOrderDetailsTabOneViewModel>(
      onModelReady: (model)=>model.initialiseData(orderByStore),
      builder: (context,courierOrderDetailsTabOneViewModel,child){
        return MultiSliver(
          children: [
            SliverToBoxAdapter(
              child: Padding(
                padding: SizeConfig.paddingWithHighVerticalSpace,
                child: CourierOrderDetailsTabOneClientListWidget(
                  clients: orderByStore.clients,
                  participants: orderByStore.participants,
                  isSelectAll: courierOrderDetailsTabOneViewModel.isSelectAll,
                  onSelectAll: courierOrderDetailsTabOneViewModel.onSelectAll,

                  getOpacity: courierOrderDetailsTabOneViewModel.clientViewOpacity,
                  checkSelected: courierOrderDetailsTabOneViewModel.isSelected,
                  onChangeClient: (ClientDetails client) {
                    courierOrderDetailsTabOneViewModel.onSelectClient(client);
                  },),
              ),
            ),


            SliverToBoxAdapter(
              child: Padding(
                padding: SizeConfig.sidepadding,
                child: ItemAndChatTabBarWidget(
                  value: courierOrderDetailsTabOneViewModel.isChat,
                  onChanged: (bool value){
                    courierOrderDetailsTabOneViewModel.onChangeValue(value);
                  },

                ),
              ),
            ),

            SizeConfig.verticalSliverSmallSpace(),
            courierOrderDetailsTabOneViewModel.isChat ?SliverFillRemaining(
                child: Column(
                  children: [
                    Expanded(child: CourierOrderChatWidget()),
                    SizeConfig.verticalSpaceMedium(),
                    Consumer<CourierOrderDetailsViewModel>(builder: (context,model,child){
                      return  Padding(
                        padding: SizeConfig.sidepadding,
                        child: ButtonWidget(onPressed: () {
                          if( courierOrderDetailsTabOneViewModel.isChat){
                            model.onChangeView(CourierOrderView.CheckPrices);
                            model.onPlaceOrder();
                          }else{
                            if(courierOrderDetailsTabOneViewModel.changePage){
                              model.onChangeView(CourierOrderView.CheckPrices);
                            }else{
                              model.onPlaceOrder();
                              courierOrderDetailsTabOneViewModel.onClickShopping();
                            }
                          }

                        },
                          buttonText: courierOrderDetailsTabOneViewModel.isChat||courierOrderDetailsTabOneViewModel.changePage
                              ?  AppStrings.FINISH_SHOPPING.tr():
                          AppStrings.SHOPPING_NOW.tr(),
                          gradient: courierOrderDetailsTabOneViewModel.isChat||courierOrderDetailsTabOneViewModel.changePage
                              ? AppColors.redGradient:AppColors.primaryGradient,),
                      );
                    },),
                    SizeConfig.verticalSpaceMedium(),
                  ],
                )):SliverPadding(padding:  SizeConfig.sidepadding,
            sliver: showAllTogether?MultiSliver(
              children: [
                SliverAppShapeWidget(
                  child: SliverPadding(
                    padding: SizeConfig.padding,
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return InkWell(
                            onTap: (){
                              courierOrderDetailsTabOneViewModel.navigateToScreen(CourierItemDetailsScreen.routeName,
                                  arguments: CourierItemDetailsArguments(
                                    orderByStore: courierOrderDetailsTabOneViewModel.orderByStore,
                                      products: courierOrderDetailsTabOneViewModel.orderByStore.products,
                                      selectedProduct: courierOrderDetailsTabOneViewModel.products[index],
                                      clients: courierOrderDetailsTabOneViewModel.selectedClients
                                  ));
                            },
                            child: CourierItemTileWidget(
                              onClickStatus: (){
                                courierOrderDetailsTabOneViewModel.onChangeProductStatus(index);
                              },
                              enableQuantity: true,
                              isItalicFont: false,
                              editStatus: true,
                              product: courierOrderDetailsTabOneViewModel.products[index],
                              isBorder: index!=courierOrderDetailsTabOneViewModel.products.length-1,
                            ),
                          );
                        },
                        childCount: courierOrderDetailsTabOneViewModel.products.length,
                      ),
                    ),
                  )),
                SizeConfig.verticalSliverMediumSpace(),
                Consumer<CourierOrderDetailsViewModel>(builder: (context,model,child){
                  return  SliverToBoxAdapter(
                    child: ButtonWidget(onPressed: () {

                      if( courierOrderDetailsTabOneViewModel.isChat){
                        model.onPlaceOrder();
                        model.onChangeView(CourierOrderView.CheckPrices);
                      }else{
                        if(courierOrderDetailsTabOneViewModel.changePage){
                          model.onChangeView(CourierOrderView.CheckPrices);

                        }else{
                          model.onPlaceOrder();
                          courierOrderDetailsTabOneViewModel.onClickShopping();
                        }



                      }

                    },
                      buttonText: courierOrderDetailsTabOneViewModel.isChat||courierOrderDetailsTabOneViewModel.changePage
                          ?  AppStrings.FINISH_SHOPPING.tr():
                      AppStrings.SHOPPING_NOW.tr(),
                      gradient: courierOrderDetailsTabOneViewModel.isChat||courierOrderDetailsTabOneViewModel.changePage
                          ? AppColors.redGradient:AppColors.primaryGradient,),
                  );
                },),
              ],
            ):MultiSliver(
              children: [
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {

                        return ClientDetailsTileWidget(
                          participant: orderByStore.participants[index],
                        );
                      },
                      childCount: courierOrderDetailsTabOneViewModel.orderByStore.participants.length,
                    ),
                  ),
                SizeConfig.verticalSliverMediumSpace(),
                Consumer<CourierOrderDetailsViewModel>(builder: (context,model,child){
                  return  SliverToBoxAdapter(
                    child: ButtonWidget(onPressed: () {

                      if( courierOrderDetailsTabOneViewModel.isChat){

                      }else{
                        if(courierOrderDetailsTabOneViewModel.changePage){
                          model.onChangeView(CourierOrderView.CheckPrices);


                        }else{
                          courierOrderDetailsTabOneViewModel.onClickShopping();
                          model.onToggleShowAll();
                        }

                      }

                    },
                      buttonText: courierOrderDetailsTabOneViewModel.isChat||courierOrderDetailsTabOneViewModel.changePage
                          ?  AppStrings.FINISH_SHOPPING.tr():
                      AppStrings.SHOPPING_NOW.tr(),
                      gradient: courierOrderDetailsTabOneViewModel.isChat||courierOrderDetailsTabOneViewModel.changePage
                          ? AppColors.redGradient:AppColors.primaryGradient,),
                  );
                },),
              ],
            ),
            ),

            SizeConfig.verticalSliverMediumSpace(),
          ],
        );
      },
    );
  }
}
