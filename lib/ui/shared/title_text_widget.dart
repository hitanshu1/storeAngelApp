import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';

class TitleTextWidget extends StatelessWidget {
  final String title;
  final Color color;
  TitleTextWidget({@required this.title,this.color});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizeConfig.verticalSpaceSmall(),
        Text(title,style: color!=null?AppStyles.BlackStyleFont_20(context).copyWith(
            fontWeight: FontWeight.w300,
          color: color
        ):AppStyles.BlackStyleFont_20(context).copyWith(
          fontWeight: FontWeight.w300
        ),),
        SizeConfig.verticalSpaceSmall(),
        Container(
          height: 1,
          width: SizeConfig.screenWidth*.1,
          color: color!=null?color:Provider.of<AppThemeViewModel>(context).themeData == AppTheme.dark
    ? AppColors.backgroundColor
        : AppColors.darkGrayLittleColor),

      ],
    );
  }
}
