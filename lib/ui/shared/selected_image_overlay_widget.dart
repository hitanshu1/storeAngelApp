import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class SelectedImageOverlayWidget extends StatelessWidget {
  final String title,subTitle;
  final double radius;
  final Function onTap;
  SelectedImageOverlayWidget({this.radius,@required this.title,@required this.subTitle,this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsPath.cirlerTickGray),
          SizeConfig.verticalSpaceMedium(),
          Text(title,
            style: AppStyles.WhiteStyle_Font16,),
          SizeConfig.verticalSpaceSmall(),
          InkWell(child: Text(subTitle,style: AppStyles.WhiteStyle_Font16,),
          onTap: onTap,)
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.5),
          borderRadius: BorderRadius.circular(radius!=null?radius:SizeConfig.borderRadius)
      ),
    );
  }
}
