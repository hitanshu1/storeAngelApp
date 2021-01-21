import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class StartingViewModel extends BaseModel {

  Stream<UserModel> onAuthenticationState;

  void delayFunction(String routeName,Object argument) {
      navigationService.navigateTo(routeName,arguments: argument);
  }
}