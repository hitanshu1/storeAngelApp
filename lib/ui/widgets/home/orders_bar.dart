import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/home_viewmodel.dart';

class OrdersBar extends StatelessWidget {
  final HomeViewModel model;
  OrdersBar({this.model});
  final leftPandding=EdgeInsets.only(
      left: SizeConfig.screenWidth * 0.04,
  right:SizeConfig.screenWidth * 0.04 );
  final smallleftPandding=EdgeInsets.only(
      left: SizeConfig.screenWidth * 0.03,right:SizeConfig.screenWidth * 0.03, );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: SizeConfig.padding,
          child: Text(AppStrings.ORDERS_N_PURCHASES.tr(),
            style: AppStyles.BlackStyleWithBold800Font_24(context),),
        ),
        Padding(
          padding: smallleftPandding,
          child: Container(
            width: SizeConfig.screenWidth,
            color: AppColors.lightGreyColor,
            height: 1,
          ),
        )
      ],
    );
  }
}
