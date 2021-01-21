import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/contact_And_Help_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/search_appbar_widget.dart';
import 'package:storeangelApp/ui/widgets/signup/first_lastname_widget.dart';

class ContactHelp extends StatefulWidget {
  @override
  _ContactHelpState createState() => _ContactHelpState();
}

class _ContactHelpState extends State<ContactHelp> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray,context);
    final profileModel=Provider.of<ProfileViewModel>(context);
    return BaseView<ContactAndHelpViewModel>(
        onModelReady: (contactAndHelpViewModel) {
          contactAndHelpViewModel.initialize(_scrollController);
        },
      builder: (context, contactAndHelpViewModel, child) {
        return Scaffold(
          appBar: CustomAppBar(
            elevation: contactAndHelpViewModel.hasShadow?4:0,
            leading: BackButton(
              color: Theme.of(context).iconTheme.color,
              onPressed: (){
                profileModel.changeView(ProfilePageView.home);
              },
            ),
            title: Text(AppStrings.CONTACT_AND_HELP.tr(),
              style: AppStyles.BlackStyleWithBold800Font_24(context),
              textAlign: TextAlign.center,),
            centerTitle: true,
          ),
          body: Padding(
            padding: SizeConfig.padding,
            child: ListView(
              controller: _scrollController,
              children: [
                Text(
                  AppStrings.YOUR_MESSAGE.tr(),
                  style: AppStyles.GrayStyleWithBold500_Font16(context),
                  textAlign: TextAlign.start,
                ),
                SizeConfig.verticalSpaceSmall(),

                TextTextfieldWidget(
                  padding: SizeConfig.innerpadding,
                  height: SizeConfig.screenHeight*.4,
                  maxLines: 5,
                  hint: AppStrings.MESSAGE_HINT.tr(),
                  radius: SizeConfig.introGetStarted_button_Radius,
                  buttonColor: Theme.of(context).cardColor,
                  textInputAction: TextInputAction.next,
                ),
                SizeConfig.verticalSpaceMedium(),
                Text(
                  AppStrings.HOW_CAN_WE_CONTACT_YOU.tr(),
                  style: AppStyles.GrayStyleWithBold500_Font16(context),
                  textAlign: TextAlign.start,
                ),
                SizeConfig.verticalSpaceSmall(),
                TextTextfieldWidget(
                  hint: AppStrings.YOUR_EMAIL.tr(),
                  radius: SizeConfig.introGetStarted_button_Radius,
                  buttonColor: Theme.of(context).cardColor,

                  textInputAction: TextInputAction.next,
                ),
                SizeConfig.verticalSpaceExtraMedium(),
                ButtonWidget(onPressed: (){

                },buttonText: AppStrings.SEND.tr(),
                  radius: AppConstants.button_Radius,
                  fontSize: AppConstants.fontSizeSmall,
                  buttonColor: Theme.of(context).primaryColor,),

              ],
            ),
          ),

        );
      }
    );
  }
}
