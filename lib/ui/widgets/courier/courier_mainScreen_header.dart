import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class CourierMainScreenHeader extends StatelessWidget {
  final String headerText;
  final String description;
  final double elevation;

  const CourierMainScreenHeader({Key key, @required this.headerText, this.description, this.elevation}) :assert(headerText!=null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Material(
        color: Theme.of(context).backgroundColor,
        elevation: elevation??0,
        child: Padding(
          padding: SizeConfig.sidepadding,
          child: Padding(
            padding: SizeConfig.sidepadding.copyWith(bottom: SizeConfig.screenHeight*.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizeConfig.CVerticalSpace60(),
                Text(headerText, style: AppStyles.GreenStyleWithBoldFont_C20(context),),
                Text(description??'',
                  style: AppStyles.BlackStyleFont_20(context).copyWith(height: 1.8, letterSpacing: 0.2),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
