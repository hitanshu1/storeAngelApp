import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class AddItemsSearchViewModel extends BaseModel{
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments,BuildContext context}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value) {
      StatusBarService.changeStatusBarColor(StatusBarType.Gray,context);
    });
  }
}