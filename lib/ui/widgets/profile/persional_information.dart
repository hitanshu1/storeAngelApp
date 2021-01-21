import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/mobileSize.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_persional_information.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/bottomsheet_search_view.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/platform_alert_dialog.dart';
import 'package:storeangelApp/ui/shared/showbottomSheet.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/profile/profile_rating.dart';
import 'package:storeangelApp/ui/widgets/share/custom_date_picker.dart';
import 'package:storeangelApp/ui/widgets/signup/first_lastname_widget.dart';

class PersonalInformationScreen extends StatefulWidget {
  final bool agentView;

  PersonalInformationScreen({this.agentView: false});

  @override
  _PersonalInformationScreenState createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    final profileModel = Provider.of<ProfileViewModel>(context);
    return BaseView<PersonalInformationViewModel>(
      onModelReady: (personalInformationViewModel) => personalInformationViewModel.initialize(_scrollController),
      onModelDisposed: (personalInformationViewModel)=>personalInformationViewModel.disposeValues(),
      builder: (context, personalInformationViewModel, child) {
        return Scaffold(
          appBar: CustomAppBar(
            elevation: personalInformationViewModel.hasShadow ? 4 : 0,
            leading: BackButton(
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                profileModel.changeView(ProfilePageView.home);
              },
            ),
            title: Text(
              AppStrings.PERSONAL_INFORMATION.tr(),
              style: AppStyles.BlackStyleWithBold800Font_24(context),
              textAlign: TextAlign.center,
            ),
          ),
          body: Builder(
            builder: (context) {
              if (personalInformationViewModel.state == ViewState.Busy) {
                return AppConstants.circulerProgressIndicator();
              } else {
                return Padding(
                  padding: SizeConfig.padding,
                  child: ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    children: [
                      Center(
                        child: InkWell(
                          child: ViewAppImage(
                            height: SizeConfig.screenWidth * .3,
                            width: SizeConfig.screenWidth * .3,
                            radius: 100,
                            fileImage: personalInformationViewModel.imageFile,
                            state: personalInformationViewModel.state,
                            boxFit: BoxFit.none,
                          ),
                          onTap: () {
                            _optionsDialogBox(personalInformationViewModel, context);
                          },
                        ),
                      ),
                      SizeConfig.verticalSpaceMedium(),
                      ProfileRating(
                        initialRating: 5,
                        ratingAverage: 5,
                        ratingCount: 10,
                      ),
                      SizeConfig.verticalSpaceMedium(),
                      Text(
                        AppStrings.FIRST_NAME.tr(),
                        style: AppStyles.GrayStyleWithBold500_Font16(context),
                        textAlign: TextAlign.start,
                      ),
                      SizeConfig.verticalSpaceSmall(),
                      TextTextfieldWidget(
                        hint: '',
                        radius: SizeConfig.introGetStarted_button_Radius,
                        buttonColor: Theme.of(context).cardColor,
                        controller: personalInformationViewModel.firstNameController,
                        focusNode: personalInformationViewModel.firstNameFocusNode,
                        nextFocusNode: personalInformationViewModel.secondNameFocusNode,
                        textInputAction: TextInputAction.next,
                      ),
                      SizeConfig.CVerticalSpaceMedium(),
                      Text(
                        AppStrings.SECOND_NAME.tr(),
                        style: AppStyles.GrayStyleWithBold500_Font16(context),
                        textAlign: TextAlign.start,
                      ),
                      SizeConfig.verticalSpaceSmall(),
                      TextTextfieldWidget(
                        hint: '',
                        radius: SizeConfig.introGetStarted_button_Radius,
                        buttonColor: Theme.of(context).cardColor,
                        controller: personalInformationViewModel.secondNameController,
                        focusNode: personalInformationViewModel.secondNameFocusNode,
                      ),
                      SizeConfig.CVerticalSpaceMedium(),
                      Text(
                        AppStrings.EMAIL.tr(),
                        style: AppStyles.GrayStyleWithBold500_Font16(context),
                        textAlign: TextAlign.start,
                      ),
                      SizeConfig.verticalSpaceSmall(),
                      TextTextfieldWidget(
                        hint: '',
                        radius: SizeConfig.introGetStarted_button_Radius,
                        buttonColor: Theme.of(context).cardColor,
                        controller: personalInformationViewModel.emailController,
                      ),
                      SizeConfig.CVerticalSpaceMedium(),
                      Row(
                        children: [
                          SizedBox(height: SizeConfig.smallerIconSize, child: Image.asset(AssetsPath.password)),
                          SizeConfig.horizontalSpaceSmall(),
                          Text(
                            AppStrings.PASSWORD.tr(),
                            style: AppStyles.BlackStyleFont_12(context),
                          ),
                          Spacer(),
                          Text(
                            AppStrings.CHANGE_PASSWORD.tr(),
                            style: AppStyles.GreenStyleWithBold600_Font16(context),
                          ),
                        ],
                      ),
                      SizeConfig.CVerticalSpaceBig(),
                      Text(
                        AppStrings.DATE_OF_BIRTHDAY.tr(),
                        style: AppStyles.GrayStyleWithBold500_Font16(context),
                        textAlign: TextAlign.start,
                      ),
                      SizeConfig.verticalSpaceSmall(),
                      InkWell(
                          child: TextTextfieldWidget(
                            hint: '',
                            enabled: false,
                            radius: SizeConfig.introGetStarted_button_Radius,
                            buttonColor: Theme.of(context).cardColor,
                            controller: personalInformationViewModel.dateController,
                          ),
                          onTap: () {
                            onTapDeliveryPeriod(personalInformationViewModel);
                          }),
                      SizeConfig.CVerticalSpaceMedium(),
                      Text(
                        AppStrings.COUNTRY.tr(),
                        style: AppStyles.GrayStyleWithBold500_Font16(context),
                        textAlign: TextAlign.start,
                      ),
                      SizeConfig.verticalSpaceSmall(),
                      InkWell(
                        child: TextTextfieldWidget(
                          hint: '',
                          enabled: false,
                          radius: SizeConfig.introGetStarted_button_Radius,
                          buttonColor: Theme.of(context).cardColor,
                          controller: personalInformationViewModel.countryController,
                        ),
                        onTap: () {
                          BottomSheetViewForSearch()
                              .onImageClick(context, personalInformationViewModel.countryController, true, true);
                        },
                      ),
                      SizeConfig.CVerticalSpaceMedium(),
                      Text(
                        AppStrings.CITY.tr(),
                        style: AppStyles.GrayStyleWithBold500_Font16(context),
                        textAlign: TextAlign.start,
                      ),
                      SizeConfig.verticalSpaceSmall(),
                      InkWell(
                        child: TextTextfieldWidget(
                          enabled: false,
                          hint: '',
                          radius: SizeConfig.introGetStarted_button_Radius,
                          buttonColor: Theme.of(context).cardColor,
                          controller: personalInformationViewModel.cityController,
                        ),
                        onTap: () {
                          BottomSheetViewForSearch()
                              .onImageClick(context, personalInformationViewModel.cityController, true, false);
                        },
                      ),
                      SizeConfig.CVerticalSpaceMedium(),
                      Text(
                        AppStrings.TAX_IDENTIFICATION_NUMBER.tr(),
                        style: AppStyles.GrayStyle_Font16(context),
                        textAlign: TextAlign.start,
                      ),
                      SizeConfig.verticalSpaceSmall(),
                      TextTextfieldWidget(
                        hint: '',
                        radius: SizeConfig.introGetStarted_button_Radius,
                        buttonColor: Theme.of(context).cardColor,
                        controller: personalInformationViewModel.taxIdentificationController,
                      ),
                      widget.agentView
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizeConfig.CVerticalSpaceMedium(),
                                Text(
                                  AppStrings.COMPANY_NAME.tr(),
                                  style: AppStyles.GrayStyle_Font16(context),
                                  textAlign: TextAlign.start,
                                ),
                                SizeConfig.verticalSpaceSmall(),
                                TextTextfieldWidget(
                                  hint: '',
                                  radius: SizeConfig.introGetStarted_button_Radius,
                                  buttonColor: Theme.of(context).cardColor,
                                  controller: personalInformationViewModel.companyNameController,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizeConfig.CVerticalSpaceMedium(),
                                Text(
                                  AppStrings.COMPANY_EMAIL.tr(),
                                  style: AppStyles.GrayStyle_Font16(context),
                                  textAlign: TextAlign.start,
                                ),
                                SizeConfig.verticalSpaceSmall(),
                                TextTextfieldWidget(
                                  hint: '',
                                  radius: SizeConfig.introGetStarted_button_Radius,
                                  buttonColor: Theme.of(context).cardColor,
                                  controller: personalInformationViewModel.companyEmailController,
                                ),
                                SizeConfig.CVerticalSpaceMedium(),
                                Text(
                                  AppStrings.COUNTRY.tr(),
                                  style: AppStyles.GrayStyle_Font16(context),
                                  textAlign: TextAlign.start,
                                ),
                                SizeConfig.verticalSpaceSmall(),
                                InkWell(
                                  child: TextTextfieldWidget(
                                    hint: '',
                                    enabled: false,
                                    radius: SizeConfig.introGetStarted_button_Radius,
                                    buttonColor: Theme.of(context).cardColor,
                                  ),
                                  onTap: () {
                                    BottomSheetViewForSearch().onImageClick(
                                        context, personalInformationViewModel.countryController, true, true);
                                  },
                                ),
                                SizeConfig.CVerticalSpaceMedium(),
                                Text(
                                  AppStrings.CITY.tr(),
                                  style: AppStyles.GrayStyle_Font16(context),
                                  textAlign: TextAlign.start,
                                ),
                                SizeConfig.verticalSpaceSmall(),
                                InkWell(
                                  child: TextTextfieldWidget(
                                    enabled: false,
                                    hint: '',
                                    radius: SizeConfig.introGetStarted_button_Radius,
                                    buttonColor: Theme.of(context).cardColor,
                                  ),
                                  onTap: () {
                                    BottomSheetViewForSearch().onImageClick(
                                        context, personalInformationViewModel.cityController, true, false);
                                  },
                                ),
                                SizeConfig.CVerticalSpaceMedium(),
                                Text(
                                  AppStrings.STREET.tr(),
                                  style: AppStyles.GrayStyle_Font16(context),
                                  textAlign: TextAlign.start,
                                ),
                                SizeConfig.verticalSpaceSmall(),
                                TextTextfieldWidget(
                                  hint: '',
                                  radius: SizeConfig.introGetStarted_button_Radius,
                                  buttonColor: Theme.of(context).cardColor,
                                  controller: personalInformationViewModel.streetController,
                                ),
                              ],
                            )
                          : Container(),
                      SizeConfig.CVerticalSpaceMedium(),
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  void _optionsDialogBox(PersonalInformationViewModel personalInformationViewModel, BuildContext context) async {
    PlatformAlertDialog(
      title: AppStrings.GET_YOUR_IMAGE.tr(),
      content: '\n${AppStrings.SELECT_WHICH_IMAGE_OPTION_YOU_WANT_TO_CHOOSE.tr()}\n',
      defaultActionText: AppStrings.OPEN_CAMERA_DIALOG_TEXT.tr(),
      defaultFunction: personalInformationViewModel.openCamera,
      defaultActionText2: AppStrings.OPEN_GALLERY_DIALOG_TEXT.tr(),
      defaultFunction2: personalInformationViewModel.openGallery,
    ).show(context);
  }



  void onTapDeliveryPeriod(PersonalInformationViewModel orderInformationViewModel) {
    try {
      ShowBottomSheet.showLarge(
              child: CustomDatePickerWidget(
                enableAllDate: true,
                hasMinuteInterval: false,
                mode: CupertinoDatePickerMode.date,
                bottomText: AppStrings.YOUR.tr()+' '+AppStrings.DATE_OF_BIRTH.tr(),
                onSelect: (dateTime) {
                  if(dateTime!=null){

                    orderInformationViewModel.onSelectStartDate(dateTime, context);
                    orderInformationViewModel.navigatorPop();
                  }else{
                    if(orderInformationViewModel.startDate!=null){

                      orderInformationViewModel.onSelectStartDate(orderInformationViewModel.startDate, context);
                      orderInformationViewModel.navigatorPop();
                    }else{
                      orderInformationViewModel.dateController.clear();
                      orderInformationViewModel.navigatorPop();
                    }
                  }
                },
              ),
              context: context,
              heightFactor: .4);
    } catch (e) {
      print(e);
      if(orderInformationViewModel.startDate!=null){

        orderInformationViewModel.onSelectStartDate(orderInformationViewModel.startDate, context);
        orderInformationViewModel.navigatorPop();
      }else{
        orderInformationViewModel.dateController.clear();
        orderInformationViewModel.navigatorPop();
      }
    }
  }
}
