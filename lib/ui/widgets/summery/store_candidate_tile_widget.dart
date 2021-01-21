import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order/item_available_widget.dart';

class StoreCandidateTileWidget extends StatelessWidget {
  final OrderOrPurchases orPurchases;
  final CourierCandidate candidate;
  StoreCandidateTileWidget({this.candidate,this.orPurchases});

  @override
  Widget build(BuildContext context) {
    return CustomFiveWidgetsTile(
      trailingOneBackGroundColor: AppColors.amberGradient,
        trailingOne: Center(
          child: Icon(StoreangelIcons.timer,color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
        ),
        enableTrailingTwoPadding: false,
        trailingTwo: FittedBox(
          fit: BoxFit.cover,
          child: ViewAppImage(
            imageUrl: candidate.imageUrl,
          ),
        ),
        imageUrl: orPurchases.purchaseDetails.storeDetails.image,
        middleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeConfig.verticalSpaceSmall(),
            Row(
              children: [
                Expanded(
                    child: Text(AppStrings.ASSIGNMENTS.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                Text(TimeAgoService.timeAgoSinceDate(DateTime.now().subtract(Duration(
                    minutes: 5
                )), context),
                  style: AppStyles.GrayStyleItalicFont16(context),),
              ],
            ),
            SizeConfig.verticalSpaceSmall(),
            Text(AppStrings.PLACE_AN_ORDER.tr(),style: AppStyles.BlackStyleWithBold800Font_24(context),),
            SizeConfig.verticalSpaceSmall(),
            Text(AppStrings.euroSymbol+'${orPurchases.purchaseDetails.totalAmount} | ${orPurchases.purchaseDetails.products.length}'+AppStrings.ARTICLES.tr(),
              style: AppStyles.BlackStyle_Font16(context),),
            SizeConfig.verticalSpaceSmall(),
            ItemAvailableWidget(products: orPurchases.purchaseDetails.products,),
            SizeConfig.verticalSpaceSmall(),
            Text(orPurchases.purchaseDetails.storeDetails.twoLineAddress,
              style: AppStyles.BlackStyleFont16Light(context),),
            SizeConfig.verticalSpaceSmall(),

          ],
        ));
  }
}
