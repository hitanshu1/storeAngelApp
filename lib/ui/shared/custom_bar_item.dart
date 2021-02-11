import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
class CustomBarItemWidget extends StatelessWidget {
  final Function onTap;
  final bool active;
  final String title;
  final IconData icon;
  CustomBarItemWidget({@required this.onTap,@required this.active,@required this.title,
    @required this.icon});

  Widget _customIcon(IconData icon,bool active,BuildContext context) {

    return Padding(
        padding: EdgeInsets.only(top: SizeConfig.screenHeight * .008, bottom: SizeConfig.screenHeight * .003),
        child: Icon(
          icon,color: active?AppColors.whiteColor:Theme.of(context).focusColor,
          size: 28,
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(child: InkWell(
      onTap: onTap,
      child: Container(
        color: active?AppColors.primaryColor:Theme.of(context).primaryColorLight,
        child: Padding(
          padding: SizeConfig.bottomBarPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _customIcon(icon,active,context),
              SizeConfig.verticalSpaceSmall(),
              Text(title,style: active?AppStyles.WhiteStyle_Font16:
              AppStyles.BlackStyleFont_16(context),)
            ],
          ),
        ),
      ),
    ));
  }
}
