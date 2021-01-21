import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class CustomAppBarWidget extends StatelessWidget {
  final String title;
  final Function onTap;

  CustomAppBarWidget({this.title,  this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.screenHeight * .02,
            right: SizeConfig.screenWidth * .03),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizeConfig.verticalSpaceLargeBig(),
            Expanded(
              flex: 1,
              child: Visibility(
                  visible: false,
                  child:BackButton(
                  color: Theme.of(context).iconTheme.color,
                    onPressed: (){
                    },
                  )),
            ),
            Expanded(
              flex: 6,
                child: Text(
                  title != null ? title : AppStrings.WATCH_LIST.tr(),
                  style: AppStyles.BlackStyleWithBold800Font_24(context),
                  textAlign: TextAlign.center,
                ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: AppConstants.addIcon,
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
