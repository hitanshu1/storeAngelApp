import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/enums/available_status.dart';

class StatusDot extends StatelessWidget {
  final AvailableStatus availableStatus;
  StatusDot({this.availableStatus});
  @override
  Widget build(BuildContext context) {
    if(availableStatus==AvailableStatus.plenty){
      return Icon(Icons.lens,color: AppColors.green,size: AppConstants.smallIconheight,);
    }else if(availableStatus ==AvailableStatus.few){
      return Icon(Icons.lens,color: AppColors.amber,size: AppConstants.smallIconheight,);
    }else if(availableStatus==AvailableStatus.runOut){
      return Icon(Icons.lens,color: AppColors.red,size: AppConstants.smallIconheight,);
    }else{
      return Icon(Icons.help_outline,color:AppColors.green,size: AppConstants.smallIconheight,);
    }
  }
}
