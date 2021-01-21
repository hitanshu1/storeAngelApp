import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/premiumViewModel.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/circuler_button_widget.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
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
    final theme = Theme.of(context);

    return BaseView<PremiumViewModel>(
      onModelReady: (premiumViewModel) => premiumViewModel.initialize(_scrollController),
      builder: (context, premiumViewModel, child) => Scaffold(
        appBar: CustomAppBar(
          centerTitle: true,
          backgroundColor: theme.backgroundColor,
          automaticallyImplyLeading: false,
          elevation: premiumViewModel.hasShadow ? 4 : 0,
          leading: BackButton(
            color: Theme.of(context).iconTheme.color,
          ),
          title: Text(
            AppStrings.GO_PREMIUM.tr(),
            style: AppStyles.BlackStyleWithBold800Font_24(context),
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizeConfig.verticalSpaceSmall(),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  Provider.of<AppThemeViewModel>(context).themeData == AppTheme.light
                      ? AssetsPath.illustrations_8
                      : AssetsPath.illustrations_8_dark,
                ),
              ),
              _HeaderPlusAdvantagesWidget(),
              SizeConfig.verticalSpaceExtraMedium(),
              _SpecialActivityWidget(),
              SizeConfig.verticalSpaceLarge(),
              SubscriptionWidgets(),
              SizeConfig.verticalSpaceMedium(),
              _RichTextDescription(),
              SizeConfig.verticalSpaceLarge(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .035),
                child: CircularButtonWidget(
                  onPressed: Provider.of<PremiumViewModel>(context).navigatorPop,
                  radius: AppConstants.button_Radius,
                  textColor: AppColors.whiteColor,
                  buttonColor: Theme.of(context).primaryColor,
                  buttonText: AppStrings.REDEEM_UPGRADE.tr(),
                  fontSize: SizeConfig.fontSizeLarge,
                ),
              ),
              SizeConfig.verticalSpaceLarge()
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderPlusAdvantagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizeConfig.verticalSpaceBigMedium(),
        Padding(
          padding: SizeConfig.sidepadding,
          child: AutoSizeText(
            AppStrings.RELEASE_STOREANGELS_POTENTIAL.tr(),
            maxLines: 2,
            minFontSize: 10,
            maxFontSize: AppStyles.BlackStyleWithBold700_Font40(context).copyWith(height: 1.3).fontSize,
            style: AppStyles.BlackStyleWithBold700_Font40(context).copyWith(height: 1.3),
            textAlign: TextAlign.center,
          ),
        ),
        SizeConfig.verticalSpaceMedium(),
        _checkMarkWithText(AppStrings.NO_ADS_PREMIUM.tr(), context),
        _checkMarkWithText(AppStrings.UP_TO_TEN_STORES_PREMIUM.tr(), context),
        _checkMarkWithText(AppStrings.CREATE_TOPLOSTS.tr(), context),
        _checkMarkWithText(AppStrings.UNLIMITED_ORDERS_PREMIUM.tr(), context),
        _checkMarkWithText(AppStrings.MORE_NOTIFICATIONS_EVERY_DAY.tr(), context),
        _checkMarkWithText(AppStrings.EXTENDED_ORDER_HISTORY.tr(), context),
        _checkMarkWithText(AppStrings.MULTIPLE_DELIVERY_ADDRESSES.tr(), context),
      ],
    );
  }

  Widget _checkMarkWithText(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .13, vertical: 3),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Theme.of(context).primaryColor,
            size: SizeConfig.fontSizeMedium * 1.3,
          ),
          SizeConfig.horizontalSpaceSmall(),
          Expanded(
            child: Text(
              text,
              style: AppStyles.BlackStyleFontWeight500_24(context).copyWith(
                fontSize: SizeConfig.fontSizeLarger,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecialActivityWidget extends StatelessWidget {
  final double _borderRadius = AppConstants.ContainerRoundCorner_Radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: SizeConfig.sidepadding,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).cardColor, width: 3),
          borderRadius: BorderRadius.circular(_borderRadius),
          color: Theme.of(context).backgroundColor),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.all(SizeConfig.screenWidth * .025),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.ContainerRoundCorner_Radius - 3),
                      bottomLeft: Radius.circular(AppConstants.ContainerRoundCorner_Radius - 3))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      StoreangelIcons.diamond_full,
                      color: Theme.of(context).primaryColor,
                      size: 34,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: '168',
                                style: AppStyles.BlackStyleWithBoldFont_24(context).copyWith(
                                  fontSize: SizeConfig.fontSizeLarger,
                                ),
                              ),
                              TextSpan(text: 'h ', style: AppStyles.BlackStyleFontWeight500_24(context)),
                              TextSpan(
                                text: '23',
                                style: AppStyles.BlackStyleWithBoldFont_24(context).copyWith(
                                  fontSize: SizeConfig.fontSizeLarger,
                                ),
                              ),
                              TextSpan(text: 'm', style: AppStyles.BlackStyleFontWeight500_24(context)),
                            ]),
                            maxLines: 1,
                            minFontSize: 10,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          AutoSizeText(
                            AppStrings.LEFT_UNTIL_CAMPAIGN_ENDS.tr(),
                            style: AppStyles.GrayStyle_Font12(context),
                            minFontSize: 6,
                            maxFontSize: 12,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .015),
              child: AutoSizeText.rich(
                TextSpan(children: [
                  TextSpan(
                      text: AppStrings.REDEEM_YOUR_BASIC.tr(), style: AppStyles.BlackStyleWithBoldFont_24(context)),
                  TextSpan(
                    text: ' ' + AppStrings.GET_IT_NOW.tr(),
                    style: AppStyles.BlackStyleWithBoldFont_24(context).copyWith(decoration: TextDecoration.underline),
                  )
                ]),
                textAlign: TextAlign.center,
                maxLines: 2,
                minFontSize: 8,
                maxFontSize: SizeConfig.fontSizeLarge,
              ),
            ),
          )
        ],
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
