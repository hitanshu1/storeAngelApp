import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';

import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';

import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order/item_available_widget.dart';


class PurchasesOrderWidget extends StatelessWidget {
  final OrderOrPurchases order;
  PurchasesOrderWidget({this.order});
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.bottomPadding.bottom),
      child: Opacity(
        opacity: .5,
        child:CustomFiveWidgetsTile(
          trailingOneBackGroundColor: AppColors.primaryGradient,
            trailingOne: Center(child: Icon(StoreangelIcons.shopping_basket,
              color: AppColors.whiteColor,size: SizeConfig.mediumIcon,)),
            enableTrailingTwoPadding: false,
            trailingTwo: FittedBox(
                fit: BoxFit.cover,
                child:ViewAppImage(
                  width: 50,
                  imageUrl: order.storeDetails.image,
                )
            ),
            imageUrl: order.clientDetails.imageUrl,
            middleWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizeConfig.verticalSpaceSmall(),
                Row(
                  children: [
                    Expanded(child: Text(AppStrings.ORDER.tr(),style: AppStyles.BlackStyleFont16Light(context),)),

                    Text(TimeAgoService.timeAgoSinceDate(order.selectedDate, context),
                      style: AppStyles.GrayStyleItalicFont16(context),),

                  ],
                ),
                SizeConfig.verticalSpaceSmall(),
                Text(order.clientDetails.name,style: AppStyles.BlackStyleWithBold800Font_24(context),),
                SizeConfig.verticalSpaceSmall(),
                Text(AppStrings.euroSymbol+' 22,75'+' | '+'11 '+AppStrings.ARTICLES.tr(),
                  style: AppStyles.BlackStyleFont20W300(context),),
                SizeConfig.verticalSpaceSmall(),
                ItemAvailableWidget(products: order.purchaseDetails.products,),
                SizeConfig.verticalSpaceSmall(),
                Text(order.clientDetails.twoLineAddress,
                  style: AppStyles.BlackStyleFont16Light(context),),
                SizeConfig.verticalSpaceSmall(),
              ],
            ))

      ),
    );
  }
}
