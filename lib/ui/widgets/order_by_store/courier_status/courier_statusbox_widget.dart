import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

import '../order_status_card.dart';

class CourierStatusBoxWidget extends StatelessWidget {
  final OrderOrPurchases orderOrPurchases;
  final OrderPurchaseStatus status;

  CourierStatusBoxWidget({this.orderOrPurchases, this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          AppStrings.AS_SOON_AS_POSSIBLE.tr(),
          style: AppStyles.BlackStyleFont_16(context),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(SizeConfig.sidepadding.left + SizeConfig.mediumPadding.left,
              SizeConfig.mediumPadding.top, SizeConfig.sidepadding.right + SizeConfig.mediumPadding.right, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ViewAppImage(
                      width: SizeConfig.smallImageHeight60,
                      height: SizeConfig.smallImageHeight60,
                      radius: 10,
                      imageUrl: orderOrPurchases.purchaseDetails.storeDetails.image,
                    ),
                    SizeConfig.verticalSpaceSmall(),
                    Text(orderOrPurchases.purchaseDetails.storeDetails.name,
                        style: AppStyles.BlackStyleWithBold800Font_24(context), textAlign: TextAlign.center),
                    SizeConfig.verticalSpace(SizeConfig.screenHeight*.005),
                    AutoSizeText(
                      orderOrPurchases.purchaseDetails.storeDetails.street,
                      maxLines: 1,
                      minFontSize: 8,
                      maxFontSize: SizeConfig.fontSizeSmall,
                      style: AppStyles.GrayStyle_Font16(context),
                      textAlign: TextAlign.center,
                    ),
                    SizeConfig.verticalSpace(SizeConfig.screenHeight * .003),
                    AutoSizeText('${orderOrPurchases.purchaseDetails.storeDetails.zipCity}',
                        minFontSize: 8,
                        maxFontSize: SizeConfig.fontSizeSmall,
                        maxLines: 1,
                        style: AppStyles.GrayStyle_Font16(context),
                        textAlign: TextAlign.center)
                  ],
                ),
              ),
              SizeConfig.horizontalSpaceSmall(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizeConfig.VerticalSpaceSmallMedium(),
                    Icon(
                      StoreangelIcons.full_bag_outlined,
                      color: AppColors.primaryColor,
                    ),
                    SizeConfig.CVerticalSpaceSmallMedium(),
                    Text(
                      '${orderOrPurchases.purchaseDetails.products.length} ${AppStrings.ITEMS.tr()}',
                      style: AppStyles.BlackStyle_Font12(context),
                    ),
                  ],
                ),
              ),
              SizeConfig.horizontalSpaceSmall(),
              Expanded(
                child: Column(
                  children: [
                    ViewAppImage(
                      width: SizeConfig.smallImageHeight60,
                      height: SizeConfig.smallImageHeight60,
                      radius: SizeConfig.smallImageHeight60,
                      imageUrl: orderOrPurchases.candidates.first.imageUrl,
                    ),
                    SizeConfig.verticalSpaceSmall(),
                    AutoSizeText(
                      orderOrPurchases.candidates.first.name,
                      maxLines: 2,
                      minFontSize: 8,
                      maxFontSize: SizeConfig.fontSizeLarge,
                      style: AppStyles.BlackStyleWithBold800Font_24(context),
                      textAlign: TextAlign.center,
                    ),
                    SizeConfig.verticalSpace(SizeConfig.screenHeight*.005),
                    SizedBox(
                      width: SizeConfig.screenWidth*.12,
                      height: SizeConfig.fontSizeMedium,
                      child: OverflowBox(
                        minWidth: 0,
                        maxWidth: 170,
                        minHeight: 0,
                        maxHeight: 20,
                        child: CustomRatingWidget(
                            reviewCount: orderOrPurchases.candidates.first.stars,
                            initialRating: orderOrPurchases.candidates.first.stars.toDouble(),
                            stars: orderOrPurchases.candidates.first.stars.toDouble()),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SizeConfig.verticalSpaceSmall(),
        OrderStatusCard(
          status: status,
          prePaid: orderOrPurchases.purchaseDetails.paymentOption.paymentOptionEnum == AppStrings.PREPAYMENT,
        ),
        SizeConfig.verticalSpaceSmall(),
      ],
    );
  }
}
