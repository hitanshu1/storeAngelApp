
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class AddNewUserViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  List<UserModel>userList=[];
  bool hasShadow = false;
  ScrollController scrollController;

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

  Future getSearchUserList(String searchText)async{
    setState(ViewState.Busy);
    userList=await database.searchUserList(searchText);
    setState(ViewState.Idle);
  }

  Future shareUser(UserModel user)async{
    setState(ViewState.Busy);
    await database.shareUser(user);
    setState(ViewState.Idle);
  }
  void  clearUserList(){
    setState(ViewState.Busy);
    userList=[];
    setState(ViewState.Idle);
  }



}