import 'package:flutter/material.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class ShareListViewModel extends BaseModel{
  FirebaseAbstraction _myFirebaseServices = getIt<FirebaseAbstraction>();
  bool searchText=false;
  TextEditingController searchController=TextEditingController();
  List<UserModel>users=[];
  List<UserModel>selectedUsers=[];
  List<UserModel>unSelectedUsers=[];
  UserModel currentUserDetails;


  void onEnableSearch(bool val)async{
    setState(ViewState.Busy);
    searchText=val;
    unSelectedUsers=await _myFirebaseServices.getUserList();
    setState(ViewState.Idle);
  }
  void initializeData(String userID)async{
    setState(ViewState.Busy);
    currentUserDetails=await _myFirebaseServices.getUserDetails(userID);

    setState(ViewState.Idle);
  }
  void removeUnselected(UserModel userVal){
    setState(ViewState.Busy);
    unSelectedUsers.remove(userVal);
    setState(ViewState.Idle);
  }
  void onSearch(String text)async{
    users=[];
    unSelectedUsers.forEach((element) {
      if(element.name.toLowerCase().contains(text.toLowerCase())||element.email.toLowerCase().contains(text.toLowerCase())){
        users.add(element);
      }
    });
    setState(ViewState.Idle);
  }
  void onSelectUser(UserModel val){
    setState(ViewState.Busy);
    if(!selectedUsers.contains(val)){
      selectedUsers.add(val);
      unSelectedUsers.remove(val);
      searchText=false;
    }

    setState(ViewState.Idle);
  }

}