import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_watchlist.dart';
import 'package:storeangelApp/ui/screens/consumer/pick_new_store_screen.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/premium_card.dart';
import 'package:storeangelApp/ui/widgets/watchlist/viewwatch_item.dart';

class WatchlistListView extends StatefulWidget {
  final WatchListViewModel model;
  final ScrollController scrollController;
  WatchlistListView({this.model, this.scrollController});

  @override
  _WatchlistListViewState createState() => _WatchlistListViewState();
}

class _WatchlistListViewState extends State<WatchlistListView> {


  bool viewAllList=false;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.model.wishList.length+2,
      controller: widget.scrollController,
      padding: SizeConfig.topAppbarPadding,
      itemBuilder: (context, index) {
        if(index==0){
          return AppHeader(
            title:AppStrings.WATCHLISTS.tr() ,
            subtitle:AppStrings.HAVE_FUN_WITH_YOUR_PURCHASES_TODAY.tr() ,
            secondChild: InkWell(
              child: AppConstants.addIcon,
              onTap: () {
                widget.model.navigateToScreen(NewOrderSelectStore.routeName,context);
              },
            ),
          );
        }
        if(index==widget.model.wishList.length+1){
          return Column(
            children: [
              Padding(
                  padding: SizeConfig.verticalPadding.copyWith(
                  bottom: SizeConfig.padding.bottom),
                  child: PremiumCard(
                    title: AppStrings.GET_PREMIUM_NOW.tr(),
                    subtitle: AppStrings.PREMIUM_SUBTITLE_WATCHLIST.tr(),
                  )),
              SizeConfig.CVerticalSpaceSmallMedium()
            ],
          );
        }
        return WatchListItem(item: widget.model.wishList[index-1],model: widget.model,
        );

      },
    );
  }
}
