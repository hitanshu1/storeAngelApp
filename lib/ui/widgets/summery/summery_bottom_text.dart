import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class SummeryBottomTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: SizeConfig.sidepadding,
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(text: AppStrings.BY_PLACING_YOUR_ORDER_YOU_ACCEPT_OURS.tr(), style: AppStyles.BlackStyleFont_20(context)),
              TextSpan(text: ' ${AppStrings.GENERAL_TERMS_AND_CONDITIONS.tr()}',
              style: AppStyles.GreenStyle_Font20Italic(context)),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
