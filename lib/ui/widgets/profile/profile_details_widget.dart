import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/user.dart';

class ProfileDetailsWidget extends StatelessWidget {
  final UserModel user;
  ProfileDetailsWidget({this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(user?.name,style: AppStyles.BlackStyleWithBold800Font_20(context),),
          SizeConfig.verticalSpaceVeryGap(),
          Text(user.addressLinen,style: AppStyles.BlackStyle_Font16(context),),
        ],
      ),
    );
  }
}
