import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/sharedPreference.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/screens/consumer/intro_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/login_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/mainApp_Screen.dart';
import 'package:storeangelApp/ui/screens/courier/courier_main_page.dart';

import '../../../getIt.dart';

class LandingScreen extends StatelessWidget {
  static const String routeName = 'landingScreen';
  final LandingScreenArgument argument;

  LandingScreen({Key key, this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.sizeConfigInit(context);
    final user = Provider.of<UserModel>(context);
    /*return MainAppScreen(
      index: argument?.index ?? 0,
    );*/
    if (user != null) {
      return WillPopScope(
        onWillPop: ()async{
          print('on pop back vetoed');
          final profileViewModel=Provider.of<ProfileViewModel>(context,listen: false);
          if (profileViewModel.profilePageView != ProfilePageView.home) {
            profileViewModel.changeView(ProfilePageView.home);
          }
          return false;
        },
        child: FutureBuilder<String>(
            future: getIt<AppSharedPreferences>().getStringInPref(AppStrings.view),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Provider.of<ProfileViewModel>(context).getUserDetails(Provider.of<UserModel>(context));
                if (snapshot.data == AppStrings.agent) {
                  return CourierMainAppScreen(
                    index: argument?.index ?? 0,
                  );
                } else {
                  return MainAppScreen(
                    index: argument?.index ?? 0,
                  );
                }
              } else {
                return Scaffold(
                    backgroundColor: Theme.of(context).backgroundColor,
                    body: AppConstants.circulerProgressIndicator());
              }
            }),
      );
    } else {
      return argument?.isAlready??true ? LoginScreen() : IntroScreen();
    }
  }
}

class LandingScreenArgument {
  ///shows if the user has already been logged in one time
  final bool isAlready;

  ///depending on the index the screen within the mainapp screens will selected accordingly
  final int index;

  LandingScreenArgument({this.isAlready: true, this.index: 0});
}
