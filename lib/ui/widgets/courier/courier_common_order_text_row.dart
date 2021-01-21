import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class CourierCommonOrderTextRowWidget extends StatelessWidget {
  final String firstText, secondText;
  final TextStyle firstTextSyle, secondTextStyle;
  final Widget firstChild, secondChild;
  final Function onTapFirstItem;

  CourierCommonOrderTextRowWidget(
      {this.secondTextStyle,
      this.secondText,
      this.firstText,
      this.firstTextSyle,
      this.firstChild,
      this.secondChild,
      this.onTapFirstItem});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Align(
          alignment: Alignment.centerLeft,
          child: firstChild != null
              ? firstChild
              : InkWell(
                  onTap: onTapFirstItem,
                  child: Text(
                    firstText,
                    style: firstTextSyle != null ? firstTextSyle : AppStyles.GrayStyle_Font16(context),
                    maxLines: 1,
                  ),
                ),
        )),
        SizeConfig.horizontalSpaceSmall(),
        Expanded(
          child: secondChild != null
              ? secondChild
              : Text(
                  secondText,
                  style: secondTextStyle != null ? secondTextStyle : AppStyles.GrayStyle_Font16(context),
                  maxLines: 1,
                ),
        ),
      ],
    );
  }
}
