import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/simple_textfield_increment_decrement_widget.dart';
import 'package:storeangelApp/ui/shared/kg_increment_decrement_button.dart';

class ItemEditableValueWidget extends StatelessWidget {
  final Product product;
  final bool enable;
  ItemEditableValueWidget({this.product,this.enable:true});


  Widget _viewRowValue(BuildContext context,String initialValue,String title){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:SizeConfig.sidepadding.copyWith(
            left: 30+SizeConfig.sidepadding.left,
          ),
          child: Text(title,style: AppStyles.GrayStyleItalicFont16(context),),
        ),
        SizeConfig.verticalSpaceVeryGap(),
        SimpleTextFieldWithIncrementDecrementWidget(controller: TextEditingController(),initialValue:initialValue,
          textFieldColor: Theme.of(context).backgroundColor,enable: enable,),
      ],
    );
  }
  Widget _viewKgRowValue(BuildContext context,String initialValue,String title){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:SizeConfig.sidepadding.copyWith(
            left: 30+SizeConfig.sidepadding.left,
          ),
          child: Text(title,style: AppStyles.GrayStyleItalicFont16(context),),
        ),
        SizeConfig.verticalSpaceVeryGap(),
        KgIncrementDecrementButton(controller: TextEditingController(),initialValue: initialValue,
          textFieldColor: Theme.of(context).backgroundColor,),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    print('====${product.quantity}');

      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _viewRowValue(context, '${product.quantity}', AppStrings.UNIT.tr())),
              Expanded(child: _viewKgRowValue(context, 'KG', AppStrings.QUANTITY.tr())),
            ],
          ),
          SizeConfig.verticalSpaceSmall(),
          Row(
            children: [
              Expanded(child: _viewRowValue(context, '1', AppStrings.EURO.tr())),
              Expanded(child: _viewRowValue(context, '1', AppStrings.CENT.tr())),
            ],
          ),

        ],
      );

  }
}
