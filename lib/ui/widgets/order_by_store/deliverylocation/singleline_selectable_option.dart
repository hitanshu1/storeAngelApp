import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

import 'delevery_location_checkbox.dart';

class SingleLineSelectableOption extends StatelessWidget {
  final bool value;
  final String title;
  final Function onTap;
  final EdgeInsets padding;
  final Color textColor;

  SingleLineSelectableOption({this.value, this.title, this.onTap, this.padding, this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding ?? SizeConfig.innerMediumPadding,
        decoration: BoxDecoration(
            color: value ? Theme.of(context).primaryColor : Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(SizeConfig.radiusSmall)),
        child: Column(
          children: [
            Row(
              children: [
                DeliveryLocationCheckBoxWidget(
                  value: value,
                ),
                SizeConfig.horizontalSpaceSmall(),
                Expanded(
                  child: Text(
                    '$title',
                    style:
                        value ? AppStyles.WhiteStyleWithBold800_Font16 : AppStyles.BlackStyleWithBold800Font_16(context).copyWith(
                          color: textColor
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
