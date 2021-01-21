import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/enums/user_type.dart';
import 'package:storeangelApp/core/models/auth_responsemodel.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/auth_service.dart';
import 'package:storeangelApp/core/services/sharedPreference.dart';
import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/signupDetails_Screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/facebook/facebookl_login_web_view.dart';
import '../../getIt.dart';
import '../../ui/shared/MyUtils.dart';
import '../../ui/shared/base_model.dart';
import '../enums/user_type.dart';
import '../models/response_model.dart';
import '../services/firebase_abstraction.dart';

class SignUpViewModel extends BaseModel {


  FirebaseAbstraction database = getIt<FirebaseAbstraction>();
  AuthBase auth = getIt<Auth>();

  void navigateTo(String routeName) {
    navigationService.navigateTo(routeName,arguments: 'true');
  }

  Future checkUser(UserModel user,UserType userType) async {
    AppConstants.userType = userType;
    if (user?.id != null) {
      String view = await getIt<AppSharedPreferences>().getStringInPref(AppStrings.view);

      if (view == AppStrings.cutomer) {
        navigateTo(LandingScreen.routeName);
      } else if (view == AppStrings.agent) {

        navigateTo(LandingScreen.routeName);

      }
    }
  }

  Future signUp({
    @required String email,
    @required String password,
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
    auth.signUpUserWithEmailAndPassword(email, password).then((AuthResponseModel response) async {
      if (response.statusCode == 1) {
        ResponseModel responseModel = await database.saveUser(response.user);
        if (responseModel.status == 1) {
          setState(ViewState.Idle);
          MyUtils().toastsuccessdisplay(responseModel.message, toastLength: Toast.LENGTH_LONG);
          if (AppConstants.userType == UserType.Customer) {
            getIt<AppSharedPreferences>().setString(AppStrings.view, AppStrings.cutomer);
          } else {
            getIt<AppSharedPreferences>().setString(AppStrings.view, AppStrings.agent);
          }
          if (AppConstants.userType == UserType.Customer) {
            navigationService.navigateReplaceTo(SignUpDetailsScreen.routeName);
          } else {
            navigationService.navigateReplaceTo(SignUpDetailsScreen.routeName);
          }
        } else {
          setState(ViewState.Idle);
          MyUtils().toastdisplay(responseModel.message, toastLength: Toast.LENGTH_LONG);
        }


      } else {
        MyUtils().toastdisplay(response.message, toastLength: Toast.LENGTH_LONG);
        print(response.message);
        setState(ViewState.Idle);
      }
    });
  }

  Future signWithGoogle() async {
    try {
      AuthResponseModel response = await auth.loginWithGoogle();
      if (response.statusCode==1) {
        navigationService.navigateReplaceTo(SignUpDetailsScreen.routeName);
      }
    } catch (e) {
      MyUtils().toastdisplay(e.message);
    }
  }

  void switchUserType() {
    switch (AppConstants.userType) {
      case UserType.Customer:
        AppConstants.userType = UserType.Agent;
        setState(ViewState.Idle);
        break;
      case UserType.Agent:
        AppConstants.userType = UserType.Customer;
        setState(ViewState.Idle);
        break;
    }
  }

  void faceBookLogin(BuildContext context) async {
    setState(ViewState.Busy);
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
    print(result);
    if (result != null) {

      AuthResponseModel response = await auth.signUpAndLoginWithFacebook(result);
      if (response.statusCode == 1) {
        setState(ViewState.Idle);
        MyUtils().toastsuccessdisplay(response.message);
        getIt<AppSharedPreferences>().setString(AppStrings.USERTYPE, AppConstants.userType.toString());
        if (AppConstants.userType == UserType.Customer) {
          navigationService.navigateReplaceTo(SignUpDetailsScreen.routeName);
        } else {
          navigationService.navigateReplaceTo(SignUpDetailsScreen.routeName);
        }
      } else {
        MyUtils().toastdisplay(response.message);
        print(response.message);
        setState(ViewState.Idle);
      }
    }else{
      setState(ViewState.Idle);
    }
  }
  void appleLogin(BuildContext context)async{

    setState(ViewState.Busy);
    bool isAppleSignIn = await AppleSignIn.isAvailable();
    if(isAppleSignIn){
      AuthResponseModel response = await auth.signUpWithApple();
      if (response.statusCode == 1) {
        setState(ViewState.Idle);
        MyUtils().toastsuccessdisplay(response.message);
        getIt<AppSharedPreferences>().setString(AppStrings.USERTYPE, AppConstants.userType.toString());
        if (AppConstants.userType == UserType.Customer) {
          navigationService.navigateReplaceTo(SignUpDetailsScreen.routeName);
        } else {
          navigationService.navigateReplaceTo(SignUpDetailsScreen.routeName);
        }
      } else {
        MyUtils().toastdisplay(response.message);
        print(response.message);
      }
    }else{
      MyUtils().toastdisplay(AppStrings.APPLE_ID_SIGN_IN_NOT_AVAILABLE.tr());
    }
    setState(ViewState.Idle);


  }
}
