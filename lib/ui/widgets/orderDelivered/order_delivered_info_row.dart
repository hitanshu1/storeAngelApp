import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

String _fontFamily = 'PTMono';

class OrderDeliveredInfoRowWidget extends StatelessWidget {
  final String firstText, secondText;
  final bool borderColor;
  final TextStyle firstTextStyle, secondTextStyle;

  OrderDeliveredInfoRowWidget(
      {this.firstText, this.secondText, this.borderColor: true, this.firstTextStyle, this.secondTextStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          firstText,
          style: firstTextStyle != null
              ? firstTextStyle
              : AppStyles.BlackStyleFont_20(context).copyWith(fontFamily: _fontFamily),
        ),
        Expanded(
            child: Text(
          secondText != null ? secondText : '',
          style: secondTextStyle != null
              ? secondTextStyle
              : AppStyles.BlackStyleFont_20(context).copyWith(fontFamily: _fontFamily),
          textAlign: TextAlign.right,
        ))
      ],
    );
  }
}
