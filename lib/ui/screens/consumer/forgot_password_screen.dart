import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/forgot_password_viewmodel.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/apptextfield.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = 'forgotPasswordScreen';

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: SizeConfig.sidelargepadding,
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * .09,
                        ),
                        Image.asset(
                          AssetsPath.storeAngelLogo,
                          height: SizeConfig.screenHeight * 0.1,
                          width: SizeConfig.screenWidth * 0.42,
                        ),
                        SizeConfig.verticalSpace(SizeConfig.screenHeight * .055),
                        Text(
                          AppStrings.NO_WORRIES.tr(),
                          style: AppStyles.GrayStyleFontWeight500_d24(context),
                        ),
                        SizeConfig.CVerticalSpaceVarySmall(),
                        Text(AppStrings.WE_LL_GET_IT_BACK_FOR_YOU.tr(),
                            style: AppStyles.GrayStyleFontWeight500_d24(context)),
                        SizeConfig.CVerticalSpaceExtraBig(),
                        AppTextField(
                          height: SizeConfig.screenHeight * .065,
                          controller: model.emailController,
                          radius: SizeConfig.radiusSmaller,
                          hintText: AppStrings.EMAIL.tr(),
                          textInputAction: TextInputAction.next,
                          hintextStyle: AppStyles.grayStyleFontWeight300_d02(context),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizeConfig.CVerticalSpaceSmallMediumC12(),
                        AppTextField(
                          height: SizeConfig.screenHeight * .065,
                          controller: model.newPasswordController,
                          radius: SizeConfig.radiusSmaller,
                          hintText: AppStrings.NEW_PASSWORD.tr(),
                          textInputAction: TextInputAction.next,
                          hintextStyle: AppStyles.grayStyleFontWeight300_d02Italic(context),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        SizeConfig.CVerticalSpaceSmallMediumC12(),
                        AppTextField(
                          height: SizeConfig.screenHeight * .065,
                          controller: model.confirmPasswordController,
                          radius: SizeConfig.radiusSmaller,
                          hintText: AppStrings.NEW_PASSWORD.tr(),
                          textInputAction: TextInputAction.next,
                          hintextStyle: AppStyles.grayStyleFontWeight300_d02Italic(context),
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                        ),
                        SizeConfig.verticalSpace(SizeConfig.screenHeight * .07),
                        ButtonWidget(
                          buttonText: AppStrings.SEND_PASSWORD.tr(),
                          buttonColor: Theme.of(context).primaryColor,
                          fontSize: SizeConfig.fontSizeMedium,
                          radius: SizeConfig.introGetStarted_button_Radius,
                          textColor: AppColors.whiteColor,
                          onPressed: () async{
                            try {
                              await model.forgotPassword();
                              _dialog(context, AppStrings.SUCCESS.tr(), AppStrings.THE_PASSWORD_HAS_BEEN_SEND.tr());
                            } catch (e) {
                              _dialog(context, AppStrings.ERROR_OCCURED.tr(), e.toString());
                            }
                          },
                        ),
                        SizeConfig.verticalSpaceMedium(),
                        InkWell(
                          child: Text(
                            AppStrings.BACK_TO_LOGIN.tr(),
                            style: AppStyles.GrayStyleFontWeight500_d24(context),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: model.state == ViewState.Busy,
                child: new Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  color: Colors.transparent,
                  child: Center(child: new CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  void _dialog(BuildContext context, String header, String message){
    MyUtils.showAppDialog(
        context: context,
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.screenWidth*.1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: AppStyles.BlackStyleFont_20(context),
                textAlign: TextAlign.center,
              ),
              SizeConfig.verticalSpaceSmall(),
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text(AppStrings.OK.tr(),
              style: AppStyles.GreenStyleWithBold800_Font20(context),))

            ],
          ),
        ));
  }
}
