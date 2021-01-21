import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order_deleivered_summary.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/custom_divider_widget.dart';
import 'package:storeangelApp/ui/shared/deliveryinfo_rowWidget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_delivered_summery/delivery_summery_transfer_option_widget.dart';

class DeliveredSummeryPaymentWidget extends StatefulWidget {
  final CourierOrderDeliveredSummaryViewModel model;

  DeliveredSummeryPaymentWidget({this.model});

  @override
  _DeliveredSummeryPaymentWidgetState createState() => _DeliveredSummeryPaymentWidgetState();
}

class _DeliveredSummeryPaymentWidgetState extends State<DeliveredSummeryPaymentWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.model.order.paid) {
      return Stack(
        children: [
          Padding(
            padding: SizeConfig.sidepadding.copyWith(
              bottom: SizeConfig.screenHeight * .03,
            ),
            child: CustomCard(
              child: Padding(
                padding: SizeConfig.padding
                    .copyWith(bottom: SizeConfig.screenHeight * .015, top: SizeConfig.screenHeight * .015),
                child: Column(
                  children: [
                    SizeConfig.verticalSpaceSmall(),
                    DeliveryInfoRowWidget(
                      hasBorderColor: false,
                      enablePadding: false,
                      firstText: AppStrings.PURCHASE_TOTAL.tr() + ':',
                      secondText: '€ ${NumberService.addAfterCommaTwoZeros('213,59', context)}',
                    ),
                    SizeConfig.verticalSpaceSmall(),
                    DeliveryInfoRowWidget(
                      hasBorderColor: false,
                      enablePadding: false,
                      firstText: AppStrings.YOUR_FEE.tr() + ':',
                      secondText: '€ ${NumberService.addAfterCommaTwoZeros('10,00', context)}',
                    ),
                    SizeConfig.verticalSpaceSmall(),
                    CustomDividerWidget(
                      color: Theme.of(context).cardColor,
                    ),
                    SizeConfig.verticalSpaceSmall(),
                    DeliveryInfoRowWidget(
                      hasBorderColor: false,
                      enablePadding: false,
                      firstText: AppStrings.RECEIVED_PAYMENT.tr() + ':',
                      firstTextStyle: AppStyles.BlackStyleWithBold800Font_20(context),
                      secondText: '€ ${NumberService.addAfterCommaTwoZeros('26,41', context)}',
                    ),
                    SizeConfig.verticalSpaceMedium(),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: SizeConfig.innerpadding.copyWith(
                bottom: SizeConfig.screenHeight*.01
              ),
              child: Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
                size: SizeConfig.screenHeight * .05,
              ),
            ),
          ))
        ],
      );
    }
    return Padding(
      padding: SizeConfig.sidepadding,
      child: CustomCard(
        child: Padding(
          padding: SizeConfig.padding,
          child: Column(
            children: [
              SizeConfig.verticalSpaceSmall(),
              DeliveryInfoRowWidget(
                hasBorderColor: false,
                enablePadding: false,
                firstText: AppStrings.PURCHASE_BUDGET.tr() + ':',
                secondTextStyle: AppStyles.BlackStyleWithBold800Font_20(context).copyWith(fontWeight: FontWeight.bold),
                secondText: '€ ${NumberService.addAfterCommaTwoZeros('240,00', context)}',
              ),
              SizeConfig.verticalSpaceSmall(),
              DeliveryInfoRowWidget(
                hasBorderColor: false,
                enablePadding: false,
                firstText: AppStrings.PURCHASE_TOTAL.tr() + ':',
                secondTextStyle: AppStyles.BlackStyleWithBold800Font_20(context).copyWith(fontWeight: FontWeight.bold),
                secondText: '€ ${NumberService.addAfterCommaTwoZeros('213,59', context)}',
              ),
              SizeConfig.verticalSpaceSmall(),
              DeliveryInfoRowWidget(
                hasBorderColor: false,
                enablePadding: false,
                firstText: AppStrings.YOUR_FEE.tr() + ':',
                secondTextStyle: AppStyles.BlackStyleWithBold800Font_20(context).copyWith(fontWeight: FontWeight.bold),
                secondText: '€ ${NumberService.addAfterCommaTwoZeros('10,00', context)}',
              ),
              SizeConfig.verticalSpaceSmall(),
              CustomDividerWidget(
                color: Theme.of(context).cardColor,
              ),
              SizeConfig.verticalSpaceSmall(),
              DeliveryInfoRowWidget(
                hasBorderColor: false,
                enablePadding: false,
                firstText: AppStrings.TRANSFER_AMOUNT.tr() + ':',
                firstTextStyle: AppStyles.BlackStyleWithBold800Font_20(context)
                    .copyWith(fontWeight: FontWeight.bold, fontSize: SizeConfig.fontSizeLarge),
                secondTextStyle: AppStyles.BlackStyleWithBold800Font_20(context)
                    .copyWith(fontWeight: FontWeight.bold, fontSize: SizeConfig.fontSizeLarge),
                secondText: '€ ${NumberService.addAfterCommaTwoZeros('26,41', context)}',
              ),
              SizeConfig.verticalSpaceMedium(),
              ButtonWidget(
                onPressed: () {
                  MyUtils.showAppDialog(
                      context: context,
                      child: DeliveryOptionTransferOptionsWidget(
                        model: widget.model,
                      ));
                },
                fontSize: SizeConfig.fontSizeLarge,
                buttonColor: Theme.of(context).primaryColor,
                radius: SizeConfig.borderRadius * .7,
                buttonText: AppStrings.PAYBACK.tr(),
              ),
              SizeConfig.verticalSpaceSmall(),
            ],
          ),
        ),
      ),
    );
  }
}
