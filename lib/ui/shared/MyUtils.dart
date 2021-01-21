import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';

class MyUtils
{

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF0000FF);
  }

  void toastdisplay(String message, {Toast toastLength}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength??Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  void toastsuccessdisplay(String message, {Toast toastLength}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength?? Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

        timeInSecForIosWeb: 2,
        backgroundColor: AppColors.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }



  bool validatePassword(String value) {
    /*Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{2,}$';*/
    // RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      toastdisplay(AppStrings.VALIDATION_PASSWORD_ERROR_MSG.tr());
      return false;
    }
    return true;
  }

  bool MatchPassword(String password,String Conformpwd) {
    /*Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{2,}$';*/
    // RegExp regex = new RegExp(pattern);
    if (Conformpwd.isEmpty) {
      toastdisplay(AppStrings.VALIDATION_CONFIRM_PASSWORD_ERROR_MSG.tr());
      return false;
    } else {
      if (password != Conformpwd) {

        toastdisplay(AppStrings.VALIDATION_CONFIRM_PASSWORD_NOT_MAtch_ERROR_MSG.tr());
        return false;
      }
    }

    return true;
  }



  bool validateEmail(String value) {
    value = value.trim();
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (value.isEmpty) {
      toastdisplay(AppStrings.VALIDATION_EMAIL_EMPTY_ERROR_MSG.tr());
      return false;
    } else {
      if (!regex.hasMatch(value)) {
        toastdisplay(AppStrings.VALIDATION_EMAIL_VALID_ERROR_MSG.tr());
        return false;
      }
    }

    return true;
  }

  bool validationFirstName(String firstname) {

    if (firstname.isEmpty) {
      toastdisplay(AppStrings.VALIDATION_FIRSTNAME_ERROR_MSG.tr());
      return false;
    }
    return true;
  }

  bool validationLastName(String lastname) {

    if (lastname.isEmpty) {
      toastdisplay(AppStrings.VALIDATION_LASTNAME_ERROR_MSG.tr());
      return false;
    }
    return true;
  }

  bool validationDate(String date) {

    if (date.isEmpty) {
      toastdisplay(AppStrings.VALIDATION_DATE_ERROR_MSG.tr());
      return false;
    }
    return true;
  }

  bool validationUserType(String usertype) {

    if (usertype==null || usertype=="") {
      toastdisplay(AppStrings.VALIDATION_USERTYPE_ERROR_MSG.tr());
      return false;
    }
    return true;
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
  static String stringValidator(String value, String controllerName) {
    if (value.isEmpty) {
      return "$controllerName cannot be empty";
    }else if(value=='notvalid'){
      return 'Please enter valid $controllerName';
    }
    return null;
  }
  static Future<void> showAppDialog({context,Widget child}) {
    showDialog(context: context, child: Dialog(
      backgroundColor: Theme.of(context).cardColor,
      child: child,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppConstants.button_Radius))),

    ));
  }


}