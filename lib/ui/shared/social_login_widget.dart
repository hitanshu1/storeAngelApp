import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/ui/widgets/signupAsCourier/signup_media_button_widget.dart';

class SocialLoginWidget extends StatelessWidget {
  final Function onTapFaceBook,onTapGoogle,onTapApple;
  SocialLoginWidget({this.onTapApple,this.onTapFaceBook,this.onTapGoogle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: SizeConfig.screenWidth * .23,
          height: SizeConfig.screenWidth * .13,
          child: SignUpCourierSocialMedia(
            image: AssetsPath.fbLogo,
            name: AppStrings.FB_BUTTON.tr(),
            textColor: AppColors.whiteColor,
            radius: SizeConfig.screenWidth*.05,
            fontSize: SizeConfig.screenHeight * .012,
            colorButton: AppColors.facebookButtonColor,
            filterColor: Colors.white,
            onPressed: () {
              onTapFaceBook();
            },
          ),
        ),
        SizedBox(
          width: SizeConfig.screenWidth * .23,
          height: SizeConfig.screenWidth * .13,
          child: SignUpCourierSocialMedia(
            image: AssetsPath.googleLogo,
            name: AppStrings.GOOGLE_BUTTON.tr(),
            textColor:Theme.of(context).focusColor,
            radius: SizeConfig.screenWidth*.05,
            fontSize: SizeConfig.screenHeight * .012,
            colorButton: Theme.of(context).cardColor,
            onPressed: () {
             onTapGoogle();
            },
          ),
        ),
        SizedBox(
          width: SizeConfig.screenWidth * .23,
          height: SizeConfig.screenWidth * .13,
          child: SignUpCourierSocialMedia(
            image: AssetsPath.appleLogo,
            name: AppStrings.APPLE_ID.tr(),
            textColor: Theme.of(context).focusColor,
            filterColor: Theme.of(context).focusColor,
            radius: SizeConfig.screenWidth*.05,
            fontSize: SizeConfig.screenHeight * .012,
            colorButton: Theme.of(context).cardColor,
            onPressed: () async{
             onTapApple();
            },
          ),
        ),
      ],
    );
  }
}
