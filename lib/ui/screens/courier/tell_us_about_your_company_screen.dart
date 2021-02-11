import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_tell_us_about_your_company.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/bottomsheet_search_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/widgets/signup/first_lastname_widget.dart';
class TellUsAboutYourCompanyScreen extends StatefulWidget {
  static const String routeName = 'tellUuAboutYourCompany';

  @override
  _TellUsAboutYourCompanyScreenState createState() => _TellUsAboutYourCompanyScreenState();
}

class _TellUsAboutYourCompanyScreenState extends State<TellUsAboutYourCompanyScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<TellUsAboutYourCompanyViewModel>(
      onModelReady: (tellUsAboutYourCompanyViewModel)=>tellUsAboutYourCompanyViewModel.initialize(_scrollController),
      onModelDisposed: (tellUsAboutYourCompanyViewModel)=>tellUsAboutYourCompanyViewModel.disposeController(),
      builder: (context,tellUsAboutYourCompanyViewModel,child){
        return Scaffold(
          appBar: CustomAppBar(
            title: Text(
              AppStrings.TELL_US_ABOUT_YOUR_COMPANY.tr(),
              style: AppStyles.BlackStyleWithBold800Font_24(context),
            ),
            leading: BackButton(
              color: Theme.of(context).iconTheme.color,
              onPressed: (){

              },
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: tellUsAboutYourCompanyViewModel.hasShadow?4:0,
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: SizeConfig.sidelargepadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizeConfig.verticalSpaceSmall(),
                  Text(AppStrings.OPTIONAL.tr(),style: AppStyles.BlackStyleWithBold800Font_20(context),),
                  SizeConfig.VerticalSpaceSmallMedium(),
                  Text(
                    AppStrings.COMPANY_NAME.tr(),
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.start,
                  ),
                  SizeConfig.CVerticalSpaceSmallMediumC12(),
                  TextTextfieldWidget(
                    hint: '',
                    radius: SizeConfig.introGetStarted_button_Radius,
                    buttonColor: Theme.of(context).cardColor,
                    controller: tellUsAboutYourCompanyViewModel.companyNameController,
                    textInputAction: TextInputAction.next,
                  ),
                  SizeConfig.VerticalSpaceSmallMedium(),
                  Text(
                    AppStrings.COMPANY_EMAIL.tr(),
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.start,
                  ),
                  SizeConfig.CVerticalSpaceSmallMediumC12(),
                  TextTextfieldWidget(
                    hint: '',
                    radius: SizeConfig.introGetStarted_button_Radius,
                    buttonColor: Theme.of(context).cardColor,
                    controller: tellUsAboutYourCompanyViewModel.companyEmailController,
                    textInputAction: TextInputAction.next,
                  ),
                  SizeConfig.VerticalSpaceSmallMedium(),
                  Text(
                    AppStrings.TAX_IDENTIFICATION_NUMBER.tr(),
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.start,
                  ),
                  SizeConfig.CVerticalSpaceSmallMediumC12(),
                  TextTextfieldWidget(
                    hint: '',
                    radius: SizeConfig.introGetStarted_button_Radius,
                    buttonColor: Theme.of(context).cardColor,
                    controller: tellUsAboutYourCompanyViewModel.taxIdentificationController,
                    textInputAction: TextInputAction.next,
                  ),
                  SizeConfig.VerticalSpaceSmallMedium(),
                  Text(
                    AppStrings.COUNTRY.tr(),
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.start,
                  ),
                  SizeConfig.CVerticalSpaceSmallMediumC12(),
                  InkWell(
                    child: TextTextfieldWidget(
                      hint: '',
                      enabled: false,
                      radius: SizeConfig.introGetStarted_button_Radius,
                      buttonColor: Theme.of(context).cardColor,
                      controller: tellUsAboutYourCompanyViewModel.countryController,
                    ),
                    onTap: (){
                      BottomSheetViewForSearch().onImageClick(context, tellUsAboutYourCompanyViewModel.countryController, true,true);
                    },
                  ),
                  SizeConfig.VerticalSpaceSmallMedium(),
                  Text(
                    AppStrings.CITY.tr(),
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.start,
                  ),
                  SizeConfig.CVerticalSpaceSmallMediumC12(),
                  InkWell(
                    child: TextTextfieldWidget(
                      enabled: false,
                      hint: '',
                      radius: SizeConfig.introGetStarted_button_Radius,
                      buttonColor: Theme.of(context).cardColor,
                      controller: tellUsAboutYourCompanyViewModel.cityController,
                    ),
                    onTap: (){
                      BottomSheetViewForSearch().onImageClick(context, tellUsAboutYourCompanyViewModel.cityController, true,false);
                    },
                  ),
                  SizeConfig.VerticalSpaceSmallMedium(),
                  Text(
                    AppStrings.STREET.tr(),
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.start,
                  ),
                  SizeConfig.CVerticalSpaceSmallMediumC12(),
                  TextTextfieldWidget(
                    hint: '',
                    radius: SizeConfig.introGetStarted_button_Radius,
                    buttonColor: Theme.of(context).cardColor,
                    controller: tellUsAboutYourCompanyViewModel.streetController,
                    textInputAction: TextInputAction.next,
                  ),
                  SizeConfig.verticalSpaceBigMedium(),
                  ButtonWidget(

                    buttonText: AppStrings.NEXT.tr(),
                    buttonColor: Theme.of(context).primaryColor,
                    fontSize: SizeConfig.screenHeight * .02,
                    radius: SizeConfig.introGetStarted_button_Radius,
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      tellUsAboutYourCompanyViewModel.onPressNext();
                    },
                  ),
                  SizeConfig.verticalSpaceLarge(),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
