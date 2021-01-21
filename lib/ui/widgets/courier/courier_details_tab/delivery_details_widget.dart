import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/string_service.dart';
import 'package:storeangelApp/ui/shared/deliveryinfo_rowWidget.dart';

class DeliveryDetailsWidget extends StatelessWidget {
  final OrderOrPurchases order;
  DeliveryDetailsWidget({this.order});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DeliveryInfoRowWidget(
          borderSideColor: Theme.of(context).primaryColorLight,
          firstText: AppStrings.DELIVERY_DATE.tr()+':',
          secondText: DateService.getDateFormatWithYear(order.selectedDate.toIso8601String(), context),
        ),
        DeliveryInfoRowWidget(
          borderSideColor: Theme.of(context).primaryColorLight,
          firstText: StringService.getCourierBudgetName(order.purchaseDetails).name+':',
          secondText: AppStrings.euro+' '+'${NumberService.priceAfterConvert(order.orderAmount,context)}',
        ),
        DeliveryInfoRowWidget(
          borderSideColor: Theme.of(context).primaryColorLight,
          firstText: AppStrings.MY_FEE.tr()+':',
          secondText: AppStrings.euro+' '+'${NumberService.priceAfterConvert(order.candidates.first?.charge??0,context)}',
        ),
        DeliveryInfoRowWidget(
          borderSideColor: Theme.of(context).primaryColorLight,
          firstText: AppStrings.ORDER_PAYMENT.tr()+':',
          secondText: order.orderPayment
        ),
        DeliveryInfoRowWidget(
            borderSideColor: Theme.of(context).primaryColorLight,
            firstText: AppStrings.OFFERS.tr()+':',
            secondText: '7'
        ),
        DeliveryInfoRowWidget(
            borderSideColor: Theme.of(context).primaryColorLight,

            firstText: AppStrings.LAST_UPDATE.tr()+':',
            secondText: '10 minutes ago'
        ),
        SizeConfig.verticalSpaceSmall(),
        Padding(
          padding: SizeConfig.sidepadding,
          child: Text(AppStrings.COMMENT.tr()+':', style: AppStyles.GrayStyle_Font16(context)),
        ),
        SizeConfig.verticalSpaceSmall(),
        Padding(
          padding: SizeConfig.sidepadding,
          child: Text(order.comment, style: AppStyles.BlackStyleWithBold600Font_20(context)),
        ),

      ],
    );
  }
}
