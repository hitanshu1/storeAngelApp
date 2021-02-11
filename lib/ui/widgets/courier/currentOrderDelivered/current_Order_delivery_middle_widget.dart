import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/mobileSize.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_delivered_viewmodel.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/stepback_dialog.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/shared/view_courier_order_status_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_action_button.dart';
import 'package:storeangelApp/ui/widgets/orderDelivered/order_status_row_widget.dart';

class CurrentOrderDeliveryMiddleWidget extends StatelessWidget {
  final OrderOrPurchases order;
  CurrentOrderDeliveryMiddleWidget({this.order});


  final double widgetHeight=180;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizeConfig.verticalSpaceMedium(),
        Padding(
          padding: SizeConfig.sidepadding,
          child: CustomCard(
            child: Padding(
              padding: SizeConfig.sidepadding,
              child: Column(
                children: [
                  SizeConfig.verticalSpaceMedium(),
                  Padding(
                    padding:SizeConfig.sidepadding,
                    child: ViewCourierOrderStatusWidget(order: order,),
                  ),
                  SizeConfig.verticalSpaceSmall(),
                  Padding(
                    padding:SizeConfig.sidepadding,
                    child: OrderStatusRowWidget(status: order.status,),
                  ),
                  SizeConfig.verticalSpaceMedium(),
                ],
              ),
            ),
          ),
        ),
        SizeConfig.verticalSpaceMedium(),
        order.status==OrderPurchaseStatus.OrderPlaced?Column(
          children: [
            SizedBox(
              height: widgetHeight,
              child: Column(
                children: [
                  Text(AppConstants.getStatusTitle(order),style: AppStyles.GreenStyle_Font20(context),),
                  SizeConfig.verticalSpaceSmall(),
                  Text(AppStrings.euro+' '+'${NumberService.priceAfterConvert(order.orderAmount,context)}',
                    style: AppStyles.BlackStyleWithBold_Font36(context),),
                  SizeConfig.verticalSpaceMedium(),
                  Text(AppStrings.DELIVERY_DATE.tr(),
                    style: AppStyles.GreenStyle_Font20(context),),
                  SizeConfig.verticalSpaceSmall(),
                  Text(DateService.getDateFormatWithYear(order.selectedDate.toIso8601String(),
                      context),style: AppStyles.BlackStyleFont_20(context),),
                  SizeConfig.verticalSpace(SizeConfig.screenHeight*.008),
                  Text(order.timeDuration,style: AppStyles.BlackStyleFont_20(context),),
                ],
              ),
            ),
            SizeConfig.mobileSize==MobileSize.small?SizeConfig.verticalSpaceSmall():SizeConfig.verticalSpaceLarge(),

            CourierOrderActionButton(
                firstButtonText: AppStrings.UNDO.tr(),
                enableSecondBotton: false,
                firstButtonTap: (){
                },
                secondButtonText: AppStrings.PAYMENT_RECEIVED.tr(),
                secondButtonTap: (){
                  Provider.of<CourierOrderDeliveredViewModel>(context, listen: false).updateOrderStatus(OrderPurchaseStatus.MoneyTransfer);
                }
            )
          ],
        ):Padding(
          padding: SizeConfig.sidepadding,
          child: Column(
            children: [
              SizedBox(
                height: widgetHeight,
                child: Column(
                  children: [
                    ViewAppImage(
                      imageUrl: order.storeDetails.image,
                      height: SizeConfig.screenWidth*.12,
                      width: SizeConfig.screenWidth*.12 ,
                      radius: SizeConfig.smallBorderRadius*.5,
                    ),
                    SizeConfig.verticalSpaceSmall(),
                    Text(order.storeDetails.name,style: AppStyles.BlackStyleWithBold700_C30(context),),
                    SizeConfig.verticalSpaceSmall(),
                    Text(order.storeDetails.street,style: AppStyles.BlackStyleFont_20(context),),
                    SizeConfig.verticalSpaceSmall(),
                    Text(order.storeDetails.zipCity,style: AppStyles.BlackStyleFont_20(context),),
                    SizeConfig.verticalSpaceSmall(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: Theme.of(context).primaryColor,),
                        SizeConfig.horizontalSpaceSmall(),
                        Text(AppStrings.SHOW_ME_THE_LOCATION.tr(),style: AppStyles.BlackStyleFont_20(context),)
                      ],
                    ),
                  ],
                ),
              ),
              SizeConfig.mobileSize==MobileSize.small?SizeConfig.verticalSpaceSmall():SizeConfig.verticalSpaceLarge(),

              CourierOrderActionButton(
                  firstButtonText: AppStrings.UNDO.tr(),
                  firstButtonTap: (){
                    MyUtils.showAppDialog(context: context,child:
                    StepBackDialog(

                      onPressOk: (){

                        Provider.of<CourierOrderDeliveredViewModel>(context, listen: false).updateOrderStatus(OrderPurchaseStatus.OrderPlaced);
                        Provider.of<CourierOrderDeliveredViewModel>(context, listen: false).navigatorPop();
                      },
                    ));
                  },
                  secondButtonText: AppStrings.START_PURCHASE.tr(),
                  secondButtonTap: (){
                    Provider.of<CourierOrderDeliveredViewModel>(context, listen: false).updateOrderStatus(OrderPurchaseStatus.OrderPlaced);
                  }
              )
            ],
          ),
        ),
      ],
    );
  }
}
