import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class EmailPwdRoundWidget extends StatelessWidget {
  final String hint;
  final Color colorButton;
  final double radius;
  final Color textColor;
  final double fontSize;
  final GestureTapCallback onPressed;
  final TextEditingController emailController;

  EmailPwdRoundWidget({
    @required this.hint,
    @required this.onPressed,
    this.colorButton,
    this.radius,
    this.textColor,
    this.fontSize,
    this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.RoundSignupButton_ContainerHeight,
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.all(AppConstants.TextField_Contentpading_top),
      decoration: BoxDecoration(
        color: colorButton ?? Colors.black,
        borderRadius: BorderRadius.circular(radius ?? 0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(AppConstants.ShadowBox_WithOpacity),
            spreadRadius: AppConstants.ShadowBox_SpreadRadius,
            blurRadius: AppConstants.ShadowBox_BlurRadius,
            offset: Offset(0, AppConstants.ShadowBox_Offset), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: emailController,
        obscureText: true,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (term) {
          //loginCheck();
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(AppConstants.TextField_Contentpading, 0.0,
              AppConstants.TextField_Contentpading_top, AppConstants.TextField_Contentpading),
          hintText: hint,
        ),
      ),
    );
  }
}
