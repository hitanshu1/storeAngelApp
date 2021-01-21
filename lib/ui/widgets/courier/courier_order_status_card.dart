import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class CourierOrderStatusCard extends StatelessWidget {
  final String statusImage;
  final String title,subtitle;
  CourierOrderStatusCard({@required this.title,@required this.subtitle,@required this.statusImage});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConfig.sidepadding,
      child: Container(
        height: SizeConfig.orderStatusContainerheight,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppConstants.button_Radius)
        ),
        child: Column(
          children: [
            SizeConfig.CVerticalSpaceBig(),
            Container(
              height: 60,
              width: 60,
              child: Center(
                child: Image.asset(statusImage,
                ),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.whiteColor
              ),
            ),
            SizeConfig.CVerticalSpaceMedium(),
            SizedBox(
              width: SizeConfig.screenWidth*.7,
                child: Text(title,style: AppStyles.GreenStyleWithBoldFont_24(context),textAlign: TextAlign.center,)),
            SizeConfig.CVerticalSpaceMedium(),
            SizedBox(
              width: SizeConfig.screenWidth*.76,
              child: Text(subtitle,
                style: AppStyles.BlackStyleFont_20(context),textAlign: TextAlign.center,),
            ),

          ],
        ),
      ),
    );
  }
}
