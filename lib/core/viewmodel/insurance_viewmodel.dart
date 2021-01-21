import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../ui/shared/MyUtils.dart';

class InsuranceViewModel extends BaseModel{

  bool insuranceValue=false;
  final _imagePicker = ImagePicker();

 TextEditingController insuranceNameController=TextEditingController();
 TextEditingController isuranceValueController=TextEditingController();
  void onChangeInsuranceValue(bool value){
    setState(ViewState.Busy);
    insuranceValue=value;
    setState(ViewState.Idle);
  }
  File imageFile;
  void navigatorPop() {
    navigationService.pop();
  }


  Future<bool> openCamera() async {
    try {
      final _image = await _imagePicker.getImage(source: ImageSource.camera,);
      imageFile =File(_image.path);

      navigatorPop();
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }

  Future<bool> openGallery() async {
    try {
      final _image = await _imagePicker.getImage(source: ImageSource.gallery);
      imageFile=File(_image.path);
      navigatorPop();
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }

}