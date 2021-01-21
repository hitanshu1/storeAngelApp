import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/response_model.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';
class OrderInformationViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  bool viewAll=false;
  DateTime initialDateTime =DateTime.now();
  DateTime startDate;
  DateTime endDate;
  String selectDateAndTime;
  String selectedPaymentMethod=AppStrings.PREPAYMENT.tr();
  int myFee=5;

  void onIncrementFee(){
    setState(ViewState.Busy);
    myFee=myFee+5;
    setState(ViewState.Idle);
  }
  void onDecrementFee(){
    setState(ViewState.Busy);
    if(myFee>5){
      myFee=myFee-5;
    }

    setState(ViewState.Idle);
  }

  List<String>orderPayments=[
    AppStrings.PREPAYMENT.tr(),
    AppStrings.PAYMENT_ON_DELIVERY.tr(),
  ];

  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }

  void toggleView(){
    setState(ViewState.Busy);
    viewAll=!viewAll;
    setState(ViewState.Idle);
  }
  void onSelectPaymentMethod(String value){
    setState(ViewState.Busy);
    selectedPaymentMethod=value;
    setState(ViewState.Idle);
  }
  void onSelectStartDate(DateTime dateTime){
    setState(ViewState.Busy);
    startDate =dateTime;
    setState(ViewState.Idle);
  }
  void onSelectEndDate(DateTime dateTime, BuildContext context){
    setState(ViewState.Busy);
    endDate=dateTime;
    selectDateAndTime='${DateService.getDateFormat(dateTime.toIso8601String(), context)} ${startDate.hour<10?'0${startDate.hour}':startDate.hour}:${startDate.minute<10?'0${startDate.minute}':startDate.minute} - ${endDate.hour<10?'0${endDate.hour}':endDate.hour}:${endDate.minute<10?'0${endDate.minute}':endDate.minute}';
    setState(ViewState.Idle);
  }

  void onDeleteOffer(OrderOrPurchases order)async{
    setState(ViewState.Busy);
    ResponseModel response=await database.onDeleteOffer(order);
    if(response.status==1){
      navigatorPop();
    }
    setState(ViewState.Idle);
  }




}