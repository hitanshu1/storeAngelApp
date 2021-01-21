
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class MyStoreViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  List<StoreDataModel>stores=[];
  ScrollController scrollController;
  bool hasShadow = false;

  void navigatorPop() {
    navigationService.pop();
  }
  Future getUserStore(String userId)async{
    setState(ViewState.Busy);
    print('get database data');
    //stores=await database.getUserStore(userId);
    stores = AppSampleData.storeList;
    print('got data: ${stores.length}');
    setState(ViewState.Idle);
  }

  Future onDeleteStore(StoreDataModel store)async{
    setState(ViewState.Busy);
    await database.deleteSelectedStore(store);
    setState(ViewState.Idle);
  }




  void initialize(ScrollController scrollController){
    Future.delayed(Duration.zero,(){
      this.scrollController = scrollController;
      this.scrollController.addListener(addScrollListener);
    });
    getUserStore('userId');
  }

  void addScrollListener(){
    if(scrollController.position.pixels==0){
      hasShadow = false;
    }else{
      hasShadow = true;
    }
    setState(ViewState.Idle);
  }

  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName,arguments: arguments).then((value){
      setState(ViewState.Idle);
    });
  }



}