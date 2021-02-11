import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/premiumViewModel.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/widgets/premium_screen/premium_stores_widget.dart';
import 'package:storeangelApp/ui/widgets/profile/subscription_widget.dart';

class PremiumScreen extends StatefulWidget {
  static const String routeName = 'premiumScreen';

  @override
  _PremiumScreenState createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {


    return BaseView<PremiumViewModel>(
      onModelReady: (premiumViewModel) => premiumViewModel.initialize(_scrollController),
      builder: (context, premiumViewModel, child) => Scaffold(

        body: premiumViewModel.state==ViewState.Busy?AppConstants.circulerProgressIndicator():
        SingleChildScrollView(
          padding: EdgeInsets.zero,
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              PremiumStoresWidget(stores: premiumViewModel.stores,),
              SizeConfig.verticalSpaceLarge(),
              Padding(
                padding:SizeConfig.sidepadding,
                child: Center(child: Text(AppStrings.CHOOSE_THE_UPGRADE_THAT_RIGHT_FOR_YOU.tr(),
                style: AppStyles.GrayLightStyleWithBold500_Font20(context),)),
              ),


              SizeConfig.verticalSpaceLarge(),
              SubscriptionWidgets(),
              SizeConfig.verticalSpaceMedium(),
              _RichTextDescription(),
              SizeConfig.verticalSpaceMedium(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .035),
                child: ButtonWidget(
                  onPressed: Provider.of<PremiumViewModel>(context).navigatorPop,
                  radius: AppConstants.button_Radius,
                  textColor: AppColors.whiteColor,
                  buttonColor: Theme.of(context).primaryColor,
                  buttonText: AppStrings.REDEEM_UPGRADE.tr(),
                  fontSize: SizeConfig.fontSizeLarge,
                ),
              ),
              SizeConfig.verticalSpaceSmall(),
              Text(AppStrings.BACK_TO_FREE_VERSION.tr()),

              SizeConfig.verticalSpaceLarge()
            ],
          ),
        ),
      ),
    );
  }
}



class _RichTextDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .035),
      child: AutoSizeText.rich(
        TextSpan(children: [
          TextSpan(
            text: AppStrings.BY_SELECTING_ON_OF_THE_PACKAGES.tr(),
            style: TextStyle(fontSize: SizeConfig.fontSizeLarge, color: Theme.of(context).textTheme.headline6.color),
          ),
          TextSpan(
            text: AppStrings.TERMS_AND_CONDITION.tr() + '.',
            style: TextStyle(
                fontSize: SizeConfig.fontSizeLarge,
                color: Theme.of(context).textTheme.headline6.color,
                decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // single tapped
              },
          ),
          TextSpan(
            text: ' ' + AppStrings.THE_PACKAGE_WILL_AUTO_RENEW.tr(),
            style: TextStyle(fontSize: SizeConfig.fontSizeLarge, color: Theme.of(context).textTheme.headline6.color),
          ),
        ]),
        maxLines: 3,
        minFontSize: 8,
        textAlign: TextAlign.center,
      ),
    );
  }
}
