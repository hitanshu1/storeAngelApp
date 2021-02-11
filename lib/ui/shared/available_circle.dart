import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/enums/available_status.dart';

class AvailableCircleWidget extends StatelessWidget {
  final AvailableStatus availableStatus;
  AvailableCircleWidget({this.availableStatus});


  Widget iconWidget(){
    if(availableStatus==AvailableStatus.few){
      return Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.amber
        ),
      );
    }else if(availableStatus==AvailableStatus.plenty){
      return Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.green
        ),
      );

    }else if(availableStatus==AvailableStatus.runOut){
      return Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.red
        ),
      );

    }else{
      return Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.amber
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return iconWidget();
  }
}
