import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_mainpage.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/shared/custom_bar_item.dart';

class CourierAppBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).cardColor,
    padding: EdgeInsets.only(
    top: 5
    ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _customBarItem(icon: StoreangelIcons.request,
              title: AppStrings.REQUESTS.tr(), context: context, currentIndex: 0),
          SizeConfig.horizontalSpaceGap(),
          _customBarItem(icon: StoreangelIcons.offer_courier_tab,
              title: AppStrings.OFFERS.tr(), context: context, currentIndex: 1),
          SizeConfig.horizontalSpaceGap(),
          _customBarItem(icon: StoreangelIcons.change_to_courier_profile_screen,
              title: AppStrings.ORDERS.tr(), context: context, currentIndex: 2),
          SizeConfig.horizontalSpaceGap(),
          _customBarItem(icon: StoreangelIcons.profile_courier_tab,
              title: AppStrings.PROFILE.tr(), context: context, currentIndex: 3)
        ],
      ),
    );

  }

  Widget _customBarItem({@required IconData icon,@required String title,@required BuildContext context,@required int currentIndex}) {
    bool active=Provider.of<CourierMainViewModel>(context, listen: true).bottomNavigationIndex==currentIndex;
    return CustomBarItemWidget(onTap:  (){
      Provider.of<CourierMainViewModel>(context, listen: false).setBottomNavigationIndex(currentIndex);
      Provider.of<ProfileViewModel>(context, listen: false).changeView(ProfilePageView.home);
    },
        active: active,
        title: title, icon: icon);
  }

}
