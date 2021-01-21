import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:easy_localization/easy_localization.dart';

class ArticleOrderDetailsWidget extends StatelessWidget {
  final PurchaseDetails purchaseDetails;
  ArticleOrderDetailsWidget({this.purchaseDetails});
  @override
  Widget build(BuildContext context) {
    return CustomFiveWidgetsTile(

        trailingOne:  FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${purchaseDetails.products.length}',style: AppStyles.WhiteStyle_WithBold900_Font36,),
              FittedBox(child: Text(AppStrings.SELECTED.tr(),style: AppStyles.WhiteStyle_FontSmall,))
            ],
          ),
        ),
        trailingTwo: FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${purchaseDetails.products.length}',style: AppStyles.WhiteStyle_WithBold900_Font36,),
              FittedBox(child: Text(AppStrings.ARTICLES.tr(),style: AppStyles.WhiteStyle_FontSmall,))
            ],
          ),
        ),
        imageUrl: purchaseDetails.storeDetails.image,
        middleWidget: Padding(
          padding: SizeConfig.verticalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(child: Text(AppStrings.GROCERY_LIST.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                  Text(DateService.getDateFormatddMMyyyy(purchaseDetails.time.toIso8601String(), context),
                    style: AppStyles.GrayStyleItalicFont16(context),),

                ],
              ),
              SizeConfig.verticalSpaceSmall(),
              Text(purchaseDetails.listName,
                style: AppStyles.BlackStyleWithBold800Font_24(context),),
              SizeConfig.verticalSpaceSmall(),
              Text(AppStrings.euroSymbol+NumberService.totalPrice(purchaseDetails.products, context),
                style: AppStyles.BlackStyleFont20W300(context),),
              SizeConfig.verticalSpaceSmall(),
              CustomRatingWidget(reviewCount: 6, initialRating: 3.5, stars: 10),
              SizeConfig.verticalSpaceSmall(),

              Text(purchaseDetails.storeDetails.twoLineAddress,
                style: AppStyles.BlackStyleFont16Light(context),),
            ],
          ),
        ));
  }
}
