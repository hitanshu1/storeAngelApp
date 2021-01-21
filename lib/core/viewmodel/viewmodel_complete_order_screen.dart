

import 'package:storeangelApp/ui/shared/base_model.dart';

class CompleteOrderViewModel extends BaseModel{

  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }

}