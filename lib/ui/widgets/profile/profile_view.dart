import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/sharedPreference.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:storeangelApp/ui/screens/courier/courier_signup_screen.dart';
import 'package:storeangelApp/ui/screens/premiumScreen.dart';
import 'package:storeangelApp/ui/screens/premium_first_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/custom_tile_with_image.dart';
import 'package:storeangelApp/ui/shared/platform_alert_dialog.dart';
import 'package:storeangelApp/ui/shared/premium_widget.dart';
import 'package:storeangelApp/ui/widgets/profile/angent_customer_tab_widget.dart';
import 'package:storeangelApp/ui/widgets/profile/profile_details_widget.dart';
import 'package:storeangelApp/ui/widgets/profile/profile_view/profile_header_widget.dart';
import '../../../getIt.dart';

class ProfileView extends StatefulWidget {
  final bool customerMode;

  ProfileView({this.customerMode: false});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Consumer<ProfileViewModel>(
        builder: (context, profileViewModel, child) {
          if (profileViewModel.state == ViewState.Busy) {
            return AppConstants.circulerProgressIndicator();
          } else {
            return CustomScrollView(
              slivers: [
                ProfileHeaderWidget(),
               SizeConfig.verticalSliverSmallSpace(),
               SliverToBoxAdapter(
                 child: ProfileDetailsWidget(user:profileViewModel.user ,),
               ),

               SizeConfig.verticalSliverMediumSpace(),
                widget.customerMode?MultiSliver(children: [
                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.user,
                      titleText: AppStrings.PERSONAL.tr(),
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      iconColor: AppColors.primaryColor,
                      onTap: (){
                        profileViewModel.changeView(ProfilePageView.personalInfo);
                      },
                    ),
                  ),
                  SizeConfig.verticalSliverSmallSpace(),

                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.location_pin_full,
                      iconColor: AppColors.primaryColor,
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      titleText: AppStrings.DELIVERY_ADDRESSES.tr(),
                      onTap: (){
                        profileViewModel.changeView(ProfilePageView.myAddress);
                      },
                    ),
                  ),
                  SizeConfig.verticalSliverSmallSpace(),
                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.settings_icon,
                      iconColor: AppColors.primaryColor,
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      titleText: AppStrings.SETTINGS.tr(),
                      onTap: (){
                        profileViewModel.changeView(ProfilePageView.setting);
                      },
                    ),
                  ),
                  SizeConfig.verticalSliverSmallSpace(),
                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.diamond_full,

                      iconColor: AppColors.primaryColor,
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      titleText: AppStrings.PREMIUM_UPGRADE.tr(),
                      onTap: ()async{
                        profileViewModel.changeView(ProfilePageView.premium);
                        await profileViewModel.navigateToScreen(PremiumFirstScreen.routeName);
                        profileViewModel.changeView(ProfilePageView.home);
                      },
                    ),
                  ),
                  SizeConfig.verticalSliverSmallSpace(),
                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.profile_consumer_tab,

                      iconColor: AppColors.primaryColor,
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      titleText: AppStrings.CONTACT_AND_HELP.tr(),
                      onTap: (){
                        profileViewModel.changeView(ProfilePageView.feedback);
                      },
                    ),
                  ),

                  SizeConfig.verticalSliverSmallSpace(),
                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.notifications_icon,
                      iconColor: AppColors.primaryColor,
                      titleText: AppStrings.NOTIFICATIONS.tr(),
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      onTap: (){
                        profileViewModel.changeView(ProfilePageView.notifications);
                      },
                    ),
                  ),
                  SizeConfig.verticalSliverSmallSpace(),
                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.password_icon,
                      iconColor: AppColors.primaryColor,
                      titleText: AppStrings.PRIVACY.tr(),
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      onTap: (){
                        profileViewModel.changeView(ProfilePageView.privacy);
                      },
                    ),
                  ),

                  SizeConfig.verticalSliverMediumSpace(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: SizeConfig.sidepadding,
                      child: Text(AppStrings.SWITCH_TO_SUPPLIER_MODE.tr(),
                        style: AppStyles.BlackStyleFont_20(context),
                        textAlign: TextAlign.start,),
                    ),
                  ),

                ]):
                MultiSliver(children: [
                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.user,
                      titleText: AppStrings.PERSONAL.tr(),
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      iconColor: AppColors.primaryColor,
                      onTap: (){
                        profileViewModel.changeView(ProfilePageView.personalInfo);
                      },
                    ),
                  ),
                  SizeConfig.verticalSliverSmallSpace(),
                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.credit_card_order_flow_icon_full,
                      titleText: AppStrings.PAYMENT_METHOD.tr(),
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      iconColor: AppColors.primaryColor,
                      onTap: (){
                        profileViewModel.changeView(ProfilePageView.paymentOptions);
                      },
                    ),
                  ),
                  SizeConfig.verticalSliverSmallSpace(),

                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.diamond_full,
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      iconColor: AppColors.primaryColor,
                      titleText: AppStrings.PREMIUM_UPGRADE.tr(),
                      onTap: ()async{
                        profileViewModel.changeView(ProfilePageView.premium);
                        await profileViewModel.navigateToScreen(PremiumFirstScreen.routeName);
                        profileViewModel.changeView(ProfilePageView.home);
                      },
                    ),
                  ),
                  SizeConfig.verticalSliverSmallSpace(),

                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.settings_icon,

                      iconColor: AppColors.primaryColor,
                      titleText: AppStrings.SETTINGS.tr(),
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      onTap: (){
                        profileViewModel.changeView(ProfilePageView.setting);
                      },
                    ),
                  ),
                  SizeConfig.verticalSliverSmallSpace(),
                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.notifications_icon,
                      iconColor: AppColors.primaryColor,
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      titleText: AppStrings.NOTIFICATIONS.tr(),
                      onTap: (){
                        profileViewModel.changeView(ProfilePageView.notifications);
                      },
                    ),
                  ),
                  SizeConfig.verticalSliverSmallSpace(),
                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.profile_consumer_tab,

                      iconColor: AppColors.primaryColor,
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      titleText: AppStrings.CONTACT_AND_HELP.tr(),
                      onTap: (){
                        profileViewModel.changeView(ProfilePageView.feedback);
                      },
                    ),
                  ),


                  SizeConfig.verticalSliverSmallSpace(),
                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.password_icon,
                      iconColor: AppColors.primaryColor,
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      titleText: AppStrings.PRIVACY.tr(),
                      onTap: (){
                        profileViewModel.changeView(ProfilePageView.privacy);
                      },
                    ),
                  ),
                  SizeConfig.verticalSliverSmallSpace(),
                  SliverToBoxAdapter(
                    child: CustomTileWithIcon(
                      iconData: StoreangelIcons.insurance_icon,
                      iconColor: AppColors.primaryColor,
                      style: AppStyles.BlackStyleFontWeight400_24(context),
                      titleText: AppStrings.ASSURE.tr(),
                      onTap: (){
                        profileViewModel.changeView(ProfilePageView.assure);
                      },
                    ),
                  ),
                  SizeConfig.verticalSliverMediumSpace(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: SizeConfig.sidepadding,
                      child: Text(AppStrings.SWITCH_TO_CUSTOMER_MODE_AND_LET_A_STOREANGEL_DO_YOUR_SHOPPING.tr(),
                        style: AppStyles.BlackStyleFont_20(context),
                        textAlign: TextAlign.start,),
                    ),
                  ),

                ]),

                SizeConfig.verticalSliverSmallSpace(),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: SizeConfig.sidepadding,
                    child: AgentCustomerTabWidget(isCustomer: widget.customerMode,
                      onSelectTap: (){
                        onTapChangeUser(context,profileViewModel);
                      },),
                  ),
                ),
                

                SizeConfig.verticalSliverMediumSpace(),
                SliverToBoxAdapter(
                  child: PremiumWidget(),
                ),
                SizeConfig.verticalSliverSmallSpace(),


              ],
            );

          }
        },
      ),
    );
  }


  Future<bool> _showDialog(String text, String content) {
    return PlatformAlertDialog(
      title: text,
      content: content,
      defaultActionText: AppStrings.YES.tr(),
      defaultActionText2: AppStrings.NO.tr(),
      defaultFunction2: () {
        Navigator.of(context, rootNavigator: true).pop(false);
      },
    ).show(context);
  }

  void onTapChangeUser(BuildContext context, ProfileViewModel profileViewModel) async {
    if (!widget.customerMode) {
      final result = await _showDialog(AppStrings.CHANGE_TO_USER_TITLE.tr(), AppStrings.CHANGE_TO_USER_CONTENT.tr());
      if (!result) return;
      await getIt<AppSharedPreferences>().setString(AppStrings.view, AppStrings.cutomer);
      profileViewModel.navigateToScreen(LandingScreen.routeName);
    } else {
      final result = await _showDialog(AppStrings.CHANGE_TO_ANGEL_TITLE.tr(), AppStrings.CHANGE_TO_ANGEL_CONTENT.tr());
      if (!result) return;
      await getIt<AppSharedPreferences>().setString(AppStrings.view, AppStrings.agent);
      if (profileViewModel.user.verify != 0) {
        profileViewModel.navigateToScreen(LandingScreen.routeName);
      } else {
        profileViewModel.navigateToScreen(CourierVerifyScreen.routeName);
      }
    }
  }
}
