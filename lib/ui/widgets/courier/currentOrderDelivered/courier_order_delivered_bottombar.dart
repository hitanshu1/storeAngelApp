import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';

class CourierOrderDeliveredBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final onSelectIndex;
  CourierOrderDeliveredBottomNavigationBar({@required this.currentIndex,this.onSelectIndex});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      elevation: 20,
      items: <BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: _customIcon(StoreangelIcons.change_to_courier_profile_screen),
          activeIcon: _customIcon(StoreangelIcons.change_to_courier_profile_full),
            label: AppStrings.ORDER.tr(),
        ),
        BottomNavigationBarItem(
            icon: _customIcon(StoreangelIcons.message_icon),
            activeIcon: _customIcon(StoreangelIcons.message_full),
            label: AppStrings.CHAT.tr(),
        ),
        BottomNavigationBarItem(
            icon: _customIcon(StoreangelIcons.details_courier_tab),
            activeIcon: _customIcon(StoreangelIcons.details_courier_tab_full),
            label: AppStrings.DETAILS.tr()
        ),
      ],
      onTap: (val)=> onSelectIndex(val),
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Theme.of(context).textTheme.headline5.color,
      selectedFontSize: SizeConfig.fontSizeSmall,
      unselectedFontSize: SizeConfig.fontSizeSmall,

    );
  }

  Widget _customIcon(IconData icon){
    return Padding(
        padding: EdgeInsets.only(top: SizeConfig.screenHeight*.008, bottom: SizeConfig.screenHeight * .003),
        child: Icon(icon, size: 24,));
  }
}
