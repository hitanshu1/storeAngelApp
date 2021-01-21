import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';

class ViewCourierOrderStatusWidget extends StatelessWidget {
  final OrderOrPurchases order;
  ViewCourierOrderStatusWidget({this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConfig.verticalPadding,
      child: Row(
        children: [
          AutoSizeText(AppStrings.STATUS.tr(),style: AppStyles.GreenStyleWithBold800_Font20(context).copyWith(
            fontWeight: FontWeight.normal
          ),maxLines: 1,),
          AutoSizeText(AppConstants.getStatusTitle(order),
            style:  AppStyles.BlackStyleFont_20(context).copyWith(
              fontWeight: FontWeight.bold,),maxLines: 1,
          textAlign: TextAlign.end,),
        ],
      ),
    );
  }
}
