import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class ProfileOptionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool borderColor;
  final Function onTap;
  ProfileOptionWidget({this.title,this.borderColor:true,this.icon,this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
        child: Container(
          child: Padding(
            padding: SizeConfig.cmediumPadding,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: SizeConfig.tabIconSize,
                ),
                SizeConfig.horizontalSpaceSmall(),
                Expanded(child: Text(title,style: AppStyles.BlackStyleFont_20(context),)),
                SizeConfig.horizontalSpaceSmall(),
                SizedBox(
                    height: SizeConfig.smallIconSize,
                    width:  SizeConfig.tabIconSize,
                    child: Image.asset(AssetsPath.forwardicon,color: Theme.of(context).focusColor,))
              ],

            ),
          ),
          decoration: BoxDecoration(
              border: borderColor?AppConstants.bottomBorder(context):Border()
          ),
        ),
        onTap: (){
         onTap();

        }
    );
  }
}
