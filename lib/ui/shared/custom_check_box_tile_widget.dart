import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/shared/custom_check_box.dart';

class CustomCheckBoxTileWidget extends StatelessWidget {
  final bool value;
  final Function onTap;
  final String title;
  final bool isBorderColor;
  final EdgeInsets padding;
  CustomCheckBoxTileWidget({@required this.value,@required this.onTap,@required this.title,this.isBorderColor:true,this.padding});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Padding(
          padding: padding??SizeConfig.verticalPadding,
          child: Row(
            children: [
              CustomCheckBox(value: value,
                onTap: onTap),
              SizeConfig.horizontalSpaceSmall(),
              Text(title,style: AppStyles.BlackStyle_Font16(context),),

            ],
          ),
        ),
        decoration: BoxDecoration(
            border: isBorderColor?Border(
                bottom: BorderSide(color: AppColors.dividerColor(context))
            ):Border()
        ),
      ),
    );
  }
}
