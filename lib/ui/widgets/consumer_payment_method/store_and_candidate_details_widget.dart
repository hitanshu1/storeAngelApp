import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/string_service.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';



class StoreAndCandidateDetailsWidget extends StatelessWidget {

  final OrderOrPurchases order;
  final CourierCandidate candidate;
  StoreAndCandidateDetailsWidget({this.order,this.candidate});
  @override
  Widget build(BuildContext context) {
    return CustomFiveWidgetsTile(
        trailingTwoBackGroundColor: AppColors.amberGradient,
        trailingOneBackGroundColor: AppColors.amberGradient,
        trailingOne: Center(
          child: Icon(StoreangelIcons.timer,color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
        ),
        enableTrailingTwoPadding: false,
        trailingTwo:FittedBox(
          fit: BoxFit.cover,
          child: ViewAppImage(
            height: 50,
            imageUrl: order.purchaseDetails.storeDetails.image,
          ),
        ),
        imageUrl: candidate.imageUrl,
        middleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeConfig.verticalSpaceSmall(),
            Row(
              children: [
                Expanded(child: Text(AppStrings.PAYMENT.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                Text(TimeAgoService.timeAgoSinceDate(DateTime.now(), context),
                  style: AppStyles.GrayStyleItalicFont16(context),),
              ],
            ),
            SizeConfig.verticalSpaceSmall(),
            Text(StringService.getBudgetName(order.purchaseDetails).name+': '+AppStrings.euroSymbol+NumberService.totalPrice(order.purchaseDetails.products, context),
              style: AppStyles.BlackStyleWithBold800Font_24(context),),
            SizeConfig.verticalSpaceSmall(),
            Text(order.purchaseDetails.customer.name,
              style: AppStyles.BlackStyleFont_20(context),),
            SizeConfig.verticalSpaceSmall(),
            CustomRatingWidget(reviewCount: 6, initialRating: 3.5, stars: 3),
            SizeConfig.verticalSpaceSmall(),
            Text(order.purchaseDetails.storeDetails.twoLineAddress,
              style: AppStyles.BlackStyleFont16Light(context),),
            SizeConfig.verticalSpaceSmall(),

          ],
        ));
  }
}
