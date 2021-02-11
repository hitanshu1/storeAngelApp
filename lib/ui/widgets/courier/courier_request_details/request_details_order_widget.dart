import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';


class RequestDetailsOrderWidget extends StatelessWidget {
  final OrderOrPurchases order;
  final bool submitProposal;

  RequestDetailsOrderWidget({this.order, this.submitProposal: false});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.bottomPadding.bottom),
      child: CustomFiveWidgetsTile(
          imageUrl: order.clientDetails.imageUrl,
          trailingOne: FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '1,2', style: AppStyles.WhiteStyle_WithBold900_Font36,),
                Text('km', style: AppStyles.WhiteStyle_FontSmall,)
              ],
            ),
          ),
          enableTrailingTwoPadding:false,
          trailingTwo: FittedBox(
            fit: BoxFit.cover,
            child: ViewAppImage(
              imageUrl: order.storeDetails.image,
            ),
          ),
          middleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizeConfig.verticalSpaceSmall(),
              Row(
                children: [
                  Expanded(child: Text(AppStrings.REQUESTS.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                  Text(DateService.getDateFormatddMMyyyy(order.selectedDate.toIso8601String(), context),
                    style: AppStyles.GrayStyleItalicFont16(context),),

                ],
              ),
              SizeConfig.verticalSpaceSmall(),
              Text(order.clientDetails.name,style: AppStyles.BlackStyleWithBold800Font_24(context),),
             SizeConfig.verticalSpaceMedium(),
              CustomRatingWidget(reviewCount: 15, initialRating: 2, stars: 3.5),
              SizeConfig.verticalSpaceMedium(),
              Text(order.clientDetails.twoLineAddress,
                style: AppStyles.BlackStyleFontBold_16(context),),
              SizeConfig.verticalSpaceSmall(),
            ],
          )),
    );

  }
}
