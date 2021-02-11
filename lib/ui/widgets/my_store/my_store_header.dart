import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_mystore.dart';
import 'package:storeangelApp/ui/screens/consumer/pick_Store_Screen.dart';
import 'package:storeangelApp/ui/screens/premium_first_screen.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:easy_localization/easy_localization.dart';

class MyStoreHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyStoreViewModel>(
        builder: (context,myStoreViewModel,child){
          return SliverToBoxAdapter(
            child: AppHeader(
              title: AppStrings.YOUR_STORES.tr(),
              actions: [
                IconButton(icon: Icon(Icons.add,color: AppColors.whiteColor,size: SizeConfig.mediumIcon,), onPressed: (){
                  if (myStoreViewModel.selectedStores.length >= 3) {
                    myStoreViewModel.navigateToScreen(PremiumFirstScreen.routeName);
                  } else {
                    myStoreViewModel.navigateToScreen(PickStoreScreen.routeName,
                        arguments: PickStoreScreenArguments(isMyStoreScreen: true));
                  }
                })
              ],
            ),
          );
        });
  }
}
