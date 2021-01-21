import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/ui/shared/premium_card.dart';
import 'package:easy_localization/easy_localization.dart';
class PremiumWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConfig.sidepadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PremiumCard(
            title: AppStrings.REDEEM_YOUR_30DAY.tr(),
            subtitle: AppStrings.AND_USE_STORE_ANGEL.tr(),
          ),
          SizeConfig.verticalSpace(SizeConfig.bottomPadding.bottom),
        ],
      ),
    );
  }
}
