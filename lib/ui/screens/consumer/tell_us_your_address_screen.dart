import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_tell_us_your_address.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/bottomsheet_search_view.dart';

import 'package:storeangelApp/ui/shared/platform_alert_dialog.dart';
import 'package:storeangelApp/ui/widgets/login/signup_round_button_widget.dart';
import 'package:storeangelApp/ui/widgets/signup/first_lastname_widget.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/widgets/signup/photo_widget.dart';

class TellUsYourAddressScreen extends StatefulWidget {
  static const String routeName = 'tellUsYourAddressScreen';

  @override
  _TellUsYourAddressScreenState createState() => _TellUsYourAddressScreenState();
}

class _TellUsYourAddressScreenState extends State<TellUsYourAddressScreen> {
  final ScrollController _scrollController = ScrollController();

  String dropdownValue = "London";

  final streetController = TextEditingController();
  final zipController = TextEditingController();
  var cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  final streetFocusNode = FocusNode();
  final zipFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    streetController.dispose();
    zipController.dispose();
    cityController.dispose();
    countryController.dispose();
    streetFocusNode.dispose();
    zipFocusNode.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig.sizeConfigInit(context);
    final user = Provider.of<UserModel>(context);
    StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    return BaseView<TellUsYourAddressViewModel>(
      onModelReady: (tellUsYourAddressViewModel)=>tellUsYourAddressViewModel.initialize(_scrollController),
      builder: (context, tellUsYourAddressViewModel, child) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    AppHeader(
                      isBack: true,
                      height: SizeConfig.smallHeaderSize,
                      title:AppStrings.TELL_US_YOUR_ADDRESS.tr() ,
                    ),
                    SizeConfig.verticalSpaceMedium(),
                    Container(
                      width: SizeConfig.screenWidth,
                      padding: SizeConfig.sidelargepadding,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                        Consumer<TellUsYourAddressViewModel>(
                          builder: (context, model, child) => model.state == ViewState.Busy
                              ? CircleAvatar(
                                  child: AppConstants.circulerProgressIndicator(),
                                  radius: SizeConfig.smallImageHeight55,
                                )
                              : PhotoWidget(
                                  colorButton: Theme.of(context).cardColor,
                                  imageFile: model.imageFile,
                                  radius: SizeConfig.smallImageHeight55,
                                  onTap: () {
                                    _optionsDialogBox(model, context);
                                  },
                                ),
                        ),
                        SizeConfig.VerticalSpaceSmallMedium(),
                        InkWell(
                          onTap: () {
                            _optionsDialogBox(tellUsYourAddressViewModel, context);
                          },
                          child: Text(
                            AppStrings.ADD_YOUR_PHOTO.tr(),
                            style: AppStyles.BlackStyleFont_20(context),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                    ),
                    SizeConfig.verticalSpaceMedium(),
                    Container(
                      width: SizeConfig.screenWidth,
                      padding: SizeConfig.sidelargepadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizeConfig.verticalSpaceMedium(),
                          TextTextfieldWidget(
                            hint: AppStrings.STREET.tr(),
                            radius: SizeConfig.radiusSmaller,
                            buttonColor: Theme.of(context).cardColor,
                            controller: streetController,
                            focusNode: streetFocusNode,
                            nextFocusNode: zipFocusNode,
                            textInputAction: TextInputAction.next,
                          ),
                          SizeConfig.verticalSpaceSmall(),
                          TextTextfieldWidget(
                            hint: AppStrings.ZIP.tr(),
                            radius: SizeConfig.radiusSmaller,
                            buttonColor: Theme.of(context).cardColor,
                            controller: zipController,
                            focusNode: zipFocusNode,
                          ),
                          SizeConfig.verticalSpaceSmall(),
                          TextTextfieldWidget(
                            hint: AppStrings.CITY.tr(),
                            radius: SizeConfig.radiusSmaller,
                            buttonColor: Theme.of(context).cardColor,
                            controller: cityController,
                          ),
                          SizeConfig.verticalSpaceSmall(),
                          InkWell(
                            child: TextTextfieldWidget(
                              hint: AppStrings.COUNTRY.tr(),
                              radius: SizeConfig.radiusSmaller,
                              enabled: false,
                              buttonColor: Theme.of(context).cardColor,
                              controller: countryController,
                            ),
                            onTap: (){
                              BottomSheetViewForSearch().onImageClick(context, countryController, true,true);
                            },
                          ),

                          SizeConfig.verticalSpaceBigMedium(),

                          SignInRoundButtonWidget(
                            name: AppStrings.NEXT.tr(),
                            radius: SizeConfig.introGetStarted_button_Radius,
                            buttonColor: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            fontSize: SizeConfig.fontSizeMedium,
                            onTap: () async {
                              tellUsYourAddressViewModel.onNext(
                                  street: streetController.text,
                                  zip: zipController.text,
                                  city: cityController.text,
                                  country: countryController.text,
                                  user: user);
                            },
                          ),
                          SizeConfig.verticalSpaceLarge(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: tellUsYourAddressViewModel.state == ViewState.Busy,
                child: new Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  color: Colors.transparent,
                  child: Center(child: new CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _optionsDialogBox(TellUsYourAddressViewModel model, BuildContext context) async {
    PlatformAlertDialog(
      title: AppStrings.GET_YOUR_IMAGE.tr(),
      content: '\n${AppStrings.SELECT_WHICH_IMAGE_OPTION_YOU_WANT_TO_CHOOSE.tr()}\n',
      defaultActionText: AppStrings.OPEN_CAMERA_DIALOG_TEXT.tr(),
      defaultFunction: model.openCamera,
      defaultActionText2: AppStrings.OPEN_GALLERY_DIALOG_TEXT.tr(),
      defaultFunction2: model.openGallery,
    ).show(context);
  }
}
