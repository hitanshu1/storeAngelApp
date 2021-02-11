import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_signup_confirmation.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';

class SignUpConfirmationScreen extends StatelessWidget {
  static const String routeName = 'signUpConfirmationScreen';
  final File imageFile;
  SignUpConfirmationScreen({this.imageFile});

  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpConfirmationViewModel>(
      builder: (context,model,child){
        if(model.state==ViewState.Busy){
          return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: AppConstants.circulerProgressIndicator());
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: SizeConfig.sidepadding,
              child: Column(
                children: [
                  SizeConfig.CVerticalSpaceExtraBig(),
                  Stack(
                    children: [
                      Container(
                        height: SizeConfig.fileImageContainerSize,
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                            color: AppColors.lightGrayLittleColor,
                            image: DecorationImage(image: FileImage(imageFile),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(AppConstants.button_Radius)
                        ),
                      ),
                      Positioned.fill(child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(AssetsPath.roundWhitSelected),
                      ))
                    ],
                  ),
                  SizeConfig.CVerticalSpaceMedium25(),
                  Text(AppStrings.YOU_ARE_BEING_VERIFIED.tr(),style: AppStyles.BlackStyleWithBold_FontC20(context),),
                  SizeConfig.CVerticalSpaceMedium25(),
                  SizedBox(
                      width: SizeConfig.screenWidth*.85,
                      child: Text(AppStrings.WE_LL_LET_YOU.tr(),
                        style: AppStyles.BlackStyleFontWeightSmall_20(context),textAlign: TextAlign.center,)),
                  SizeConfig.CVerticalSpaceMedium25(),
                  SizedBox(
                      width: SizeConfig.screenWidth*.85,
                      child: Text(AppStrings.FOR_NOW_YOU_CAN.tr(),
                        style: AppStyles.BlackStyleFontWeightSmall_20(context),textAlign: TextAlign.center,)),
                  SizeConfig.CVerticalSpaceBigger(),
                ],
              ),
            ),
          ),
          floatingActionButtonAnimator: NoScalingAnimation(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton:Padding(
            padding:  EdgeInsets.only(
                left: SizeConfig.screenWidth*.1,
                right: SizeConfig.screenWidth*.1,
                bottom: SizeConfig.screenHeight*.04
            ),
            child: ButtonWidget(
                radius: AppConstants.button_Radius,
                fontSize:AppConstants.fontSizeSmall,

                buttonColor: AppColors.green,
                buttonText: AppStrings.LETS_START.tr(),
                onPressed: (){
                  model.onStart();
                }),
          ),
        );
      },
    );
  }
}
