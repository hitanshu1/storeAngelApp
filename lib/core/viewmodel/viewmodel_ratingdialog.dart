import 'package:storeangelApp/ui/shared/base_model.dart';

class RatingDialogViewModel extends BaseModel{
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments,}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }
}