import 'package:flutter/material.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class ReadyToWorkViewModel extends BaseModel{
  bool readyToWorkValue=true;

  void updateReadyToWorkValue(bool value){
    setState(ViewState.Busy);
    readyToWorkValue=value;
    setState(ViewState.Idle);
  }
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,BuildContext context,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value) {
      StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    });
  }

}