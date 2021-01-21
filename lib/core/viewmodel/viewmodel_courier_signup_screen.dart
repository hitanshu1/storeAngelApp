import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/models/response_model.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/base_api.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/screens/courier/payment_method_screen.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class CourierSignUpViewModel extends BaseModel{
  final _imagePicker = ImagePicker();
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }

  File _imageFile;
  File get imageFile =>_imageFile;

  Future<bool> openCamera() async {
    try {
      final _image = await _imagePicker.getImage(source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front
      );
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
  void onSkipVerification(UserModel user)async{
    setState(ViewState.Busy);
    ResponseModel response=await database.onUpdateVerifyField(1, user);
    if(response.status==1){
      navigateToScreen(PaymentMethodScreen.routeName,);
    }else{
      MyUtils().toastdisplay(response.message);
    }
    setState(ViewState.Idle);
  }
}