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
import 'package:storeangelApp/core/viewmodel/signupDetails_viewmodel.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';

import 'package:storeangelApp/ui/shared/platform_alert_dialog.dart';
import 'package:storeangelApp/ui/widgets/login/signup_round_button_widget.dart';
import 'package:storeangelApp/ui/widgets/signup/first_lastname_widget.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SignUpDetailsScreen extends StatefulWidget {
  static const String routeName = 'signUp';

  @override
  _SignUpDetailsScreenState createState() => _SignUpDetailsScreenState();
}

class _SignUpDetailsScreenState extends State<SignUpDetailsScreen> {
  final ScrollController _scrollController = ScrollController();

  String dropdownValue = "London";

  final textFirstNameController = TextEditingController();
  final textLastNameController = TextEditingController();
  var birthDateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  final _firstNameFocusNode = FocusNode();
  final _secondNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    textFirstNameController.dispose();
    textLastNameController.dispose();
    birthDateController.dispose();
    _firstNameFocusNode.dispose();
    _secondNameFocusNode.dispose();
    _scrollController.dispose();
  }
  DateTime selectedDate=DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950),
        lastDate:  DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        birthDateController.text=AppConstants().pickDate(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.sizeConfigInit(context);
    final user = Provider.of<UserModel>(context);
    StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    return BaseView<SignUpDetailsViewModel>(
      onModelReady: (signUpDetailsViewModel)=>signUpDetailsViewModel.initialize(_scrollController),
      builder: (context, signUpDetailsViewModel, child) {
        return Scaffold(
//          appBar: CustomAppBar(
//            elevation:signUpDetailsViewModel.hasShadow?4:0,
//            title: Text(
//              '',
//              style: AppStyles.BlackStyleWithBold800Font_24(context),
//            ),
//            leading: BackButton(
//              color: Theme.of(context).iconTheme.color,
//            ),
//            backgroundColor: Theme.of(context).backgroundColor,
//          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
//                    Container(
//                      width: SizeConfig.screenWidth,
//                      padding: SizeConfig.sidelargepadding,
//                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
//                        Consumer<SignUpDetailsViewModel>(
//                          builder: (context, model, child) => model.state == ViewState.Busy
//                              ? CircleAvatar(
//                                  child: AppConstants.circulerProgressIndicator(),
//                                  radius: SizeConfig.smallImageHeight55,
//                                )
//                              : PhotoWidget(
//                                  colorButton: Theme.of(context).primaryColorLight,
//                                  imageFile: model.imageFile,
//                                  radius: SizeConfig.smallImageHeight55,
//                                  onTap: () {
//                                    _optionsDialogBox(model, context);
//                                  },
//                                ),
//                        ),
//                        SizeConfig.VerticalSpaceSmallMedium(),
//                        InkWell(
//                          onTap: () {
//                            _optionsDialogBox(signUpDetailsViewModel, context);
//                          },
//                          child: Text(
//                            AppStrings.ADD_YOUR_PHOTO.tr(),
//                            style: AppStyles.BlackStyleFont_20(context),
//                            textAlign: TextAlign.center,
//                          ),
//                        ),
//                      ]),
//                    ),
                    AppHeader(
                      isBack: true,
                      height: SizeConfig.smallHeaderSize,
                      title:AppStrings.TELL_US_ABOUT_YOUR_SELFE.tr() ,
                    ),
                    SizeConfig.verticalSpaceBig(),
                    Center(
                      child: AutoSizeText(
                        AppStrings.SIGNUP.tr(),
                        style: AppStyles.GrayStyleFontWeight500_d24(context),
                        minFontSize: 10,
                        stepGranularity: 1,
                        maxFontSize: SizeConfig.fontSizeLargestBig,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
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
                            hint: AppStrings.FIRST_NAME.tr(),
                            radius: SizeConfig.radiusSmaller,
                            buttonColor: Theme.of(context).cardColor,
                            controller: textFirstNameController,
                            focusNode: _firstNameFocusNode,
                            nextFocusNode: _secondNameFocusNode,
                            textInputAction: TextInputAction.next,
                          ),
                          SizeConfig.verticalSpaceSmall(),
                          TextTextfieldWidget(
                            hint: AppStrings.SECOND_NAME.tr(),
                            radius: SizeConfig.radiusSmaller,
                            buttonColor: Theme.of(context).cardColor,
                            controller: textLastNameController,
                            focusNode: _secondNameFocusNode,
                          ),
//                          SizeConfig.verticalSpaceSmall(),

//                          InkWell(
//                            child: TextTextfieldWidget(
//                                enabled: false,
//                                hint: AppStrings.LOCATION.tr(),
//                                radius: SizeConfig.radiusSmaller,
//                                buttonColor: Theme.of(context).cardColor,
//                                controller: cityController,
//                                suffixWidget: Padding(
//                                  padding: SizeConfig.innersidepadding,
//                                  child: Icon(
//                                    Icons.expand_more,
//                                    size: SizeConfig.iconSize,
//                                  ),
//                                )),
//                            onTap: () {
//                              BottomSheetViewForSearch().onImageClick(context, cityController, true, false);
//                            },
//                          ),
                          SizeConfig.verticalSpace(SizeConfig.screenHeight * 0.02),

                          InkWell(
                            child: TextTextfieldWidget(
                              hint: AppStrings.DATE_OF_BIRTH.tr(),
                              radius: SizeConfig.radiusSmaller,
                              buttonColor: Theme.of(context).cardColor,
                              controller: birthDateController,
                              enabled: false,
                            ),
                            onTap: (){
                              _selectDate(context);
                            },
                          ),

                          SizeConfig.verticalSpaceBigMedium(),

                          SignInRoundButtonWidget(
                            name: AppStrings.SIGN_IN.tr(),
                            radius: SizeConfig.introGetStarted_button_Radius,
                            buttonColor: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            fontSize: SizeConfig.fontSizeMedium,
                            onTap: () async {
                              signUpDetailsViewModel.signUp(
                                  firstname: textFirstNameController.text,
                                  lastname: textLastNameController.text,
                                  date: birthDateController.text,
                                  usertype: dropdownValue,
                                  city: cityController.text,
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
                visible: signUpDetailsViewModel.state == ViewState.Busy,
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

  void _optionsDialogBox(SignUpDetailsViewModel model, BuildContext context) async {
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
