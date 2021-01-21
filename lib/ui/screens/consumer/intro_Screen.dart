import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/intro_viewmodel.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';

class IntroScreen extends StatelessWidget {
  static const String routeName = 'introScreen';
  final String title;

  IntroScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);

    return Scaffold(
//      resizeToAvoidBottomInset: false,
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset(
                    AssetsPath.splashBackground,
                    height: SizeConfig.screenHeight,
                    width: SizeConfig.screenWidth,
                    fit: BoxFit.fitWidth,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.17,
                        right: SizeConfig.screenWidth * 0.17,
                        top: SizeConfig.screenHeight * 0.11),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          AssetsPath.storeAngelLogo,
                          height: SizeConfig.screenHeight * 0.11,
                          width: SizeConfig.screenWidth * 0.5,
                        ),
                        SizeConfig.verticalSpaceMedium(),
                        Text(
                          AppStrings.LEAVE_THE_CLICK_IN_YOUR_PLACE.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.black.withOpacity(.6),
                            fontSize: SizeConfig.fontSizeMedium,
                          ),
                        ),
                        SizeConfig.verticalSpaceLarge(),
                      ],
                    ),
                  ),
                  BaseView<IntroViewModel>(
                    builder: (context, model, child) => Positioned(
                      bottom: SizeConfig.screenHeight * 0.06,
                      child: Container(
                        padding: EdgeInsets.only(left: SizeConfig.horizontalGap, right: SizeConfig.horizontalGap),
                        width: SizeConfig.screenWidth,
                        child: ButtonWidget(
                            buttonText: AppStrings.GET_STARTED.tr(),
                            buttonColor: Theme.of(context).primaryColor,
                            fontSize: SizeConfig.fontSizeMedium,
                            radius: SizeConfig.introGetStarted_button_Radius,
                            textColor: AppColors.whiteColor,
                            onPressed: model.navigateToScreen),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
