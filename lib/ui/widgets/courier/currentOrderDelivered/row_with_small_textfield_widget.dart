import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/regexService.dart';
import 'package:storeangelApp/ui/shared/smalltextfield.dart';

class RowWithSmallTextFieldWidget extends StatelessWidget {
 final String firstText,secondText;
 final TextStyle firstTextStyle,secondTextStyle;

 RowWithSmallTextFieldWidget({this.secondText,this.firstText,this.firstTextStyle,this.secondTextStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  firstText??'',
                  style: firstTextStyle!=null?firstTextStyle:AppStyles.BlackStyleFont_20(context).copyWith(fontWeight: FontWeight.bold),
                ),
                secondText != null &&
                    secondText != ''
                    ? Text(secondText,
                    style: secondTextStyle!=null?secondTextStyle:AppStyles.BlackStyleFont_16(context))
                    : Container()
              ],
            )),
        SizeConfig.horizontalSpaceSmall(),
        SizeConfig.horizontalSpaceSmall(),
        Container(
          width: SizeConfig.screenWidth * .26,
          height: SizeConfig.adaptiveHeight(SizeConfig.screenHeight * .04),
          margin: EdgeInsets.only(bottom: SizeConfig.screenHeight*.01, top: SizeConfig.screenHeight*.01),
          child: SmallTextField(
            textInputType: TextInputType.numberWithOptions(signed: true,decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegexService.doubleRegexWithCommaOrDotAndTwoDigit)
            ],
            textInputAction: TextInputAction.done,
            hintText: NumberService.getDollarOrEuroHintText(context),
            hasBorderSideColor: false,
          ),
          decoration:
          BoxDecoration(color:Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
        ),
      ],
    );
  }
}
