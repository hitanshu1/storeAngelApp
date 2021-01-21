import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import '../cantidant_rating_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class  CustomerDetailsWidget extends StatelessWidget {
  final ClientDetails clientDetails;
  final double orderAmout;
  final DateTime deliveryDate;
  final List<Product>products;
  final String title;
  final Widget trailingOne,trailingTwo;
  final LinearGradient trailingOneBackGroundColor,trailingTwoBackGroundColor;
  CustomerDetailsWidget({@required this.deliveryDate,@required this.clientDetails,@required this.products,@required this.orderAmout,@required this.trailingOne,@required this.trailingTwo,
  this.trailingOneBackGroundColor,this.trailingTwoBackGroundColor,@required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomFiveWidgetsTile(
        imageUrl: clientDetails.imageUrl,
      trailingOneBackGroundColor: trailingOneBackGroundColor,
        trailingTwoBackGroundColor: trailingTwoBackGroundColor,
        enableTrailingTwoPadding: false,
        trailingOne: trailingOne, trailingTwo: trailingTwo,
        middleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeConfig.verticalSpaceSmall(),
            Row(
              children: [
                Expanded(child: Text(title,style: AppStyles.BlackStyleFont16Light(context),)),
                Text(DateService.getDateFormatddMMyyyy(deliveryDate.toIso8601String(), context),
                  style: AppStyles.GrayStyleItalicFont16(context),),

              ],
            ),
            SizeConfig.verticalSpaceSmall(),
            Text(clientDetails.name,style: AppStyles.BlackStyleWithBold800Font_24(context),),
            SizeConfig.verticalSpaceSmall(),
            Text(AppStrings.euroSymbol+'${NumberService.priceAfterConvert(orderAmout, context)}'+' | '+'${products.length} '+AppStrings.ARTICLES.tr(),
              style: AppStyles.BlackStyleFont20W300(context),),
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
