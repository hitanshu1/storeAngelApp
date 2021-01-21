
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class ListUserViewModel extends BaseModel {
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  String username='Jessica miles';
  List<UserModel>users=[];
  bool hasShadow = false;
  ScrollController scrollController;

  void initialize(ScrollController scrollController){
    Future.delayed(Duration.zero,(){
      this.scrollController = scrollController;
      this.scrollController.addListener(addScrollListener);
    });
    getUsers();
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
    navigationService.navigateTo(routeName, arguments: arguments).then((value){
      getUsers();
    });
  }
  Future getUsers()async{
    setState(ViewState.Busy);
    users=await database.getUserList();
    setState(ViewState.Idle);
  }

  Future removeUser(UserModel user)async{
    setState(ViewState.Busy);
    await database.removeUser(user);


    setState(ViewState.Idle);
  }


}
