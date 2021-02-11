
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class PickNewStoreViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  List<StoreDataModel>selectedStores=[];
  List<StoreDataModel>unselectedStores=[];
  ScrollController scrollController;
  bool hasShadow = false;
  UserModel userDetails;

  void navigatorPop() {
    navigationService.pop();
  }
  Future getUserStore(String userID)async{
    setState(ViewState.Busy);
    print('get database data');
    //stores=await database.getUserStore(userId);
    selectedStores = [AppSampleData.storeList.first];
    AppSampleData.storeList.forEach((element) {
      if(!selectedStores.contains(element)){
        unselectedStores.add(element);
      }
    });


    userDetails=await database.getUserDetails(userID);
    setState(ViewState.Idle);
  }

  Future onDeleteStore(StoreDataModel store)async{
    setState(ViewState.Busy);
    await database.deleteSelectedStore(store);
    setState(ViewState.Idle);
  }

  void onAddStore(StoreDataModel store){
    setState(ViewState.Busy);
    if(selectedStores.length<3){
      selectedStores.add(store);
      unselectedStores.remove(store);
    }
    setState(ViewState.Idle);
  }




  void initialize(ScrollController scrollController,String userID)async{
    Future.delayed(Duration.zero,(){
      this.scrollController = scrollController;
      this.scrollController.addListener(addScrollListener);
    });

    getUserStore(userID);
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