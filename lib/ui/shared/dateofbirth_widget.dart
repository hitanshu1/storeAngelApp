import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class DateOfBirthWidget extends StatelessWidget {
  final Function onTap;
  final TextEditingController controller;
  DateOfBirthWidget({this.controller,this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: SizeConfig.screenHeight * 0.07,
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.03,
          right: SizeConfig.screenWidth * 0.03,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(SizeConfig.introGetStarted_button_Radius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(AppConstants.ShadowBox_WithOpacity),
              spreadRadius: AppConstants.ShadowBox_SpreadRadius,
              blurRadius: AppConstants.ShadowBox_BlurRadius,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: IgnorePointer(
            child:  TextFormField(
              controller: controller,
              style: TextStyle(
                fontSize: SizeConfig.fontSizeMedium,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                labelStyle: TextStyle(color: Colors.grey),
                errorStyle: TextStyle(color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value == '') {
                  return "Enter Birth Date";
                }else{
                  return null;
                }
              },
              onChanged: (text) {

              },
            ),
          ),
        ),
      ),
    );
  }
}
