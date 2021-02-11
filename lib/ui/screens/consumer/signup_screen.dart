import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/user_type.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/signup_viewmodel.dart';
import 'package:storeangelApp/ui/screens/consumer/login_Screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/shared/social_login_widget.dart';
import 'package:storeangelApp/ui/widgets/login/email_pwd_widget.dart';

import '../../../core/consts/appString.dart';
import '../../../core/enums/user_type.dart';
import '../../../core/viewmodel/signup_viewmodel.dart';
import '../../shared/base_view.dart';

class SignUpArguments {
  UserType userType;
  bool showBackButton;

  SignUpArguments({this.showBackButton: false, this.userType});
}

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'signUpScreen';

  final SignUpArguments arguments;

  const SignUpScreen({Key key, this.arguments}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isProgressDisplay = false;

  final _textEmailController = TextEditingController();
  final _textPasswordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    final user = Provider.of<UserModel>(context);
    return BaseView<SignUpViewModel>(
      onModelReady: (signUpViewModel) => signUpViewModel.checkUser(user, widget.arguments.userType),
      onModelDisposed: (signUpViewModel) {
        _textEmailController.dispose();
        _textPasswordController.dispose();
        _emailFocus.dispose();
        _passwordFocus.dispose();
      },
      builder: (context, signUpViewModel, child) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: Tween<double>(begin: 0.3, end: 1.0).animate(animation),
            child: child,
          ),
          //For animation purposes
          child: AppConstants.userType == UserType.Customer ? _body(signUpViewModel) : _body(signUpViewModel),
        );
      },
    );
  }

  Widget _body(SignUpViewModel signUpViewModel) => Scaffold(
        key: UniqueKey(),
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: widget.arguments.showBackButton
              ? BackButton(
                  color: Theme.of(context).iconTheme.color,
                )
              : Container(),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  signUpViewModel.navigateTo(
                    LoginScreen.routeName,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, SizeConfig.screenHeight * .01, 20, SizeConfig.screenHeight * .01),
                  child: Text(
                    AppStrings.LOGIN.tr(),
                    style: TextStyle(
                        fontSize: SizeConfig.fontSizeLarge, color: AppColors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                padding: SizeConfig.sidelargepadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizeConfig.verticalSpace(SizeConfig.screenHeight * .07),
                    Image.asset(
                      AssetsPath.storeAngelLogo,
                      height: SizeConfig.screenHeight * 0.1,
                      width: SizeConfig.screenWidth * 0.42,
                    ),
                    SizeConfig.verticalSpace(SizeConfig.screenHeight * .065),
                    AutoSizeText(
                      AppConstants.userType == UserType.Customer
                          ? AppStrings.SIGNUP.tr()
                          : AppStrings.SIGN_UP_A_STORE_ANGEL.tr(),
                      style: AppStyles.GrayStyleFontWeight500_d24(context),
                      minFontSize: 10,
                      stepGranularity: 1,
                      maxFontSize: SizeConfig.fontSizeLargestBig,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                    SizeConfig.CVerticalSpacevMedium(),
                    FlatButton(
                      onPressed: signUpViewModel.switchUserType,
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: AppStrings.I_WANT_TO_SIGN_UP_AS.tr(),
                            style: AppStyles.GreenStyleWithBold800_Font20(context),
                          ),
                          TextSpan(
                            text: ' ' +
                                '${AppConstants.userType == UserType.Customer ? AppStrings.A_COURIER.tr() : AppStrings.USER.tr()}',
                            style: AppStyles.GreenStyleWithBold800_Font20(context),
                          )
                        ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizeConfig.verticalSpace(SizeConfig.screenHeight * .014),
                    EmailPasswordWidget(
                      emailController: _textEmailController,
                      passwordController: _textPasswordController,
                      radius:SizeConfig.radiusSmaller,
                      colorBackground: Theme.of(context).cardColor,
                    ),
                    SizeConfig.verticalSpace(SizeConfig.screenHeight * .03),
                    signUpViewModel.state == ViewState.Busy
                        ? CircularProgressIndicator()
                        : ButtonWidget(
                            buttonText: AppStrings.SIGNUP.tr(),
                            buttonColor: Theme.of(context).primaryColor,
                            fontSize: SizeConfig.fontSizeMedium,
                            radius: SizeConfig.introGetStarted_button_Radius,
                            textColor: AppColors.whiteColor,
                            onPressed: () {
                              signUpViewModel.signUp(
                                  email: _textEmailController.text.trim(),
                                  password: _textPasswordController.text.trim());
                            },
                          ),
                    SizeConfig.verticalSpace(SizeConfig.screenHeight * .025),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: AppStrings.SIGN_UP_BY_CLICKING_ON_BUTTON.tr(),
                            style: AppStyles.BlackStyleFont_16(context).copyWith(fontSize: SizeConfig.fontSizeMedium),
                          ),
                          TextSpan(
                              text: AppStrings.TERM_AND_CONDITIONS.tr(),
                              style: AppStyles.GreenStyle_Font16(context)
                                  .copyWith(decoration: TextDecoration.underline, fontSize: SizeConfig.fontSizeMedium)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    SizeConfig.verticalSpace(SizeConfig.screenHeight * .03),
                    SocialLoginWidget(
                      onTapApple: () {
                        signUpViewModel.appleLogin(context);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Will be added when apple developer account is activated'),
                        ));
                      },
                      onTapFaceBook: () {
                        signUpViewModel.faceBookLogin(context);
                      },
                      onTapGoogle: () {
                        signUpViewModel.signWithGoogle();
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * .05,
                    )
                  ],
                ),
              ),
              Visibility(
                visible: _isProgressDisplay,
                child: new Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  color: Colors.transparent,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        ),
      );
}
