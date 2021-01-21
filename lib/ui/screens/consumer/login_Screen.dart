import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/auth_service.dart';

import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/login_viewmodel.dart';
import 'package:storeangelApp/ui/screens/consumer/forgot_password_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/signup_screen.dart';
import 'package:storeangelApp/ui/shared/apptextfield.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/social_login_widget.dart';
import '../../../core/viewmodel/login_viewmodel.dart';
import '../../shared/base_model.dart';
import '../../shared/base_view.dart';


class LoginScreen extends StatefulWidget {
  static const String routeName = 'login screen';
  final String back;
  LoginScreen({this.back});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController textEmailController = TextEditingController();

  TextEditingController textPasswordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();

  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset : false,
      resizeToAvoidBottomPadding:false,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: widget.back!=null?BackButton(
          color: Theme.of(context).iconTheme.color,
        ):Container(),
      ),
      body: BaseView<LogInViewModel>(
        builder: (context, loginModel, child) => CustomScaffold(
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.17,
                            right: SizeConfig.screenWidth * 0.17,
//                            top: SizeConfig.screenWidth * 0.04
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: SizeConfig.screenHeight * .07,
                            ),
                            Image.asset(
                              AssetsPath.storeAngelLogo,
                              height: SizeConfig.screenHeight * 0.1,
                              width: SizeConfig.screenWidth * 0.42,
                            ),
                            SizeConfig.verticalSpace(SizeConfig.screenHeight * .05),
                            Text(
                              AppStrings.WELCOME_BACK.tr(),
                              style: AppStyles.GrayStyleFontWeight500_d24(context),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Flexible(flex:2,child: SizeConfig.CVerticalSpace60()),
                      Container(
                        width: SizeConfig.screenWidth,
                        padding: EdgeInsets.only(
                            left: SizeConfig.horizontalGap,
                            right: SizeConfig.horizontalGap,
                            bottom: SizeConfig.screenHeight * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            AppTextField(
                              key: Key('email'),
                              height: SizeConfig.screenHeight * .065,
                              controller: textEmailController,
                              radius: SizeConfig.radiusSmaller,
                              focusNode: _emailFocus,
                              hintText: AppStrings.EMAIL.tr(),
                              textInputAction: TextInputAction.next,
                              nextFocusNode: _passwordFocus,
                              hintextStyle: AppStyles.grayStyleFontWeight300_d02Italic(context),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizeConfig.CVerticalSpaceSmallMedium(),
                            AppTextField(
                              key: Key('password'),
                              height: SizeConfig.screenHeight * .065,
                              controller: textPasswordController,
                              radius: SizeConfig.radiusSmaller,
                              focusNode: _passwordFocus,
                              hintText: AppStrings.PASSWORD.tr(),
                              obscureText: true,
                              hintextStyle: AppStyles.grayStyleFontWeight300_d02Italic(context),
                              keyboardType: TextInputType.text,
                              autoCorrect: false,
                              onSubmit: () {
                                loginModel.login(
                                  email: textEmailController.text.trim(),
                                  password: textPasswordController.text.trim(),
                                  context: context
                                );
                              },
                            ),
                            SizeConfig.CVerticalSpaceBigger(),
                            Padding(
                              padding:  EdgeInsets.only(bottom: bottom),
                              child: ButtonWidget(
                                buttonText: AppStrings.SIGN_IN.tr(),
                                buttonColor: Theme.of(context).primaryColor,
                                fontSize: SizeConfig.fontSizeMedium,
                                radius: SizeConfig.introGetStarted_button_Radius,
                                textColor: AppColors.whiteColor,
                                onPressed: () {
                                  loginModel.login(
                                    email: textEmailController.text.trim(),
                                    password: textPasswordController.text.trim(),
                                    context: context

                                  );
                                },
                              ),
                            ),
                            SizeConfig.verticalSpaceExtraMedium(),
                            Consumer<LogInViewModel>(
                              builder: (context, loginViewModel, child) => InkWell(
                                onTap: () {
                                  loginViewModel.navigateToScreen(SignUpScreen.routeName);
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text:  AppStrings.DONT_HAVE_ACCOUNT.tr(),
                                    style:AppStyles.GrayStyleWithBold300_Font20(context),
                                    children: <TextSpan>[
                                      TextSpan(text: AppStrings.SIGNUP.tr(), style: AppStyles.GreenStyleWithBold800_Font20(context)),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizeConfig.verticalSpaceMedium(),
                            InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      AppStrings.I_FORGOT_PASSWORD.tr(),
                                      style: AppStyles.GreenStyleWithBold800_Font20(context),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
                              },
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                            right: SizeConfig.horizontalGap,
                            left: SizeConfig.horizontalGap,
                            bottom: SizeConfig.screenHeight * .05),
                        child: SocialLoginWidget(
                          onTapApple: () {
                            loginModel.appleLogin(context);
                          },
                          onTapFaceBook: () {
                            loginModel.faceBookLogin(context);
                          },
                          onTapGoogle: (){
                            final auth = Provider.of<AuthBase>(context, listen: false);
                            loginModel.signWithGoogle(auth);},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: loginModel.state == ViewState.Busy,
                child: new Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  color: Colors.transparent,
                  child: Center(child: new CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
