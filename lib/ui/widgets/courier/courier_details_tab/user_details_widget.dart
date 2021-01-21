import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/shared/app_rating_widget.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/deliveryinfo_rowWidget.dart';

class UserDetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: SizeConfig.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeConfig.verticalSpaceSmall(),
            Text(
              AppStrings.USER_INFORMATIONS.tr(),
              style: AppStyles.BlackStyleFont_20(context),
            ),
            SizeConfig.verticalSpaceSmall(),
            DeliveryInfoRowWidget(
              hasBorderColor: false,
              enablePadding: false,
              firstText: AppStrings.PURCHASE_ORDER.tr() + ':',
              secondText: '6',
            ),
            SizeConfig.verticalSpaceSmall(),
            DeliveryInfoRowWidget(
              hasBorderColor: false,
              enablePadding: false,
              firstText: AppStrings.COMPLETED_ORDERS.tr() + ':',
              secondText: '4',
            ),
            SizeConfig.verticalSpaceSmall(),
            Row(
              children: [
                Expanded(
                    child: Text(
                  AppStrings.RATING.tr() + ':',
                  style: AppStyles.GrayStyle_Font16(context),
                )),
                AppRatingWidget(
                  initialRating: 3,
                  maxRating: 5,
                  enable: false,
                )
              ],
            ),
            SizeConfig.verticalSpaceSmall(),
          ],
        ),
      ),
    );
  }
}
