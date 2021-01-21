import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_item_details.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/status_dot.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class ProductStatusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemDetailsViewModel>(
        builder: (context,model,child){
      return SliverToBoxAdapter(
        child: Padding(
          padding: SizeConfig.sidepadding,
          child: CustomFiveWidgetsTile(
              trailingOne: Center(
                child: StatusDot(availableStatus: model.currentProduct.availableStatus,),
              ),
              enableTrailingTwoPadding: false,
              trailingTwo: FittedBox(
                fit: BoxFit.cover,
                child: ViewAppImage(
                  imageUrl: model.currentProduct.storeDetails.image,
                ),
              ),
              imageUrl: model.currentProduct.createdBy.imageUrl,
              middleWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(AppStrings.PRODUCT_STATUS.tr(),style: AppStyles.BlackStyleFont16Light(context),)),

                      Text(TimeAgoService.timeAgoSinceDate(DateTime.now().subtract(Duration(minutes: 14)), context),
                        style: AppStyles.GrayStyleItalicFont16(context),),

                    ],
                  ),
                  SizeConfig.verticalSpaceSmall(),
                  Text(model.currentProduct.createdBy.name,style: AppStyles.BlackStyleWithBold800Font_24(context),),
                  SizeConfig.verticalSpaceSmall(),
                  Text(AppStrings.euroSymbol+NumberService.priceAfterConvert(model.currentProduct.price, context),style: AppStyles.BlackStyleFont20W300(context),),
                  SizeConfig.verticalSpaceMedium(),
                  Text(model.currentProduct.storeDetails.twoLineAddress,
                    style: AppStyles.BlackStyleFont16Light(context),)
                ],
              )),
        ),
      );
    });
  }
}
