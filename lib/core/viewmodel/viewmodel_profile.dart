import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/auth_service.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/sharedPreference.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

enum ProfilePageView {
  home,
  myAddress,
  personalInfo,
  businessInformation,
  setting,
  notifications,
  privacy,
  insurance,
  premium,
  feedback,
  paymentOptions,
  assure
}

class ProfileViewModel extends BaseModel {
  ProfileViewModel() {
    print('profile viewmodel created');
  }

  ProfilePageView profilePageView = ProfilePageView.home;

  AuthBase auth = getIt<Auth>();

  FirebaseAbstraction database = getIt<FirebaseAbstraction>();
  UserModel user;

  void getUserDetails(UserModel userModel) async {
    UserModel _user = await database.getUserDetails(userModel.id);
    if (_user != null) {
      user = _user;
    } else {
      user = userModel;
    }
  }

  void changeView(ProfilePageView view) {
    profilePageView = view;
    print(profilePageView);
    setState(ViewState.Idle);
  }

  void signOut() async{
    await auth.signOut();
    await getIt<AppSharedPreferences>().setString(AppStrings.view, null);
    navigationService.navigateTo(LandingScreen.routeName, arguments: LandingScreenArgument(isAlready: true));
  }

  void navigatorPop() {
    navigationService.pop();
  }

  Future<void> navigateToScreen(
    String routeName, {
    Object arguments,
  }) async{
    await navigationService.navigateTo(routeName, arguments: arguments);
  }
}
