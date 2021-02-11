import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/models/participant.dart';
import 'package:storeangelApp/core/services/map_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/view_model_courier_delivery_details.dart';
import 'package:storeangelApp/ui/screens/courier/courier_order_summery_screen.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/buttonWithIcon.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/custom_tile.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_delivery_details/courier_delivery_customer_details.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_delivery_details/courier_delivery_item_list_widget.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class CourierDeliveryDetailsArguments{
  OrderByStore orderByStore;
  ClientDetails clientDetails;
  Participant participant;
  CourierDeliveryDetailsArguments({this.clientDetails,this.orderByStore,this.participant});
}

class CourierDeliveryDetailsScreen extends StatelessWidget {
  static const String routeName = 'courierDeliveryDetailsScreen';
  final CourierDeliveryDetailsArguments arguments;
  CourierDeliveryDetailsScreen({this.arguments});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<CourierDeliveryDetailsViewModel>(
        builder: (context,model,child){
          if(model.state==ViewState.Busy){
            return AppConstants.circulerProgressIndicator();
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppHeader(
                  isBack: true,
                  height: SizeConfig.smallHeaderSize,
                  title: AppStrings.YOUR_SHOPPING_LISTS.tr(),
                  actions: [
                    IconButton(
                        icon: Icon(StoreangelIcons.location_pin, color: AppColors.whiteColor,),
                        onPressed: () {
                          MapService.openMap(arguments.clientDetails.address);

                        })
                  ],
                ),
              ),
              SizeConfig.verticalSliverMediumSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: CourierDeliveryCustomerDetails(
                    participant: arguments.participant,
                    orderByStore: arguments.orderByStore,
                    clientDetails: arguments.clientDetails,
                  ),
                ),
              ),
              SizeConfig.verticalSliverMediumSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: ButtonWithIcon( onPressed: (){

                  },
                    buttonText: AppStrings.RECEIPT.tr(),
                    buttonColor: AppColors.blackGradient,
                    textColor: AppColors.whiteColor,
                    icon:StoreangelIcons.camera1 ,
                    iconColor: AppColors.whiteColor,
                  ),
                ),
              ),

              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: ButtonWidget(
                    buttonText: AppStrings.PRODUCTS_DELIVERED.tr(),
                    onPressed: (){
                      Navigator.of(context).pushNamed(CourierOrderSummeryScreen.routeName,
                          arguments: CourierOrderSummeryArguments(
                            participant: arguments.participant,
                              clientDetails: arguments.clientDetails,orderByStore: arguments.orderByStore
                          ));

                    },
                  ),
                ),
              ),
              SizeConfig.verticalSliverExtraLargeSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: TitleTextWidget(
                    title: AppStrings.ORDER_DETAILS.tr(),
                  ),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),

              SliverToBoxAdapter(
                child: CustomTile(
                  leadingText: AppStrings.CALCULATED_PAYMENT.tr()+":",
                  leadingStyle:AppStyles.BlackStyleFont_20(context),
                  tradingText: AppStrings.euroSymbol+NumberService.totalPrice(arguments.participant.products, context),),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              CourierDeliveryItemListWidget(products: arguments.participant.products,
                enableQuantity: true,),
              SizeConfig.verticalSliverMediumSpace(),

            ],
          );
        },
      ),
    );
  }
}
