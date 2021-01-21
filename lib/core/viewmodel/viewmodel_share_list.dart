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

  void onEnableSearch(bool val)async{
    setState(ViewState.Busy);
    searchText=val;
    users=await _myFirebaseServices.searchUserList('');
    unSelectedUsers=await _myFirebaseServices.searchUserList('');
    setState(ViewState.Idle);
  }
  void initializeData()async{
    setState(ViewState.Busy);

    setState(ViewState.Idle);
  }
  void onSearch(String text)async{
    users=[];
    users=await _myFirebaseServices.searchUserList(text);
    print('object${users.length}');
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