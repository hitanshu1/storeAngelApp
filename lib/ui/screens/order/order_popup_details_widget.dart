import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/string_service.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/deliveryinfo_rowWidget.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/view_delivered_order_item.dart';

class OrderPopUpDetailsWidget extends StatelessWidget {
  final OrderOrPurchases orderOrPurchases;

  OrderPopUpDetailsWidget({this.orderOrPurchases});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: AppColors.lightGrayDotColor,
                    size: SizeConfig.mediumIconSize,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
          Center(
            child: Text(
              orderOrPurchases.purchaseDetails.storeDetails.name,
              style: AppStyles.BlackStyleWithBold_Font36(context),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight * .015, bottom: SizeConfig.screenHeight * .025),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: CustomRatingWidget(
                      reviewCount: orderOrPurchases.storeDetails?.ratings?.length ?? 0, initialRating: 5.0, stars: 5.0),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                SizeConfig.sidepadding.copyWith(left: SizeConfig.HorizontalSpaceSmall + SizeConfig.sidepadding.left),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizeConfig.CVerticalSpacevMedium(),
                Text(
                  AppStrings.SHOPING_LIST.tr(),
                  style: AppStyles.BlackStyleWithBold600Font_20(context).copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: orderOrPurchases.purchaseDetails.products.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {
                return Padding(
                  padding: SizeConfig.sidepadding,
                  child: ViewDeliveredOrderItem(
                    product: orderOrPurchases.purchaseDetails.products[index],
                    totalPriceTextStyle:
                        AppStyles.BlackStyleWithBold600Font_20(context).copyWith(fontWeight: FontWeight.bold),
                  ),
                );
              }),
          SizeConfig.CVerticalSpaceMedium(),
          Padding(
            padding: SizeConfig.sidepadding,
            child: Row(
              children: [
                SizeConfig.horizontalSpaceMedium(),
                Expanded(
                  child: AutoSizeText(
                    StringService.getBudgetName(orderOrPurchases.purchaseDetails).name + ':',
                    style: AppStyles.BlackStyleWithBold800Font_20(context),
                    minFontSize: 8,
                    maxFontSize: AppStyles.BlackStyleWithBold800Font_20(context).fontSize,
                    maxLines: 1,
                  ),
                ),
                Text(
                  '${AppStrings.euro + ' '}${NumberService.totalPrice(orderOrPurchases.purchaseDetails.products,context)}',
                  maxLines: 1,
                  style: AppStyles.BlackStyleWithBold_Font30(context).copyWith(fontSize: SizeConfig.fontSizeLarger),
                  textAlign: TextAlign.right,
                )
              ],
            ),
          ),
          SizeConfig.CVerticalSpaceMedium(),
          DeliveryInfoRowWidget(
              firstText: AppStrings.DELIVERY_PERIOD.tr(), secondText: AppStrings.AS_SOON_AS_POSSIBLE.tr(),
          secondTextStyle: AppStyles.BlackStyleWithBold600Font_20(context).copyWith(fontWeight: FontWeight.bold),),
          DeliveryInfoRowWidget(
              firstText: AppStrings.DELIVERY_ADDRESS.tr(),
              secondText: orderOrPurchases.purchaseDetails.storeDetails.fullAddress,
              secondTextStyle: AppStyles.BlackStyleWithBold600Font_20(context).copyWith(fontWeight: FontWeight.bold)),
          DeliveryInfoRowWidget(
              firstText: AppStrings.POSTED.tr(),
              secondText: DateService.getDateFormatWithYear(DateTime.now().add(Duration(days: 0)).toIso8601String(), context),
              secondTextStyle: AppStyles.BlackStyleWithBold600Font_20(context).copyWith(fontWeight: FontWeight.bold)),
          DeliveryInfoRowWidget(
            firstText: AppStrings.ORDER_NUMBER.tr(),
            secondText: '245678',
              secondTextStyle: AppStyles.BlackStyleWithBold600Font_20(context).copyWith(fontWeight: FontWeight.bold)
          ),
          Padding(
            padding: SizeConfig.sidepadding,
            child: Padding(
              padding: SizeConfig.verticalMedPadding,
              child: Text(
                AppStrings.COMMENT.tr() + ':',
                style: AppStyles.GrayStyle_Font16(context),
              ),
            ),
          ),
          SizeConfig.verticalSpaceSmall(),
          Padding(
            padding: SizeConfig.sidepadding,
            child: Text(
              '${(orderOrPurchases.comment?.isEmpty ?? true) ? '' : orderOrPurchases.comment}',
              style: AppStyles.BlackStyle_Font16(context),
            ),
          ),
          SizeConfig.verticalSpaceMedium(),
        ],
      ),
    );
  }
}
