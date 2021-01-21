import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';

class CustomDialog extends StatelessWidget {
  final String title, subTitle;
  final Function onPressOk;

  CustomDialog({@required this.title, @required this.subTitle, @required this.onPressOk});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.screenWidth * .07),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizeConfig.verticalSpaceSmall(),
          Text(
            title,
            style: AppStyles.BlackStyleFontWeight500_d24(context).copyWith(fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
          SizeConfig.verticalSpaceMedium(),
          Text(
            subTitle,
            style: AppStyles.BlackStyleFontw300_20(context),
            textAlign: TextAlign.start,
          ),
          SizeConfig.verticalSpaceMedium(),
          Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  buttonColor: Theme.of(context).primaryColorLight,
                  buttonText: AppStrings.BACK.tr(),
                  fontSize: AppStyles.BlackStyleWithBold800Font_24(context).fontSize,
                  textColor: Theme.of(context).focusColor,
                  radius: SizeConfig.smallBorderRadius,
                ),
              ),
              SizeConfig.horizontalSpaceSmall(),
              Expanded(
                child: ButtonWidget(
                    onPressed: onPressOk,
                    buttonColor: Theme.of(context).primaryColor,
                    buttonText: AppStrings.OK.tr(),
                    fontSize: AppStyles.BlackStyleWithBold800Font_24(context).fontSize,
                    radius: SizeConfig.smallBorderRadius),
              )
            ],
          ),
        ],
      ),
    );
  }
}
