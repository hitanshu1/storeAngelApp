import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order_details.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:storeangelApp/ui/shared/view_order_status.dart';
import 'package:easy_localization/easy_localization.dart';

class CourierOrderDetailsStoreTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CourierOrderDetailsViewModel>(builder: (context,model,child){
      return CustomFiveWidgetsTile(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 5.0), // shadow direction: bottom right
            )
          ],

          trailingOneBackGroundColor: AppColors.blueGradient,
          trailingTwoBackGroundColor: AppColors.blueGradient,
          trailingOne: ViewOrderStatusWidget(status: model.orderByStore.status,),
          trailingTwo: FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${model.orderByStore.clients.length}',style: AppStyles.WhiteStyle_WithBold900_Font36,),
                Text(AppStrings.ORDERS.tr(),style: AppStyles.WhiteStyle_FontSmall,)

              ],
            ),
          ), imageUrl: model.orderByStore.storeDetails.image,
          middleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizeConfig.verticalSpaceSmall(),
              Row(
                children: [
                  Expanded(child: Text(AppStrings.ORDER.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                  Text(TimeAgoService.timeAgoSinceDate(model.orderByStore.orderTime, context),
                    style: AppStyles.GrayStyleItalicFont16(context),),

                ],
              ),
              SizeConfig.verticalSpaceSmall(),
              Text(model.titleString,style: AppStyles.BlackStyleWithBold800Font_24(context),),
              SizeConfig.verticalSpaceSmall(),
              Text(AppStrings.euroSymbol+' ${NumberService.priceAfterConvert(model.orderByStore.orderAmount, context)}'+' | '+'${model.orderByStore.products.length} '+AppStrings.ARTICLES.tr(),
                style: AppStyles.BlackStyleFont20W300(context),),
              SizeConfig.verticalSpaceSmall(),
              CustomRatingWidget(reviewCount: 15, initialRating: 2, stars: 3.5),
              SizeConfig.verticalSpaceSmall(),
              Text(model.orderByStore.storeDetails.twoLineAddress,
                style: AppStyles.BlackStyleFont16Light(context),),
              SizeConfig.verticalSpaceSmall(),
            ],
          ));
    });
  }
}
