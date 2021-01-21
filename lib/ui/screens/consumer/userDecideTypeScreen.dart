import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/userDecideType_viewmodel.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/circuler_button_widget.dart';
import 'package:storeangelApp/ui/widgets/decide_usertype/user_decide_item.dart';

class UserDecideTypeScreen extends StatelessWidget {
  static const String routeName = 'userDecideTypeScreen';

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppThemeViewModel>(context).themeData;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: BaseView<UserDecideTypeViewModel>(
        builder: (context, userDecideTypeModel, child) => Container(
//          padding: EdgeInsets.only(
//              left: SizeConfig.screenWidth * 0.02,
//              right: SizeConfig.screenWidth * 0.02,
//              top: SizeConfig.screenHeight * 0.08),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppHeader(
                height: SizeConfig.smallHeaderSize,
                title:AppStrings.I_WANT_TO.tr()+'...' ,
              ),
             Padding(
               padding: SizeConfig.sidepadding,
               child: FittedBox(
                 child: Column(
                   children: [
                     SizeConfig.verticalSpaceSmall(),
                     UserDecideItem(
                       image: appTheme == AppTheme.light
                           ? AssetsPath.illustrations_6b
                           : AssetsPath.illustrations_6_2_dark,
                       titleText: AppStrings.USE_STOREANGEL_FOR_PURCHASE.tr(),
                       subtitleText: AppStrings.CONSUMER_TEXT.tr(),
                       itemButtonText: AppStrings.ORDER_BUTTON.tr(),
                       onPressed: userDecideTypeModel.navigateToSignUpAsConsumerScreen,
                     ),
                     UserDecideItem(
                       isReverse: true,
                       image: appTheme == AppTheme.light
                           ? AssetsPath.illustrations_5n6
                           : AssetsPath.illustrations_5n6_dark,
                       titleText: AppStrings.WORK_COURIER.tr(),
                       subtitleText: AppStrings.SWITCH_TO_COURIER_TEXT.tr(),
                       itemButtonText: AppStrings.WORK_BUTTON.tr(),
                       onPressed: userDecideTypeModel.navigateToSignUpAsAgentScreen,
                     ),
                     SizeConfig.verticalSpaceMedium(),
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenHeight * 0.01),
                       child: ButtonWidget(
                         buttonColor: Theme.of(context).backgroundColor,
                         gradient: AppColors.blackGradient,
                         buttonText: AppStrings.I_AM_NOT_SURE_YET.tr(),
                         onPressed: userDecideTypeModel.navigateToSignUpAsConsumerScreen,
                         radius: SizeConfig.introGetStarted_button_Radius,
                         fontSize: SizeConfig.fontSizeLarge,
                       ),
                     ),
                     InkWell(
                       onTap: userDecideTypeModel.navigateToLoginScreen,
                       child: Padding(
                         padding: EdgeInsets.only(top: SizeConfig.VerticalSpaceMedium,bottom: SizeConfig.VerticalSpaceMedium),
                         child: Text(
                           AppStrings.I_ALREADY_HAVE_AN_ACCOUNT.tr(),
                           style: AppStyles.GreenStyleWithBold600_Font16(context),
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
}
