
import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class SelectableItemViewModel extends BaseModel{
  void navigatorPop() {
    navigationService.pop();
  }

  void navigateToScreen(String routeName,BuildContext context,StatusBarType statusBarType,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value){
      setState(ViewState.Idle);
      StatusBarService.changeStatusBarColor(statusBarType,context);
    });
  }


}