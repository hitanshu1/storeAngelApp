import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class OrderAcceptedWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final EdgeInsets padding;
  final TextStyle titleStyle, subtitleStyle;
  final double imageHeight;

  OrderAcceptedWidget({this.title, this.subtitle, this.padding, this.subtitleStyle, this.titleStyle, this.imageHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:SizeConfig.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleStyle != null ? titleStyle : AppStyles.GreenStyleWithBoldFont_24(context),
            ),
            SizeConfig.CVerticalSpaceSmallMedium(),
            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: subtitleStyle != null ? subtitleStyle : AppStyles.BlackStyleWithBold500_Font16(context),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: AppColors.green),
          borderRadius: BorderRadius.circular(AppConstants.ContainerMediumRoundCorner_Radius)),
    );
  }
}
