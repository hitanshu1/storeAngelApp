import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:easy_localization/easy_localization.dart';

class ActiveOfferWidget extends StatelessWidget {
  final OrderOrPurchases order;
  ActiveOfferWidget({this.order});
  @override
  Widget build(BuildContext context) {
    bool isPrepaid=order.orderPayment==AppStrings.PREPAYMENT.tr();
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.bottomPadding.bottom),
      child: CustomFiveWidgetsTile(imageUrl: order.clientDetails.imageUrl,
          trailingOneBackGroundColor:isPrepaid?AppColors.blueGradient:AppColors.amberGradient,
          enableTrailingTwoPadding: false,
          trailingOne: Center(child: Icon(isPrepaid?StoreangelIcons.card:StoreangelIcons.timer,
            color: AppColors.whiteColor,size: isPrepaid?SizeConfig.iconSize:SizeConfig.mediumIcon,)), trailingTwo: FittedBox(
              fit: BoxFit.cover,
              child:ViewAppImage(
                width: 50,
                imageUrl: order.storeDetails.image,
              )
          ),
          middleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizeConfig.verticalSpaceSmall(),
              Row(
                children: [
                  Expanded(child: Text(AppStrings.OFFERS.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                  Text(DateService.getDateFormatddMMyyyy(order.selectedDate.toIso8601String(), context),
                    style: AppStyles.GrayStyleItalicFont16(context),),

                ],
              ),
              SizeConfig.verticalSpaceSmall(),
              Text(order.clientDetails.name,style: AppStyles.BlackStyleWithBold800Font_24(context),),
              SizeConfig.verticalSpaceSmall(),
              Text(AppStrings.euroSymbol+'${NumberService.priceAfterConvert(order.orderAmount, context)}'+' | '+'${order.purchaseDetails.products.length} '+AppStrings.ARTICLES.tr(),
                style: AppStyles.BlackStyleFont20W300(context),),
              SizeConfig.verticalSpaceSmall(),
              CustomRatingWidget(reviewCount: 15, initialRating: 2, stars: 3.5),
              SizeConfig.verticalSpaceMedium(),
              Text(order.clientDetails.twoLineAddress,
                style: AppStyles.BlackStyleFont16Light(context),),
              SizeConfig.verticalSpaceSmall(),
            ],
          )),
    );

  }
}
