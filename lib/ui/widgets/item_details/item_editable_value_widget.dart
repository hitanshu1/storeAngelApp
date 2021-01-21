import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/ui/shared/textfield_with_increment_decrement_button.dart';

class ItemEditableValueWidget extends StatelessWidget {
  final Product product;
  ItemEditableValueWidget({this.product});


  Widget _viewColumnValue(BuildContext context,String initialValue,String title){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:SizeConfig.sidepadding.copyWith(
              left: 30+SizeConfig.screenWidth*.26
          ),
          child: Text(title,style: AppStyles.GrayStyleItalicFont16(context),),
        ),
        SizeConfig.verticalSpaceVeryGap(),
        TextFieldWithIncrementDecrement(controller: TextEditingController(),initialValue: NumberService.addAfterCommaTwoZeros(initialValue, context),
          textFieldColor: Theme.of(context).backgroundColor,),
      ],
    );
  }
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
        TextFieldWithIncrementDecrement(controller: TextEditingController(),initialValue: NumberService.addAfterCommaTwoZeros(initialValue, context),
          textFieldColor: Theme.of(context).backgroundColor,),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    if(product.enableUnit){
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _viewRowValue(context, '1', AppStrings.UNIT.tr())),
              Expanded(child: _viewRowValue(context, '1', AppStrings.QUANTITY.tr())),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _viewColumnValue(context, '1', AppStrings.QUANTITY.tr()),
        SizeConfig.verticalSpaceVeryGap(),
        _viewColumnValue(context, '1', AppStrings.EURO.tr()),
        SizeConfig.verticalSpaceVeryGap(),
        _viewColumnValue(context, '1', AppStrings.CENT.tr()),

      ],
    );
  }
}
