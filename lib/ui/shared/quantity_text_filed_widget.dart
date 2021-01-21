
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/regexService.dart';

class QuantityTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function onChange;
  QuantityTextFieldWidget({this.controller,this.onChange});
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      style: AppStyles.BlackStyleFont_16(context),
      controller: controller,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegexService.doubleRegexWithCommaOrDotAndTwoDigit),
      ],
      onChanged: (val){
        final quantity=num.tryParse(val);
        if(quantity!=null){
          if(quantity>0){
            onChange(quantity);
          }

        }


      },

    );
  }
}
