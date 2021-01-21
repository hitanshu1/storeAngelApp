import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../ui/screens/consumer/login_Screen.dart';
import '../../ui/screens/consumer/signup_screen.dart';
import '../../ui/shared/base_model.dart';
import '../enums/user_type.dart';

class UserDecideTypeViewModel extends BaseModel {
  
  void navigateToSignUpAsConsumerScreen(){
    navigationService.navigateTo(SignUpScreen.routeName, arguments: SignUpArguments(userType: UserType.Customer,showBackButton: true));
  }
  
  void navigateToSignUpAsAgentScreen(){
    navigationService.navigateTo(SignUpScreen.routeName, arguments: SignUpArguments(
      userType: UserType.Agent,showBackButton: true
    ));
  }

  void navigateToLoginScreen(){
    navigationService.navigateTo(LoginScreen.routeName,arguments: 'true');
  }
}
