
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class StoreDetailsViewModel extends BaseModel{
  bool hasShadow = false;
  ScrollController scrollController;
  List<StoreDataModel>stores=[];
  int initialIndex=0;

  StoreDataModel get currentStore=>stores[initialIndex];
  void initialize(int indexVal){

    stores = AppSampleData.storeList;
    initialIndex=indexVal;
    setState(ViewState.Idle);
  }

  void setSelectedIndex(int indexVal){
    setState(ViewState.Busy);
    initialIndex=indexVal;
    setState(ViewState.Idle);
  }




  void addScrollListener(){
    if(scrollController.position.pixels==0){
      hasShadow = false;
    }else{
      hasShadow = true;
    }
    setState(ViewState.Idle);
  }

  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {

    navigationService.navigateTo(routeName, arguments: arguments);
  }
}