
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class CourierOrderDeliveredViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  List<CourierCandidate>selectedCandidateList=[];
  List<CourierCandidate>candidateList=[];
  OrderOrPurchases order;
  int currentIndex=0;
  ScrollController scrollController;

  bool get selectedValues{
    return candidateList==selectedCandidateList;
  }

  void initialize(OrderOrPurchases orderOrPurchases, int initialIndex){
    getCandidateList(orderOrPurchases, initialIndex);
  }

  void getCandidateList(OrderOrPurchases orderOrPurchases,int initialIndex)async{
    setState(ViewState.Busy);
    candidateList= await database.getCourierCandidateList();
    if(candidateList.length>0){
      selectedCandidateList.add(candidateList.first);
    }
    if(initialIndex!=null){
      currentIndex=initialIndex;
    }
    order=orderOrPurchases;
    setState(ViewState.Idle);
  }

  void onSelectCandidate(int index){
    selectedCandidateList=[];
    selectedCandidateList.add(candidateList[index]);
    setState(ViewState.Idle);
  }

  void onSelectAll(){
    selectedCandidateList=candidateList;
    setState(ViewState.Idle);
  }

  void onUnSelectAll(){
    selectedCandidateList=[];
    setState(ViewState.Idle);
  }

  void onSelectIndex(int index){
    currentIndex=index;
    setState(ViewState.Idle);
  }

  void updateOrderStatus(OrderPurchaseStatus orderPurchaseStatus){
    order.status=orderPurchaseStatus;
    scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.decelerate);
    setState(ViewState.Idle);
  }

  void navigatorPop() {
    navigationService.pop();
  }

  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }
}