import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/mainApp_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/shared/custom_bar_item.dart';

class AppBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: EdgeInsets.only(
          top: 5
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _customBarItem(icon: StoreangelIcons.home_tab,
            activeIcon: StoreangelIcons.home_tab_full,
            title:AppStrings.HOME.tr(),context: context,currentIndex:0 ),
            SizeConfig.horizontalSpaceGap(),
            _customBarItem(icon: StoreangelIcons.banana_apple,
                activeIcon: StoreangelIcons.banana_apple_full,
                title:AppStrings.TAB_LABLE_LISTS.tr(),context: context,currentIndex:1),
            SizeConfig.horizontalSpaceGap(),

            _customBarItem(icon: StoreangelIcons.stores_tab,
                activeIcon: StoreangelIcons.stores_tab_full,
                title:AppStrings.STORE.tr(),context: context,currentIndex:2),
            SizeConfig.horizontalSpaceGap(),
            _customBarItem(icon: StoreangelIcons.profile_consumer_tab,
                activeIcon: StoreangelIcons.profile_consumer_tab_full,
                title:AppStrings.TAB_LABLE_PROFILE.tr(),context: context,currentIndex:3),
          ],
        ),
      ),
    );
  }

  Widget _customBarItem({@required IconData icon,@required IconData activeIcon,@required String title,@required BuildContext context,@required int currentIndex}) {
    bool active=Provider.of<MainAppViewModel>(context, listen: true).bottomNavigationIndex==currentIndex;
    return CustomBarItemWidget(onTap:  (){
      Provider.of<MainAppViewModel>(context, listen: false).setBottomNavigationIndex(currentIndex);
      Provider.of<ProfileViewModel>(context, listen: false).changeView(ProfilePageView.home);
    },
        active: active,
        title: title, icon: active?activeIcon:icon);
  }
}
