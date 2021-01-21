import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'cantidant_rating_widget.dart';

class  StoreOrderDetailsWidget extends StatelessWidget {
  final OrderByStore orderByStore;
  StoreOrderDetailsWidget({this.orderByStore});

  @override
  Widget build(BuildContext context) {
    return CustomFiveWidgetsTile(
      trailingOneBackGroundColor: AppColors.blueGradient,
        trailingTwoBackGroundColor: AppColors.blueGradient,
        trailingOne: Center(child: Icon(StoreangelIcons.card,
          color: AppColors.whiteColor,size: SizeConfig.mediumIcon*.8,)),
        trailingTwo: FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${orderByStore.clients.length}',style: AppStyles.WhiteStyle_WithBold900_Font36,),
              Text(AppStrings.ORDERS.tr(),style: AppStyles.WhiteStyle_FontSmall,)

            ],
          ),
        ), imageUrl: orderByStore.storeDetails.image,
        middleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeConfig.verticalSpaceSmall(),
            Row(
              children: [
                Expanded(child: Text(AppStrings.ASSIGNMENTS.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                Text(TimeAgoService.timeAgoSinceDate(orderByStore.orderTime, context),
                  style: AppStyles.GrayStyleItalicFont16(context),),

              ],
            ),
            SizeConfig.verticalSpaceSmall(),
            Text(orderByStore.status,style: AppStyles.BlackStyleWithBold800Font_24(context),),
            SizeConfig.verticalSpaceSmall(),
            Text(AppStrings.euroSymbol+' ${NumberService.priceAfterConvert(orderByStore.orderAmount, context)}'+' | '+'${orderByStore.products.length} '+AppStrings.ARTICLES.tr(),
              style: AppStyles.BlackStyleFont20W300(context),),
            SizeConfig.verticalSpaceSmall(),
            CustomRatingWidget(reviewCount: 15, initialRating: 2, stars: 3.5),
            SizeConfig.verticalSpaceSmall(),
            Text(orderByStore.storeDetails.twoLineAddress,
              style: AppStyles.BlackStyleFont16Light(context),),
            SizeConfig.verticalSpaceSmall(),
          ],
        ));
  }
}
