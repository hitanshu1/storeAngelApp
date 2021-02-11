import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/view_model_courier_order_summery.dart';
import 'package:storeangelApp/ui/shared/app_rating_widget.dart';
class CourierOrderSummeryRationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CourierOrderSummeryViewModel>(
        builder:(context,model,child){
          return SliverToBoxAdapter(
            child: Column(
              children: [
                Text(AppStrings.RATE_YOUR_PURCHASE_FOR_NOW.tr(),
                style: AppStyles.GrayStyleItalicFont20(context),),
                SizeConfig.verticalSpaceVeryGap(),
                Text(model.clientDetails.name,style: AppStyles.BlackStyleWithBold800Font_20(context).copyWith(
                  fontStyle: FontStyle.italic
                ),),
                SizeConfig.verticalSpaceSmall(),
                AppRatingWidget(initialRating: 0, maxRating: 5,
                size: SizeConfig.largeIcon,)

              ],
            ),
          );
        });
  }
}
