import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/screens/insurance_screen.dart';
import 'package:storeangelApp/ui/screens/privacy_screen.dart';
import 'package:storeangelApp/ui/widgets/profile/assure_screen.dart';
import 'package:storeangelApp/ui/widgets/profile/contact_help.dart';
import 'package:storeangelApp/ui/widgets/profile/my_addresses.dart';
import 'package:storeangelApp/ui/widgets/profile/notifications.dart';
import 'package:storeangelApp/ui/widgets/profile/payment_option.dart';
import 'package:storeangelApp/ui/widgets/profile/persional_information.dart';
import 'package:storeangelApp/ui/widgets/profile/profile_view.dart';
import 'package:storeangelApp/ui/widgets/profile/settings.dart';

class ProfileScreen extends StatefulWidget {
  final bool customerView;

  ProfileScreen({this.customerView: false});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder:(context, profileViewModel, child)=> WillPopScope(
          onWillPop: () async {

            if (profileViewModel.profilePageView != ProfilePageView.home) {
              profileViewModel.changeView(ProfilePageView.home);
              return true;
            }
            return true;
          },
          child: _body()),
    );
  }

  Widget _body() {
    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, child){

        switch(profileViewModel.profilePageView){
          case ProfilePageView.home:
            return ProfileView(
              customerMode: widget.customerView,
            );
          case ProfilePageView.myAddress:
            return MyAddresses();
          case ProfilePageView.personalInfo:
            return PersonalInformationScreen(agentView: widget.customerView,);
          case ProfilePageView.paymentOptions:
            return PaymentOption();
          case ProfilePageView.setting:
            return Settings(agentView: widget.customerView,);
          case ProfilePageView.notifications:
            return Notifications();
          case ProfilePageView.privacy:
            return PrivacyScreen();
          case ProfilePageView.feedback:
            return ContactHelp();
          case ProfilePageView.insurance:
            return InsuranceScreen();
          case ProfilePageView.assure:
            return AssureScreen();
          default:
            return ProfileView(
              customerMode: widget.customerView,
            );
        }
      },
    );
  }

}
