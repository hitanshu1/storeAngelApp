
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/enums/premium_selected_tile.dart';
import 'package:storeangelApp/core/models/premium_tile.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:easy_localization/easy_localization.dart';

class PremiumViewModel extends BaseModel{
  final List<PremiumTile> _premiumTiles = [
    PremiumTile(
        tileName: PremiumSelectedTile.left,
        header: AppStrings.BASIC.tr(),
        monthString: '1 ${AppStrings.MONTH.tr()}',
        price: '€ 6,99',
        stackPosition: 0),
    PremiumTile(
        tileName: PremiumSelectedTile.middle,
        header: AppStrings.STOREANGEL_PREMIUM.tr(),
        monthString: '12 ${AppStrings.MONTHS.tr()}',
        price: '€ 4,99',
        stackPosition: 1),
    PremiumTile(
        tileName: PremiumSelectedTile.right,
        header: AppStrings.EXPERT.tr(),
        monthString: '6 ${AppStrings.MONTHS.tr()}',
        price: '€ 5,99',
        stackPosition: 2),
  ];

  bool hasShadow = false;
  ScrollController scrollController;

  ///Shows which premium list tile is selected and will therefore sort the tiles accordingly within the stack
  PremiumSelectedTile selectedTile = PremiumSelectedTile.middle;

  ///List with all premium tile widgets
  List<Widget> premiumTileList = [];

  set setPremiumSelectedTile(PremiumSelectedTile tileName){
    _premiumTiles.forEach((tile) {
      if(tile.isSelected){
        tile.isSelected = false;
      }

      if(tile.tileName == tileName){
        tile.isSelected = true;
      }
    });
    selectedTile = tileName;

    setState(ViewState.Idle);
  }

  void initialize(ScrollController scrollController){
    Future.delayed(Duration.zero,(){
      this.scrollController = scrollController;
      this.scrollController.addListener(addScrollListener);
    });
  }

  void addScrollListener(){
    if(scrollController.position.pixels==0){
      hasShadow = false;
    }else{
      hasShadow = true;
    }
    setState(ViewState.Idle);
  }



  void getSortedList(BuildContext context, Function buildPremiumTile) {
    premiumTileList.clear();

    //Loops through list sorts the selected Widget at the end of the list and the other at the beginning of the list
    //This is due to the fact that through this the selected tile will be able to overlap the other list tiles
    for (final premiumTile in _premiumTiles) {
      if (premiumTile.tileName == selectedTile) {
        premiumTile.isSelected = true;
        premiumTileList.add(buildPremiumTile(context, premiumTile));
      } else {
        premiumTileList.insert(0, buildPremiumTile(context, premiumTile));
      }
    }
  }

  void navigatorPop(){
    navigationService.pop();
  }
}