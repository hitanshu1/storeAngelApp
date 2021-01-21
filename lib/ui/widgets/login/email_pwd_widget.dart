import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/shared/apptextfield.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:easy_localization/easy_localization.dart';

class EmailPasswordWidget extends StatefulWidget {
  final Color colorBackground;
  final double radius;
  final Color textColor;
  final double fontSize;

  final TextInputAction textInputAction;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  EmailPasswordWidget(
      {this.colorBackground,
      this.radius,
      this.textColor,
      this.fontSize,
      this.emailController,
        this.textInputAction,
      this.passwordController});

  @override
  _EmailPasswordWidgetState createState() => _EmailPasswordWidgetState();
}

class _EmailPasswordWidgetState extends State<EmailPasswordWidget> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AppTextField(
            height: SizeConfig.screenHeight*.065,
            controller: widget.emailController,
            radius:SizeConfig.radiusSmaller,
            focusNode: _emailFocusNode,
            hintText: AppStrings.EMAIL.tr(),
            textInputAction: TextInputAction.next,
            nextFocusNode: _passwordFocusNode,
            hintextStyle: AppStyles.grayStyleFontWeight300_d02Italic(context),
            keyboardType: TextInputType.emailAddress,
          ),

          SizeConfig.CVerticalSpaceSmallMedium(),
          AppTextField(
            height: SizeConfig.screenHeight*.065,
            controller: widget.passwordController,
            radius:SizeConfig.radiusSmaller,
            focusNode: _passwordFocusNode,
            hintText: AppStrings.PASSWORD.tr(),
            obscureText: true,
            hintextStyle: AppStyles.grayStyleFontWeight300_d02Italic(context),
            keyboardType: TextInputType.text,
            autoCorrect: false,

          ),

        ],
      ),
    );
  }
}
