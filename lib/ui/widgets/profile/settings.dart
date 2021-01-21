import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_setting.dart';
import 'package:storeangelApp/ui/screens/courier/courier_signup_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/platform_alert_dialog.dart';
import 'package:storeangelApp/ui/shared/search_appbar_widget.dart';

class Settings extends StatefulWidget {
  final bool agentView;

  Settings({this.agentView});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Size size = Size(0, 0);

  @override
  Widget build(BuildContext context) {
    //Higher Providers within the widget tree --> managing high level tasks
    final profileModel = Provider.of<ProfileViewModel>(context);
    final appThemeViewModel = Provider.of<AppThemeViewModel>(context);

    //Change StatusBar color and theme
    StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);

    return Scaffold(
      appBar: SearchAppBar(
        child: Row(
          children: [
            BackButton(
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                profileModel.changeView(ProfilePageView.home);
              },
            ),
            Expanded(
                child: Text(
              AppStrings.SETTINGS.tr(),
              style: AppStyles.BlackStyleWithBold800Font_24(context),
              textAlign: TextAlign.center,
            )),
            Opacity(
              opacity: 0,
              child: BackButton(
                color: Theme.of(context).iconTheme.color,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      body: BaseView<SettingViewModel>(
        onModelReady: (settingsViewModel) => settingsViewModel.onDataInitialize(context),
        builder: (context, settingsViewModel, child) {
          if (settingsViewModel.state == ViewState.Busy) {
            return AppConstants.circulerProgressIndicator();
          } else {
            return Stack(
              children: [
                ListView(
                  children: [

                    SizeConfig.verticalSpaceSmall(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            AppStrings.DARK_MODE.tr(),
                            style: AppStyles.BlackStyleWithBold800Font_20(context),
                          )),
                          Container(
                            width: SizeConfig.screenWidth * .4,
                            height: SizeConfig.adaptiveHeight(SizeConfig.screenHeight * .05),
                            child: Padding(
                              padding: SizeConfig.sidepadding,
                              child: Center(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  dropdownColor: Theme.of(context).cardColor,
                                  icon: Icon(Icons.expand_more),
                                  underline: Container(),
                                  items: settingsViewModel.themeModes.map((modeValue) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        modeValue,
                                        style: AppStyles.BlackStyleFont_20(context),
                                      ),
                                      value: modeValue,
                                    );
                                  }).toList(),
                                  onChanged: (String value) {
                                    settingsViewModel.onChangeMode(value, appThemeViewModel);
                                  },
                                  value: settingsViewModel.selectedMode,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(SizeConfig.borderRadius * .8)),
                          )
                        ],
                      ),
                    ),
                    SizeConfig.verticalSpaceSmall(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            AppStrings.CHANGE_LANGUAGE.tr(),
                            style: AppStyles.BlackStyleWithBold800Font_20(context),
                          )),
                          Container(
                            width: SizeConfig.screenWidth * .4,
                            height: SizeConfig.adaptiveHeight(SizeConfig.screenHeight * .05),
                            child: Padding(
                              padding: SizeConfig.sidepadding,
                              child: Center(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  dropdownColor: Theme.of(context).cardColor,
                                  icon: Icon(Icons.expand_more),
                                  underline: Container(),
                                  items: settingsViewModel.languages.map((language) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        language,
                                        style: AppStyles.BlackStyleFont_20(context),
                                      ),
                                      value: language,
                                    );
                                  }).toList(),
                                  onChanged: (String value) {
                                    settingsViewModel.onSelectLanguage(value, context);
                                  },
                                  value: settingsViewModel.selectedLanguage,
                                  hint: Text(
                                    settingsViewModel.getLanguage(context),
                                    style: AppStyles.BlackStyleFont_20(context),
                                  ),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(SizeConfig.borderRadius * .8)),
                          ),
                        ],
                      ),
                    ),

                    SizeConfig.CVerticalSpaceMedium(),
                    !widget.agentView
                        ? Padding(
                            padding: SizeConfig.sidepadding,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.PUBLISH_ALL_ITEMS.tr(),
                                      style: AppStyles.BlackStyleWithBold800Font_20(context),
                                    ),
                                    Text(
                                      AppStrings.TO_ALL_SUBSCRIBED.tr(),
                                      style: AppStyles.BlackStyleWithBold800Font_20(context),
                                    )
                                  ],
                                )),
                                CupertinoSwitch(
                                  value: settingsViewModel.publishAllItems,
                                  onChanged: (val) {
                                    settingsViewModel.changePublishValue(val);
                                  },
                                  activeColor: AppColors.primaryColor,
                                  trackColor: Theme.of(context).cardColor,
                                )
                              ],
                            ),
                          )
                        : Container(),
                    InkWell(
                      child: Padding(
                        padding: SizeConfig.sidepadding,
                        child: Text(
                          AppStrings.VERIFICATION.tr(),
                          style: AppStyles.BlackStyleWithBold800Font_20(context),
                        ),
                      ),
                      onTap: (){
                      settingsViewModel.navigateToScreen(CourierVerifyScreen.routeName);

                      },
                    ),
                  ],
                ),
                settingsViewModel.showAnimation
                    ? Positioned.fill(
                        child: Align(
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          // Use the properties stored in the State class.
                          width: size.width,
                          height: size.height,
                          decoration: BoxDecoration(
                            color: AppColors.black.withOpacity(.5),
                          ),
                          duration: Duration(milliseconds: 300),
                        ),
                      ))
                    : Container(),
              ],
            );
          }
        },
      ),
    );
  }

  Future<bool> optionsCameraDialogBox(
      BuildContext context, SettingViewModel settingViewModel, AppThemeViewModel appThemeViewModel) async {
    return await PlatformAlertDialog(
      title: AppStrings.GET_YOUR_IMAGE.tr(),
      content: '\n${AppStrings.SELECT_WHICH_IMAGE_OPTION_YOU_WANT_TO_CHOOSE.tr()}\n',
      defaultActionText: AppStrings.OPEN_CAMERA_DIALOG_TEXT.tr(),
      defaultFunction: () async {
        final bool result = await settingViewModel.openCamera();
        if (result) {
          appThemeViewModel.changeThemeSettings(
              isBackgroundImageActive: true, backgroundImagePath: settingViewModel.imageFile.path,opacity: settingViewModel.opacity);
          if(settingViewModel.imageFile!=null){
            settingViewModel.changeShowBackGroundImage(true);
          }
          return true;
        }

        return false;
      },
      defaultActionText2: AppStrings.OPEN_GALLERY_DIALOG_TEXT.tr(),
      defaultFunction2: () async {
        final bool result = await settingViewModel.getGalleryImage();
        if (result) {
          appThemeViewModel.changeThemeSettings(
              isBackgroundImageActive: true, backgroundImagePath: settingViewModel.imageFile.path);
          if(settingViewModel.imageFile!=null){
            settingViewModel.changeShowBackGroundImage(true);
          }
          return true;
        }

        return false;
      },
      barrierDismissible: true,
    ).show(context);
  }

  void cupertinoSwitcherOnChanged(
      bool val, SettingViewModel settingsViewModel, AppThemeViewModel appThemeViewModel) async {
    if (val) {
      if (settingsViewModel.imageFile?.path?.isEmpty??true) {
        await optionsCameraDialogBox(context, settingsViewModel, appThemeViewModel);
        print('hasNewImage: ${settingsViewModel.imageFile!=null}');
        return;
      }
    }

    //If user didn't upload any new image or wants to deselect the image, everything will be set to false
    appThemeViewModel.changeThemeSettings(isBackgroundImageActive: false, backgroundImagePath: null);
    settingsViewModel.changeShowBackGroundImage(false);
  }
}
