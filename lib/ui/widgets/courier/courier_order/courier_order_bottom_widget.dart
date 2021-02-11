import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/mobileSize.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/string_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order.dart';
import 'package:storeangelApp/ui/screens/courier/courier_order/courier_order_delivered_summary_screen.dart';
import 'package:storeangelApp/ui/screens/courier/courier_order_delivered_screen.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/deliveryinfo_rowWidget.dart';
import 'package:storeangelApp/ui/shared/stepback_dialog.dart';
class CourierOrderBottomWidget extends StatelessWidget {
  final OrderOrPurchases order;
  final int index;
  final CourierOrderViewModel model;

  CourierOrderBottomWidget({this.order, this.model,this.index});

  final double _boxHeight = SizeConfig.screenHeight*.22*(SizeConfig.mobileSize==MobileSize.medium?0.85:1.1);

  @override
  Widget build(BuildContext context) {
    if (order.status == OrderPurchaseStatus.OrderPlaced) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: _boxHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizeConfig.verticalSpaceESmall(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Text(
                    AppStrings.DELIVERY_DATE.tr()+':',
                    style: AppStyles.GrayStyle_Font16(context),
                  ),
                ),
                SizeConfig.verticalSpaceSmall(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Text(
                    DateService.getDateFormatWithYear(order.selectedDate.toIso8601String(), context),
                    style: AppStyles.BlackStyleWithBold800Font_20(context),
                  ),
                ),
                SizeConfig.verticalSpaceESmall(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Text(
                    AppStrings.PENDING_PAYMENT.tr()+':',
                    style: AppStyles.GrayStyle_Font16(context),
                  ),
                ),
                SizeConfig.verticalSpaceSmall(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Text(
                    '${AppStrings.euro} ${NumberService.priceAfterConvert(order.orderAmount,context)}',
                    style: AppStyles.BlackStyleWithBold800Font_20(context),
                  ),
                ),
                SizeConfig.verticalSpaceExtraMedium(),
              ],
            ),
          ),
          Padding(
            padding: SizeConfig.sidepadding,
            child: ButtonWidget(
              onPressed: () {
                model.updateOrderStatus(OrderPurchaseStatus.MoneyTransfer,index);
              },
              buttonText: AppStrings.PAYMENT_RECEIVED.tr(),
              buttonColor: Theme.of(context).primaryColor,
              fontSize: SizeConfig.fontSizeLarge,
              radius: SizeConfig.smallBorderRadius,
            ),
          ),
        ],
      );
    } else if (order.status == OrderPurchaseStatus.MoneyTransfer) {
      return Padding(
        padding: SizeConfig.sidepadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _boxHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeConfig.verticalSpaceSmall(),
                  DeliveryInfoRowWidget(
                    enablePadding: false,
                    hasBorderColor: false,
                    firstText: AppStrings.RECEIVED_PAYMENT.tr()+':',
                    secondText: AppStrings.euro+' '+ NumberService.priceAfterConvert(240,context),
                  ),
                  SizeConfig.CVerticalSpaceVarySmall(),
                  DeliveryInfoRowWidget(
                    enablePadding: false,
                    hasBorderColor: false,
                    firstText: AppStrings.MY_FEE.tr()+':',
                    secondText: AppStrings.euro+' '+ NumberService.priceAfterConvert(10,context),
                  ),
                  SizeConfig.verticalSpaceSmall(),
                  Divider(),
                  SizeConfig.verticalSpaceSmall(),
                  DeliveryInfoRowWidget(
                    enablePadding: false,
                    hasBorderColor: false,
                    firstTextStyle: AppStyles.BlackStyleFontWeight500_13(context),
                    firstText: StringService.getCourierBudgetName(order.purchaseDetails).name+':',
                    secondText: AppStrings.euro+' '+ NumberService.priceAfterConvert(230,context),
                  ),
                  SizeConfig.verticalSpaceExtraMedium(),
                ],
              ),
            ),
            _nextButton(
              onPressed: () {
                model.updateOrderStatus(OrderPurchaseStatus.OrderPlaced,index);
                model.navigateToScreen(CourierOrderDeliveredScreen.routeName, context,
                    arguments: CourierOrderDeliveredScreenArgument(
                        order: order, initialIndex: 0));
              },
              buttonText: AppStrings.START_PURCHASE.tr(),
              context: context,
            ),
            _backButton(
                onTap: () {
                  MyUtils.showAppDialog(
                      context: context,
                      child: StepBackDialog(
                        onPressOk: () {
                          model.updateOrderStatus(OrderPurchaseStatus.OrderPlaced,index);
                          model.navigatorPop();
                        },
                      ));
                },
                context: context),
          ],
        ),
      );
    } else if (order.status == OrderPurchaseStatus.OrderPlaced) {
      return Padding(
        padding: SizeConfig.sidepadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _boxHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeConfig.verticalSpaceSmall(),
                  DeliveryInfoRowWidget(
                    enablePadding: false,
                    hasBorderColor: false,
                    firstText: AppStrings.RECEIVED_PAYMENT.tr()+':',
                    secondText: AppStrings.euro+' '+ NumberService.priceAfterConvert(240,context),
                  ),
                  SizeConfig.CVerticalSpaceVarySmall(),
                  DeliveryInfoRowWidget(
                    enablePadding: false,
                    hasBorderColor: false,
                    firstText: AppStrings.MY_FEE.tr()+':',
                    secondText: AppStrings.euro+' '+ NumberService.priceAfterConvert(10,context),
                  ),
                  SizeConfig.verticalSpaceSmall(),
                  Divider(),
                  SizeConfig.verticalSpaceSmall(),
                  DeliveryInfoRowWidget(
                    enablePadding: false,
                    hasBorderColor: false,
                    firstTextStyle: AppStyles.BlackStyleFontWeight500_13(context),
                    firstText: StringService.getCourierBudgetName(order.purchaseDetails).name+':',
                    secondText: AppStrings.euro+' '+ NumberService.priceAfterConvert(230,context),
                  ),
                  SizeConfig.verticalSpaceExtraMedium(),
                ],
              ),
            ),
            _nextButton(
              onPressed: () {
                model.updateOrderStatus(OrderPurchaseStatus.OrderRunning,index);
              },
              buttonText: AppStrings.FINISHED_PURCHASE.tr(),
              context: context,
            ),
            _backButton(
                onTap: () {
                  MyUtils.showAppDialog(
                      context: context,
                      child: StepBackDialog(
                        onPressOk: () {
                          model.updateOrderStatus(OrderPurchaseStatus.MoneyTransfer,index);
                          model.navigatorPop();
                        },
                      ));
                },
                context: context)
          ],
        ),
      );
    } else if (order.status == OrderPurchaseStatus.OrderRunning) {
      return Padding(
        padding: SizeConfig.sidepadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _boxHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeConfig.verticalSpaceSmall(),
                  DeliveryInfoRowWidget(
                    enablePadding: false,
                    hasBorderColor: false,
                    firstText: AppStrings.RECEIVED_PAYMENT.tr()+':',
                    secondText: AppStrings.euro+' '+ '${NumberService.priceAfterConvert(140,context)}',
                  ),
                  SizeConfig.CVerticalSpaceVarySmall(),
                  DeliveryInfoRowWidget(
                    enablePadding: false,
                    hasBorderColor: false,
                    firstText: AppStrings.MY_FEE.tr()+':',
                    secondText: AppStrings.euro+' '+ '${NumberService.priceAfterConvert(10,context)}',
                  ),
                  SizeConfig.verticalSpaceSmall(),
                  Divider(),
                  SizeConfig.verticalSpaceSmall(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.PAYBACK.tr()+':',
                                style: AppStyles.BlackStyleWithBold800Font_24(context),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: SizeConfig.screenHeight * .01),
                                child: Text(
                                  AppStrings.RETURN_TRANSFER.tr(),
                                  style: AppStyles.GreenStyle_Font20(context),
                                ),
                              )
                            ],
                          )),
                      Text(
                        AppStrings.euro+' '+ NumberService.priceAfterConvert(23,context),
                        style: AppStyles.BlackStyleFontw600_c13(context),
                      )
                    ],
                  ),
                  SizeConfig.verticalSpaceExtraMedium(),
                ],
              ),
            ),
            _nextButton(
                onPressed: () {
                  model.updateOrderStatus(OrderPurchaseStatus.OrderDelivered,index);
                },
                buttonText: AppStrings.ITEMS_DELIVERED.tr(),
                context: context),
            _backButton(
                onTap: () {
                  MyUtils.showAppDialog(
                      context: context,
                      child: StepBackDialog(
                        onPressOk: () {
                          model.updateOrderStatus(OrderPurchaseStatus.OrderPlaced,index);
                          model.navigatorPop();
                        },
                      ));
                },
                context: context)
          ],
        ),
      );
    } else if (order.status == OrderPurchaseStatus.OrderDelivered) {
      return Padding(
        padding: SizeConfig.sidepadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SizedBox(
             height: _boxHeight,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 SizeConfig.verticalSpaceSmall(),
                 DeliveryInfoRowWidget(
                   enablePadding: false,
                   hasBorderColor: false,
                   firstText: AppStrings.RECEIVED_PAYMENT.tr()+':',
                   secondText: AppStrings.euro+' '+ NumberService.priceAfterConvert(240,context),
                 ),
                 SizeConfig.CVerticalSpaceVarySmall(),
                 DeliveryInfoRowWidget(
                   enablePadding: false,
                   hasBorderColor: false,
                   firstText: AppStrings.MY_FEE.tr()+':',
                   secondText: AppStrings.euro+' '+ NumberService.priceAfterConvert(10,context),
                 ),
                 SizeConfig.CVerticalSpaceVarySmall(),
                 DeliveryInfoRowWidget(
                   enablePadding: false,
                   hasBorderColor: false,
                   firstText: AppStrings.PAYBACK.tr()+':',
                   secondText: AppStrings.euro+' '+ NumberService.priceAfterConvert(10,context),
                 ),
                 SizeConfig.verticalSpaceExtraMedium(),
               ],
             ),
           ),
            _nextButton(onPressed: () {
              model.navigateToScreen(CourierOrderDeliveredSummaryScreen.routeName, context,
                  arguments: model.orders[index]);
            }, buttonText: AppStrings.THANKS_FOR_THE_PURCHASE.tr(), context: context),
            _backButton(onTap: () {
              MyUtils.showAppDialog(
                  context: context,
                  child: StepBackDialog(
                    onPressOk: () {
                      model.updateOrderStatus(OrderPurchaseStatus.OrderRunning,index);
                      model.navigatorPop();
                    },
                  ));
            }, context: context)
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _nextButton({@required Function onPressed, @required String buttonText, @required BuildContext context}) {
    return Row(
      children: [
        Expanded(
          child: ButtonWidget(
            onPressed: onPressed,
            buttonText: buttonText,
            fontSize: SizeConfig.fontSizeLarge,
            buttonColor: Theme.of(context).primaryColor,
            radius: SizeConfig.smallBorderRadius,
          ),
        ),
      ],
    );
  }

  Widget _backButton({@required Function onTap, @required BuildContext context}) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            child: Container(
              constraints: BoxConstraints(
                minWidth: SizeConfig.screenWidth*.4,
                maxWidth: SizeConfig.screenWidth*.4,
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * .2,
                  right: SizeConfig.screenWidth * .2,
                  top: SizeConfig.screenHeight * .02),
              child: Text(
                AppStrings.UNDO.tr(),
                style: AppStyles.GreenStyle_Font20(context),
              ),
            ),
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
