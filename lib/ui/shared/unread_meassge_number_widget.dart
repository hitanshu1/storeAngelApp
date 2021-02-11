import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class UnreadMessageNumberWidget extends StatelessWidget {
  final int totalMessage;
  UnreadMessageNumberWidget({this.totalMessage});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,

      child: Center(child: Text('$totalMessage',
      style: AppStyles.WhiteStyle_Font20,),),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
        border: Border.all(color: AppColors.whiteColor)

      ),
    );
  }
}
