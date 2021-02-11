import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/shared/textfield_with_increment_decrement_button.dart';

class TextFieldIncrementDecrementTile extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final double initialValue;
  TextFieldIncrementDecrementTile({@required this.title,@required this.controller,this.initialValue});


  @override
  Widget build(BuildContext context) {
    return AppShapeItem(child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).toggleableActiveColor
      ),
      child: Padding(
        padding:SizeConfig.paddingWihLittleHeight,
        child: Row(
          children: [
            Expanded(child: Text(title+':',style: AppStyles.BlackStyleWithBold800Font_24(context),)),

            TextFieldWithIncrementDecrement(controller: controller,initialValue:NumberService.addAfterCommaTwoZeros(initialValue.toString(), context),)


          ],
        ),
      ),
    ));
  }
}
