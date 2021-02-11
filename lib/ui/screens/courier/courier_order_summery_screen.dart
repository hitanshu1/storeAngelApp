import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/models/participant.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/view_model_courier_order_summery.dart';
import 'package:storeangelApp/ui/screens/receipt_screen.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/custom_tile.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_delivery_details/courier_delivery_customer_details.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_offers/courier_order_dialog.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_delivered_summery/courier_order_summery_rating_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_delivered_summery/courier_summery_grocery_list_widget.dart';

class CourierOrderSummeryArguments{
  OrderByStore orderByStore;
  ClientDetails clientDetails;
  Participant participant;
  CourierOrderSummeryArguments({this.clientDetails,this.orderByStore,this.participant});
}

class CourierOrderSummeryScreen extends StatelessWidget {
  static const String routeName='courierOrderSummeryScreen';
  final CourierOrderSummeryArguments arguments;
  CourierOrderSummeryScreen({this.arguments});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<CourierOrderSummeryViewModel>(
        onModelReady: (model)=>model.initializeData(arguments.orderByStore,arguments.clientDetails,arguments.participant),
        builder: (context,courierOrderSummeryModel,child){
          if(courierOrderSummeryModel.state==ViewState.Busy){
            return AppConstants.circulerProgressIndicator();
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppHeader(
                  isBack: true,
                  height: SizeConfig.smallHeaderSize,
                  title: AppStrings.SUMMARY.tr(),
                  actions: [
                    IconButton(icon: Icon(StoreangelIcons.page,size: SizeConfig.iconSize,
                      color: AppColors.whiteColor,), onPressed: (){
                      courierOrderSummeryModel.navigateToScreen(ReceiptScreen.routeName,
                          arguments: arguments.participant);
                    })
                  ],
                  onBackPress: (){
                    MyUtils.showAppDialog(
                      context: context,
                      child: CustomDialog(
                        title: AppStrings.REVERT_ORDER_DELIVERED.tr(),
                        subTitle: AppStrings.WHEN_YOU_HAVENOT_DELIVERED.tr(),
                        onPressOk: () {
                          courierOrderSummeryModel.onCancel();
                        },
                      ),
                    );
                  },

                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
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
              CourierOrderSummeryRationWidget(),
              SizeConfig.verticalSliverMediumSpace(),
              SliverPadding(
                padding: SizeConfig.sidepadding,
                sliver: CourierSummaryGroceryListWidget(
                  products:arguments.participant.products,
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),

              SliverToBoxAdapter(
                child: CustomTile(
                  leadingText: AppStrings.TOTAL.tr()+":",
                  tradingText: AppStrings.euroSymbol+NumberService.totalPrice(arguments.participant.products, context),
                  tradingStyle: AppStyles.BlackStyleWithBold800Font_20(context),

                ),
              ),

              SizeConfig.verticalSliverSmallSpace(),

              SliverToBoxAdapter(
                child: CustomTile(
                  leadingText: AppStrings.BUDGET.tr()+":",
                  tradingText: AppStrings.euroSymbol+NumberService.totalPrice(arguments.participant.products, context),
                  tradingStyle: AppStyles.BlackStyleWithBold800Font_20(context),

                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),

              SliverToBoxAdapter(
                child: CustomTile(
                  leadingText: AppStrings.YOUR_FEE.tr()+":",
                  tradingText: AppStrings.euroSymbol+NumberService.totalPrice(arguments.participant.products, context),
                  tradingStyle: AppStyles.BlackStyleWithBold800Font_20(context),

                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),

              courierOrderSummeryModel.view==CourierOrderSummeryView.Repayment?SliverToBoxAdapter(
                child: CustomTile(
                  linearGradient: AppColors.redGradient,
                  leadingText: AppStrings.REPAYMENT.tr()+":",
                  leadingStyle: AppStyles.WhiteStyle_WithBold900_Font20,
                  tradingText: AppStrings.euroSymbol+NumberService.addAfterCommaTwoZeros('2.22', context),
                  tradingStyle: AppStyles.WhiteStyle_WithBold900_Font20,

                ),
              ):SliverToBoxAdapter(
                child: CustomTile(
                  leadingText: AppStrings.REPAYMENT.tr()+":",
                  leadingStyle: AppStyles.RedStyle_WithBold900_Font20,
                  tradingText: AppStrings.euroSymbol+NumberService.addAfterCommaTwoZeros('2.22', context),
                  tradingStyle: AppStyles.RedStyle_WithBold900_Font20,

                ),
              ),
              SizeConfig.verticalSliverMediumSpace(),
              courierOrderSummeryModel.view==CourierOrderSummeryView.Repayment?SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: ButtonWidget(onPressed: (){
                    courierOrderSummeryModel.onRepayment();

                  },buttonText: AppStrings.REPAYMENT.tr(),),
                ),
              ):SliverToBoxAdapter(),
              courierOrderSummeryModel.view==CourierOrderSummeryView.Repayment?SizeConfig.verticalSliverMediumSpace()
                  :SliverToBoxAdapter(),
              SliverToBoxAdapter(
                child: CustomTile(
                  isFixLeading: true,
                  leadingText: AppStrings.DELIVERY_TIME.tr()+":",
                  leadingStyle: AppStyles.BlackStyleFont_20(context),
                  tradingText: DateService.getDateFormatDdMMYyyyWithTimeWord(DateTime(2021,9,12,19,35).toIso8601String(), context),
                  tradingStyle: AppStyles.GrayStyleItalicFont16(context),

                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: CustomTile(
                  isFixLeading: true,
                  leadingText: AppStrings.DELIVERY_ADDRESS.tr()+":",
                  leadingStyle: AppStyles.BlackStyleFont_20(context),
                  tradingText: arguments.participant.clientDetails.addressWithName,
                  tradingStyle: AppStyles.GrayStyleItalicFont16(context),

                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: CustomTile(
                  isFixLeading: true,
                  leadingText: AppStrings.DELIVERY.tr()+":",
                  leadingStyle: AppStyles.BlackStyleFont_20(context),
                  tradingText: AppStrings.DIRECT_HAND_OVER.tr(),
                  tradingStyle: AppStyles.GrayStyleItalicFont16(context),

                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: CustomTile(
                  isFixLeading: true,
                  leadingText: AppStrings.TIME_OF_PAYMENT.tr()+":",
                  leadingStyle: AppStyles.BlackStyleFont_20(context),
                  tradingText: AppStrings.PREPAYMENT.tr(),
                  tradingStyle: AppStyles.GrayStyleItalicFont16(context),

                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: CustomTile(
                  isFixLeading: true,
                  leadingText: AppStrings.PAYMENT_METHOD.tr()+":",
                  leadingStyle: AppStyles.BlackStyleFont_20(context),
                  tradingText: AppStrings.PAYPAL.tr(),
                  tradingStyle: AppStyles.GrayStyleItalicFont16(context),

                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: CustomTile(
                  isFixLeading: true,
                  leadingText: AppStrings.ORDER_ID.tr()+":",
                  leadingStyle: AppStyles.BlackStyleFont_20(context),
                  tradingText: '234567',
                  tradingStyle: AppStyles.GrayStyleItalicFont16(context),

                ),
              ),
              SizeConfig.verticalSliverMediumSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: ButtonWidget(onPressed: (){
                    courierOrderSummeryModel.onEndOrder();

                  },buttonText: AppStrings.END_JOB.tr(),
                    gradient: courierOrderSummeryModel.view==CourierOrderSummeryView.Repayment?AppColors.blackGradient:
                    AppColors.primaryGradient,),
                ),
              ),
              SizeConfig.verticalSliverMediumSpace(),


            ],
          );
        },
      ),
    );
  }
}