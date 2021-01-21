import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class CourierOrderActionButton extends StatelessWidget {
  final String firstButtonText;
  final Function firstButtonTap;
  final String secondButtonText;
  final Function secondButtonTap;
  final bool enableSecondBotton;

  const CourierOrderActionButton(
      {Key key, this.firstButtonText, this.firstButtonTap, this.secondButtonText, this.secondButtonTap,this.enableSecondBotton:true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: secondButtonTap,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(AppConstants.button_Radius),
            ),
            height: SizeConfig.buttonHeight,
            width: SizeConfig.screenWidth-SizeConfig.sidepadding.left*2,
            child: Padding(
              padding: SizeConfig.sidepadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    secondButtonText,
                    style: TextStyle(color: AppColors.whiteColor, fontSize: SizeConfig.fontSizeLarge),
                  ),
                ],
              ),
            ),
          )
        ),
        Opacity(
          opacity: enableSecondBotton?1:0,
          child: TextButton(
              child: Container(
                padding: SizeConfig.sidepadding,
                height: SizeConfig.orderScreenButtonHeight,
                width: SizeConfig.screenWidth-SizeConfig.sidepadding.left*2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(AppConstants.button_Radius)),
                child: Text(
                  firstButtonText ?? AppStrings.UNDO.tr(),
                  style: AppStyles.GrayStyle_Font24(context),
                ),
              ),
              onPressed: firstButtonTap),
        ),
//        SizeConfig.horizontalSpace(4),
      ],
    );
  }
}
