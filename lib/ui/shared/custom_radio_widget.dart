import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class CustomRadioWidget extends StatelessWidget {
  final bool isSelected;
  final String title;
  final TextStyle titleTextStyle;
  final Function onTap;
  CustomRadioWidget({@required this.isSelected,@required this.title,this.titleTextStyle,this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          isSelected?Icon(Icons.check_circle,color: Theme.of(context).primaryColor,):
          Icon(Icons.radio_button_unchecked,color: Theme.of(context).primaryColorLight,),
          SizeConfig.horizontalSpaceSmall(),
          Text(title,style:titleTextStyle??AppStyles.BlackStyleFont_20(context),)
        ],
      ),
      onTap: onTap,
    );
  }
}
