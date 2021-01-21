
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/models/address.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class MyAddressViewModel extends BaseModel {
  bool hasShadow = false;
  ScrollController scrollController;
  FirebaseAbstraction _myFirebaseServices = getIt<FirebaseAbstraction>();

  List<AddressModel>myaddresses = [];

  void getUserAddresses(String userId)async {
    setState(ViewState.Busy);
    myaddresses =await _myFirebaseServices.getUserAddress(userId);
    setState(ViewState.Idle);
  }

  void initialize(ScrollController scrollController){
    Future.delayed(Duration.zero,(){
      this.scrollController = scrollController;
      this.scrollController.addListener(addScrollListener);
    });
    getUserAddresses('userId');
  }

  void addScrollListener(){
    if(scrollController.position.pixels==0){
      hasShadow = false;
    }else{
      hasShadow = true;
    }
    setState(ViewState.Idle);
  }

}