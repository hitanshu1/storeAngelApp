import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_candidate_details.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/custom_tile.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderDetailsWidget extends StatelessWidget {
  final CourierCandidate candidate;
  final OrderOrPurchases order;
    OrderDetailsWidget({this.candidate,this.order});


  Widget paymentStatusWidget(String title,bool active,BuildContext context){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(active?Icons.done:Icons.clear,color: active?AppColors.primaryColor:AppColors.red,),
        SizeConfig.horizontalSpaceSmall(),
        Text(title,style: AppStyles.BlackStyleFont_16(context),)
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CourierCandidateDetailsViewModel>(
        builder: (context,courierCandidateDetailsViewModel,child){
      return Column(
        children: [
          SizeConfig.verticalSpaceMedium(),
          CustomTile(leadingText: AppStrings.DELIVERY_PERIOD.tr(),
            leadingStyle: AppStyles.BlackStyleFont_20(context),
            subtitle: DateService.getDateWithHourFormat(order.purchaseDetails.time.toIso8601String(), context),),
          SizeConfig.verticalSpaceMedium(),
          CustomTile(leadingText: AppStrings.PURCHASE_VALUE.tr(),
            tradingStyle: AppStyles.GrayStyleWithBold800ItalicFont16LowOpacity(context),
            tradingText: AppStrings.euroSymbol+NumberService.priceAfterConvert(order.orderAmount, context),),
          SizeConfig.verticalSpaceSmall(),
          CustomTile(leadingText: AppStrings.SUPPLIER_FEE.tr(),
            tradingStyle: AppStyles.GrayStyleWithBold800ItalicFont16LowOpacity(context),
            tradingText: AppStrings.euroSymbol+NumberService.priceAfterConvert(5, context),),
          SizeConfig.verticalSpaceSmall(),
          CustomTile(leadingText: AppStrings.YOUR_BUDGET.tr()+":",
            tradingText: AppStrings.euroSymbol+NumberService.priceAfterConvert(order.orderAmount+5, context),
            linearGradient: AppColors.blackGradient,
            tradingStyle: AppStyles.WhiteStyleWithBold800_Font16.copyWith(fontStyle: FontStyle.italic),
            leadingStyle: AppStyles.WhiteStyle_WithBold900_Font20,),
          SizeConfig.verticalSpaceMedium(),
          Padding(
            padding:SizeConfig.sidepadding,
            child: AppShapeItem(
              child: Container(
                color: Theme.of(context).toggleableActiveColor,
                child: Padding(
                  padding: SizeConfig.padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizeConfig.verticalSpaceSmall(),
                      Text(AppStrings.PAYMENT_METHOD.tr()+":",style: AppStyles.BlackStyleFont_20(context),),
                      SizeConfig.verticalSpaceSmall(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                paymentStatusWidget(AppStrings.PAYPAL.tr(), true, context),
                                paymentStatusWidget(AppStrings.KLARNA.tr(), false, context),
                                paymentStatusWidget(AppStrings.GOOGLE_PAY.tr(), true, context),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                paymentStatusWidget(AppStrings.APPLE_PAY.tr(), true, context),
                                paymentStatusWidget(AppStrings.CREDIT_CARD.tr(), true, context),
                                paymentStatusWidget(AppStrings.CASH.tr(), true, context),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizeConfig.verticalSpaceSmall(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizeConfig.verticalSpaceMedium(),

          Padding(
            padding: SizeConfig.sidepadding,
            child: ButtonWidget(onPressed: (){
              courierCandidateDetailsViewModel.onSubmit(order);

            },buttonText: AppStrings.INSTRUCT.tr(),),
          ),
          SizeConfig.verticalSpaceMedium(),
        ],
      );
    });
  }
}
