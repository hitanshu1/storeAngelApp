import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/models/response_model.dart';
import 'package:storeangelApp/core/services/auth_service.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class ForgotPasswordViewModel extends BaseModel{

  AuthBase auth = getIt<Auth>();

  TextEditingController emailController=TextEditingController();
  TextEditingController newPasswordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();

  Future<bool> forgotPassword()async{
    setState(ViewState.Busy);
    ResponseModel responseModel=await auth.forgotUserPassword(emailController.text);
    setState(ViewState.Idle);
    if(responseModel.status!=1){
      throw (responseModel.message);
    }
    return true;
  }
}