import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';

class DeliveryLocationCheckBoxWidget extends StatelessWidget {
  final bool value;
  DeliveryLocationCheckBoxWidget({this.value});
  @override
  Widget build(BuildContext context) {
    if(value){
      return  Container(
        height: 25,
        width: 25,
        child: Icon(Icons.check, color: Theme.of(context).primaryColor,),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.whiteColor
        ),
      );
    }else{
      return  Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.lightGreyColor, width: 2),
            color: Theme.of(context).backgroundColor
        ),
      );
    }
  }
}
