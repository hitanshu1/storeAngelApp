import 'dart:io';

import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class PhotoWidget extends StatelessWidget {

  final Color colorButton;
  final double radius;
  final Color textColor;
  final double fontSize;
  final GestureTapCallback onTap;
  final File imageFile;


  PhotoWidget({
      this.colorButton,
      this.radius,
      this.textColor,
      this.fontSize,
      @required this.onTap,
      this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.grayFont.withOpacity(.5), spreadRadius: 5)],
            ),

            child: CircleAvatar(
              backgroundColor: colorButton??Colors.black,
              backgroundImage: imageFile!=null?FileImage(imageFile):null,
            child: Image.asset(AssetsPath.camera),
              radius: radius!=null?radius:SizeConfig.screenWidth*.15,
            ),
          ),
        ),
      ],
    );
  }
}
