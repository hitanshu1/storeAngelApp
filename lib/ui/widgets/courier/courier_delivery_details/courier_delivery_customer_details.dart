
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/models/participant.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/view_order_status.dart';

class CourierDeliveryCustomerDetails extends StatelessWidget {
  final ClientDetails clientDetails;
  final Participant participant;
  final OrderByStore orderByStore;
  CourierDeliveryCustomerDetails({this.clientDetails,this.orderByStore,this.participant});
  @override
  Widget build(BuildContext context) {
    return CustomFiveWidgetsTile(
      trailingOneBackGroundColor: participant.status==OrderPurchaseStatus.OrderDelivered?AppColors.primaryGradient:
        AppColors.blueGradient,
        trailingOne: ViewOrderStatusWidget(status: participant.status,),
        enableTrailingTwoPadding: false,
        trailingTwo: FittedBox(
      fit: BoxFit.cover,

      child: ViewAppImage(
        imageUrl: orderByStore.storeDetails.image,
      ),
    ), imageUrl: clientDetails.imageUrl,
        middleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeConfig.verticalSpaceSmall(),
            Row(
              children: [
                Expanded(child: Text(AppStrings.DELIVERY_ADDRESSES.tr(),style: AppStyles.GrayStyle_Font16(context),)),

                Text(TimeAgoService.timeAgoSinceDate(orderByStore.orderTime, context),
                  style: AppStyles.GrayStyleItalicFont16(context),),

              ],
            ),
            SizeConfig.verticalSpaceSmall(),
            Text(clientDetails.name,style: AppStyles.BlackStyleWithBold800Font_20(context),),
            SizeConfig.verticalSpaceSmall(),
            Text(AppStrings.euroSymbol+'${NumberService.priceAfterConvert(orderByStore.orderAmount, context)}'+' | '+'${participant.products.length} '+AppStrings.ARTICLES.tr(),
              style: AppStyles.BlackStyleFont_20(context),),
            SizeConfig.verticalSpaceSmall(),
            CustomRatingWidget(reviewCount: 15, initialRating: 2, stars: 3.5),
            SizeConfig.verticalSpaceMedium(),
            Text(clientDetails.twoLineAddress,
              style: AppStyles.BlackStyleFontBold_16(context),),
            SizeConfig.verticalSpaceSmall(),
          ],
        ));
  }
}
