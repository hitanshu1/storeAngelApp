import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class PaymentMethodScreenViewModel extends BaseModel{
  List selectedPaymentMethods=[];
  bool paypalValue=false;
  bool googlePayValue=false;
  bool sofortDientsValue=false;
  bool cashValue=false;
  bool creditCard=false;
  bool hasShadow = false;
  ScrollController scrollController;

  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }

  void updatePaypalValue(value){
    setState(ViewState.Busy);
    if(value){
      paypalValue=value;
      selectedPaymentMethods.add(AppStrings.PAYPAL.tr());
    }else{
      paypalValue=value;
      selectedPaymentMethods.remove(AppStrings.PAYPAL.tr());
    }
    setState(ViewState.Idle);
  }
  void updateGooglePayValue(value){
    setState(ViewState.Busy);
    if(value){
      googlePayValue=value;
      selectedPaymentMethods.add(AppStrings.GOOGLE_PAY.tr());
    }else{
      googlePayValue=value;
      selectedPaymentMethods.remove(AppStrings.GOOGLE_PAY.tr());
    }
    setState(ViewState.Idle);
  }
  void updateSofortDientsValue(value){
    setState(ViewState.Busy);
    if(value){
      sofortDientsValue=value;
      selectedPaymentMethods.add(AppStrings.SOFORT_DIENTS.tr());
    }else{
      sofortDientsValue=value;
      selectedPaymentMethods.remove(AppStrings.SOFORT_DIENTS.tr());
    }
    setState(ViewState.Idle);
  }
  void updateCashValue(value){
    setState(ViewState.Busy);
    if(value){
      cashValue=value;
      selectedPaymentMethods.add(AppStrings.CASH.tr());
    }else{
      cashValue=value;
      selectedPaymentMethods.remove(AppStrings.CASH.tr());
    }
    setState(ViewState.Idle);
  }
  void updateCreditCardValue(value){
    setState(ViewState.Busy);
    if(value){
      creditCard=value;
      selectedPaymentMethods.add(AppStrings.CREDIT_CARDS.tr());
    }else{
      creditCard=value;
      selectedPaymentMethods.remove(AppStrings.CREDIT_CARDS.tr());
    }
    setState(ViewState.Idle);
  }

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
}