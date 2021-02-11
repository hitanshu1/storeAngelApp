
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class MyStoreViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  List<StoreDataModel>selectedStores=[];
  List<StoreDataModel>unselectedStores=[];
  bool hasShadow = false;
  UserModel userDetails=UserModel();

  void navigatorPop() {
    navigationService.pop();
  }
  Future getUserStore(String userID)async{
    setState(ViewState.Busy);
    //stores=await database.getUserStore(userId);
    selectedStores = [AppSampleData.storeList.first];
    AppSampleData.storeList.forEach((element) {
      if(!selectedStores.contains(element)){
        unselectedStores.add(element);
      }
    });


    //userDetails=await database.getUserDetails(userID);
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




  void initialize(String userID)async{

    getUserStore(userID);
  }


  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName,arguments: arguments).then((value){
      setState(ViewState.Idle);
    });
  }



}