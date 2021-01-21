import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/widgets/signup/first_lastname_widget.dart';

class PaymentOptionWithTextWidget extends StatelessWidget {
  final String title;
  final bool value;
  final Function onChanged;
  final String textTitle;
  final TextEditingController controller;
  PaymentOptionWithTextWidget({this.controller,this.value,this.onChanged,this.title,this.textTitle});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(title,
                style: AppStyles.BlackStyleFont_20(context))),
            CupertinoSwitch(value: value, onChanged: (value){
             onChanged(value);
            },activeColor: Theme.of(context).primaryColor,
            trackColor: Theme.of(context).primaryColorLight,)
          ],),
        value&&textTitle!=null?Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeConfig.CVerticalSpaceSmallMedium(),
           Text(textTitle,style: AppStyles.GrayStyle_FontMedium(context),),
           SizeConfig.CVerticalSpaceSmallMedium(),
           TextTextfieldWidget(
              hint: '',
              radius: SizeConfig.introGetStarted_button_Radius,
              buttonColor: Theme.of(context).cardColor,
              controller:controller,
            ),
          ],
        ):Container(),

      ],
    );
  }
}
