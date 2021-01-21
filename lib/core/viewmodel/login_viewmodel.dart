import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/enums/user_type.dart';
import 'package:storeangelApp/core/models/auth_responsemodel.dart';
import 'package:storeangelApp/core/services/auth_service.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/sharedPreference.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/signup_screen.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/facebook/facebookl_login_web_view.dart';

class LogInViewModel extends BaseModel {
//  FirebaseAbstraction database = getIt<FirebaseAbstraction>();
//  AuthBase auth = getIt<Auth>();


  void navigateToScreen(String routeName) {
    navigationService.navigateTo(routeName, arguments: SignUpArguments(userType: UserType.Customer));
  }

  Future login({
    @required String email,
    @required String password,BuildContext context
  }) async {
    setState(ViewState.Busy);

    if (!MyUtils().validateEmail(email)) {
      setState(ViewState.Idle);
      return false;
    }

    if (!MyUtils().validatePassword(password)) {
      setState(ViewState.Idle);
      return false;
    }
    final auth = Provider.of<AuthBase>(context, listen: false);
    final response=await auth.loginWithEmailAndPassword(email, password);
    if (response.statusCode == 1) {
      if (AppConstants.userType != UserType.Customer) {
        navigationService.navigateTo(LandingScreen.routeName);
      } else {
        navigationService.navigateTo(LandingScreen.routeName);
      }
    } else {
      MyUtils().toastdisplay(response.message);
    }
    setState(ViewState.Idle);
  }

  void appleLogin(BuildContext context,) async {
    setState(ViewState.Busy);
    final auth = Provider.of<AuthBase>(context, listen: false);
    bool isAppleSignIn = await AppleSignIn.isAvailable();
    if (isAppleSignIn) {
      AuthResponseModel response = await auth.signUpWithApple();
      if (response.statusCode == 1) {
        setState(ViewState.Idle);
        MyUtils().toastsuccessdisplay(response.message);
        getIt<AppSharedPreferences>().setString(AppStrings.USERTYPE, AppConstants.userType.toString());
        if (AppConstants.userType != UserType.Customer) {
          navigationService.navigateTo(LandingScreen.routeName);
        } else {
          navigationService.navigateTo(LandingScreen.routeName);
        }
      } else {
        MyUtils().toastdisplay(response.message);
        print(response.message);
      }
    } else {
      MyUtils().toastdisplay(AppStrings.APPLE_ID_SIGN_IN_NOT_AVAILABLE.tr());
    }
    setState(ViewState.Idle);
  }

  Future signWithGoogle(AuthBase auth) async {
    setState(ViewState.Busy);
    try {
      AuthResponseModel response = await auth.loginWithGoogle();
      if (response.statusCode == 1) {
        navigationService.navigateTo(LandingScreen.routeName);
      }
    } catch (e) {

      print('error==$e');
      MyUtils().toastdisplay(e.message);
    }
    setState(ViewState.Idle);
  }

  void faceBookLogin(BuildContext context) async {
    setState(ViewState.Busy);
    final auth = Provider.of<AuthBase>(context, listen: false);
    String yourClientId = AppConstants.faceBookClientID;
    String yourRedirectUrl = "https://www.facebook.com/connect/login_success.html";
    String result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FaceBookLogInWebView(
                  selectedUrl:
                      'https://www.facebook.com/dialog/oauth?client_id=$yourClientId&redirect_uri=$yourRedirectUrl&response_type=token&scope=email,public_profile,',
                ),
            maintainState: true));
    if (result != null) {
      AuthResponseModel response = await auth.signUpAndLoginWithFacebook(result);
      if (response.statusCode == 1) {
        setState(ViewState.Idle);
        MyUtils().toastsuccessdisplay(response.message);
        getIt<AppSharedPreferences>().setString(AppStrings.USERTYPE, AppConstants.userType.toString());
        if (AppConstants.userType != UserType.Customer) {
          navigationService.navigateTo(LandingScreen.routeName);
        } else {
          navigationService.navigateTo(LandingScreen.routeName);
        }
      } else {
        MyUtils().toastdisplay(response.message);
        print(response.message);
      }
    } else {
      setState(ViewState.Idle);
    }

    setState(ViewState.Idle);
  }
}
