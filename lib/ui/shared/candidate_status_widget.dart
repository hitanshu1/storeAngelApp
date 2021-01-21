import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class CandidateStatusWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool active;
  CandidateStatusWidget({@required this.active,@required this.title,
    @required this.iconData});
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: active?1:.5,
      child: Row(
        children: [

          Container(child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(iconData,color: AppColors.whiteColor,
              size: 10,),
          ),decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active?AppColors.primaryColor:AppColors.grayFont
          ),),

          Text(' '+title,style: active?AppStyles.GreenStyle_Font16(context):AppStyles.GrayStyle_Font16(context),)
        ],
      ),
    );
  }
}
