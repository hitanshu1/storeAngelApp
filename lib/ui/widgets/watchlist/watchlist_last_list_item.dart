import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/shared/circleIcon.dart';
import 'package:storeangelApp/ui/shared/custom_divider_widget.dart';

class WatchlistLastListItem extends StatelessWidget {
  final Function onTap;

  const WatchlistLastListItem({Key key, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(SizeConfig.sidepadding.left, SizeConfig.screenHeight * .013,
                SizeConfig.sidepadding.right, SizeConfig.screenHeight * .013),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.green,
                  ),
                  margin: EdgeInsets.only(right: 6, left: 6, top: 6, bottom: 6),
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  constraints: BoxConstraints(minWidth: 40, maxWidth: 40, minHeight: 40, maxHeight: 40),
                  child: Icon(
                    StoreangelIcons.cashier_full,
                    color: AppColors.whiteColor,
                    size: 20,
                  ),
                ),
                SizeConfig.horizontalSpaceSmall(),
                Expanded(
                    child: Text(
                  AppStrings.FINISH_PURCHASE_LAST_ITEM.tr(),
                  style: AppStyles.GreenStyleWithBold800_Font20(context),
                )),
                SizeConfig.horizontalSpaceSmall(),
              ],
            ),
          ),
          Padding(
            padding: SizeConfig.sidepadding,
            child: CustomDividerWidget(
              height: 1,
            ),
          )
        ],
      ),
    );
  }
}
