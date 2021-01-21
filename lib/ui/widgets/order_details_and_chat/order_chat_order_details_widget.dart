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
import 'package:storeangelApp/ui/widgets/courier/courier_order/item_available_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderChatOrderDetailsWidget extends StatelessWidget {
  final OrderOrPurchases orPurchases;
  final CourierCandidate candidate;
  final double additionChange;
  OrderChatOrderDetailsWidget({this.candidate,this.orPurchases,this.additionChange:0});
  
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: SizeConfig.sidepadding,
        child: CustomFiveWidgetsTile(
          trailingOneBackGroundColor: additionChange>0?AppColors.redGradient:
          AppColors.blueGradient,
            trailingOne: Center(
              child: Icon(additionChange>0?Icons.error_outline:StoreangelIcons.card,color: AppColors.whiteColor,size: 20,),
            ),
            enableTrailingTwoPadding: false,
            trailingTwo: FittedBox(
              fit: BoxFit.cover,
              child: ViewAppImage(
                height: 50,
                imageUrl: candidate.imageUrl,
              ),
            ),
            imageUrl: orPurchases.purchaseDetails.storeDetails.image,
            middleWidget:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizeConfig.verticalSpaceSmall(),
                Row(
                  children: [
                    Expanded(child: Text(AppStrings.ASSIGNMENTS.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                    Text(TimeAgoService.timeAgoSinceDate(DateTime.now().subtract(Duration(
                        minutes: 5
                    )), context),
                      style: AppStyles.GrayStyleItalicFont16(context),),
                  ],
                ),
                SizeConfig.verticalSpaceSmall(),
                Text(AppStrings.IN_ORDER.tr(),style: AppStyles.BlackStyleWithBold800Font_24(context),),
                SizeConfig.verticalSpaceSmall(),
                Text(AppStrings.euroSymbol+'${orPurchases.purchaseDetails.totalAmount} | ${orPurchases.purchaseDetails.products.length}'+AppStrings.ARTICLES.tr(),
                  style: AppStyles.BlackStyleFont_20(context),),
                SizeConfig.verticalSpaceSmall(),
                ItemAvailableWidget(products: orPurchases.purchaseDetails.products,),
                SizeConfig.verticalSpaceSmall(),
                Text(orPurchases.purchaseDetails.storeDetails.twoLineAddress,
                  style: AppStyles.BlackStyleFont16Light(context),),
                SizeConfig.verticalSpaceSmall(),

              ],
            )),
      ),
    );
  }
}
