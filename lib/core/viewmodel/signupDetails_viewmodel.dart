import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/enums/user_type.dart';
import 'package:storeangelApp/core/models/response_model.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/screens/consumer/checkingAcceptedEmail_Screen.dart';
import 'package:storeangelApp/ui/screens/courier/tell_us_about_your_company_screen.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class SignUpDetailsViewModel extends BaseModel {
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  final _imagePicker = ImagePicker();
  var _formatter = DateFormat.yMMMMd('en_US');
  bool hasShadow = false;
  ScrollController scrollController;

  void navigatorPop() {
    navigationService.pop();
  }

  File _imageFile;
  File get imageFile =>_imageFile;

  Future<bool> openCamera() async {
    try {
      final _image = await _imagePicker.getImage(source: ImageSource.camera);
      _imageFile = File(_image.path);
      navigatorPop();
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }

  Future<bool> openGallery() async {
    setState(ViewState.Busy);
    try {
      final _image = await _imagePicker.getImage(source: ImageSource.gallery);
      _imageFile = File(_image.path);
      navigatorPop();
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      setState(ViewState.Idle);
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }

  DateTime _pickedDateTime;
  DateTime get pickedDateTime =>_pickedDateTime;


  String pickDate(DateTime picked) {
    if (picked != null) {
      _pickedDateTime = picked;
      String formatted = _formatter.format(_pickedDateTime);
      setState(ViewState.Idle);
      return formatted;
    }return '';
  }

  Future signUp({
    @required String firstname,
    @required String lastname,
    @required String date,
    @required String usertype,
    @required String city,
    @required UserModel user
  }) async {
    setState(ViewState.Busy);

    if (!MyUtils().validationFirstName(firstname)) {
      setState(ViewState.Idle);
      return false;
    }

    if (!MyUtils().validationLastName(lastname)) {
      setState(ViewState.Idle);
      return false;
    }

    if (!MyUtils().validationDate(date)) {
      setState(ViewState.Idle);
      return false;
    }

    if (!MyUtils().validationUserType(usertype)) {
      setState(ViewState.Idle);
      return false;
    }
    UserModel _user=user;
    _user.userName='$firstname $lastname';
    _user.city=city;
    _user.firstName=firstname;
    _user.lastName=lastname;
    ResponseModel response=await database.saveUser(_user);
    if(response.status==1){
      setState(ViewState.Idle);
      if(AppConstants.userType==UserType.Customer){
        navigationService.navigateReplaceTo(CheckingAcceptedEmailScreen.routeName);
      }else{
        navigationService.navigateReplaceTo(TellUsAboutYourCompanyScreen.routeName);
      }

    }else{
      setState(ViewState.Idle);
      MyUtils().toastdisplay(response.message);
    }

  }


  void addScrollListener(){
    if(scrollController.position.pixels==0){
      hasShadow = false;
    }else{
      hasShadow = true;
    }
    setState(ViewState.Idle);
  }

  void initialize(ScrollController scrollController){
    Future.delayed(Duration.zero,(){
      this.scrollController = scrollController;
      this.scrollController.addListener(addScrollListener);
    });
  }
}
