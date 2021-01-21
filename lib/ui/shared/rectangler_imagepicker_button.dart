import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class RectangularImagePickerButton extends StatelessWidget {
  final double height,width,radius;
  final Color color;
  final Function onTap;
  final String  title;
  RectangularImagePickerButton({this.width,this.height,this.radius:20,this.color,this.onTap,this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height!=null?height:80,
        width: width!=null?width:SizeConfig.screenWidth,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(radius))
        ),
        child: title!=null?Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsPath.small_cemara),
            SizeConfig.CVerticalSpacevEMedium(),
            Text(title,style: AppStyles.BlackStyleFont_20(context),),

          ],
        ):Center(
      child: Image.asset(AssetsPath.small_cemara),
         ),
      ),
    );
  }
}
