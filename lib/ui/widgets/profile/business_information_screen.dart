import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_business_information.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/bottomsheet_search_view.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/platform_alert_dialog.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/profile/profile_rating.dart';
import 'package:storeangelApp/ui/widgets/signup/first_lastname_widget.dart';
class BusinessInformation extends StatefulWidget {

  @override
  _BusinessInformationState createState() => _BusinessInformationState();
}

class _BusinessInformationState extends State<BusinessInformation> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray,context);
    final profileModel=Provider.of<ProfileViewModel>(context);
    return BaseView<BusinessInformationViewModel>(
      onModelReady: (businessViewModel)=>businessViewModel.initialize(_scrollController),
      builder:(context, businessViewModel, child)=> Scaffold(
        appBar: CustomAppBar(
          elevation: businessViewModel.hasShadow?4:0,
          leading:
          BackButton(
            color: Theme.of(context).iconTheme.color,
            onPressed: (){
              profileModel.changeView(ProfilePageView.home);
            },
          ),
          title: Text(AppStrings.BUSINESS_INFORMATION.tr(),
            style: AppStyles.BlackStyleWithBold800Font_24(context),
            textAlign: TextAlign.center,),
        ),
        body: Builder(
          builder: (context){
            if(businessViewModel.state==ViewState.Busy){
              return AppConstants.circulerProgressIndicator();
            }else{
              return Padding(
                padding: SizeConfig.padding,
                child: ListView(
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    Center(
                      child: InkWell(
                        child: ViewAppImage(
                          height: SizeConfig.screenWidth*.3,
                          width: SizeConfig.screenWidth*.3,
                          radius: 100,
                          fileImage: businessViewModel.imageFile,
                          boxFit: BoxFit.scaleDown,
                          state: businessViewModel.state,
                        ),
                        onTap: (){
                          _optionsDialogBox(businessViewModel, context);
                        },
                      ),
                    ),
                    SizeConfig.verticalSpaceMedium(),
                    ProfileRating(
                      initialRating: 4.5,
                      ratingAverage: 4.5,
                      ratingCount: 10,
                    ),
                    SizeConfig.verticalSpaceMedium(),
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
                      controller: businessViewModel.companyNameController,
                      focusNode: businessViewModel.firstNameFocusNode,
                      nextFocusNode: businessViewModel.secondNameFocusNode,
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
                      controller: businessViewModel.companyEmailController,
                      focusNode: businessViewModel.secondNameFocusNode,
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
                      controller: businessViewModel.taxIdentificationController,
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
                        controller: businessViewModel.countryController,
                      ),
                      onTap: (){
                        BottomSheetViewForSearch().onImageClick(context, businessViewModel.countryController, true,true);
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
                        controller: businessViewModel.cityController,
                      ),
                      onTap: (){
                        BottomSheetViewForSearch().onImageClick(context, businessViewModel.cityController, true,false);
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
                      controller: businessViewModel.streetController,
                    ),



                  ],
                ),
              );
            }
          },
        ),

      ),
    );
  }

  void _optionsDialogBox(BusinessInformationViewModel businessViewModel, BuildContext context) async {
    PlatformAlertDialog(
      title: AppStrings.GET_YOUR_IMAGE.tr(),
      content: '\n${AppStrings.SELECT_WHICH_IMAGE_OPTION_YOU_WANT_TO_CHOOSE.tr()}\n',
      defaultActionText: AppStrings.OPEN_CAMERA_DIALOG_TEXT.tr(),
      defaultFunction: businessViewModel.openCamera,
      defaultActionText2: AppStrings.OPEN_GALLERY_DIALOG_TEXT.tr(),
      defaultFunction2: businessViewModel.openGallery,
    ).show(context);
  }
}
