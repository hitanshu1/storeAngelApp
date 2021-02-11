import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class DeliveryInfoRowWidget extends StatelessWidget {
  final String firstText, secondText;
  final TextStyle firstTextStyle, secondTextStyle;
  final bool hasBorderColor;
  final bool enablePadding;
  final Color borderSideColor;

  DeliveryInfoRowWidget(
      {this.firstText,
      this.secondText,
      this.hasBorderColor: true,
      this.enablePadding: true,
      this.secondTextStyle,
      this.firstTextStyle,
      this.borderSideColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: enablePadding ? SizeConfig.sidepadding : EdgeInsets.zero,
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: hasBorderColor
                ? AppConstants.bottomBorder(context)
                : Border()),
        child: Padding(
          padding: enablePadding ? SizeConfig.verticalMedPadding : EdgeInsets.zero,
          child: Row(
            children: [
              Text(
                firstText,
                style: firstTextStyle != null ? firstTextStyle : AppStyles.GrayStyle_Font16(context),
              ),
              Expanded(
                  child: AutoSizeText(
                secondText,
                minFontSize: 10,
                maxLines: 2,
                maxFontSize: secondTextStyle != null ? secondTextStyle.fontSize : AppStyles.BlackStyleWithBold600Font_20(context).fontSize,
                style: secondTextStyle != null ? secondTextStyle : AppStyles.BlackStyleWithBold600Font_20(context),
                textAlign: TextAlign.right,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
