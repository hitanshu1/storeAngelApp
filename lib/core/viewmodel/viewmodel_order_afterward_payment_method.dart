
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/app_payment_methods.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/paymentMethod.dart';
import 'package:storeangelApp/core/models/payment_responsemodel.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/services/stripe_service.dart';
import 'package:storeangelApp/ui/screens/payment/paypalpage.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';
import '../../ui/shared/MyUtils.dart';

class OrderAfterWardPaymentMethodViewMoel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  List<PaymentMethod>paymentMethodList=[];

  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,BuildContext context,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value){
      StatusBarService.changeStatusBarColor(StatusBarType.Light, context);
    });
  }


  void getPaymentMethods(){
    setState(ViewState.Busy);
    AppSampleData.paymentMethods.forEach((element) {
      paymentMethodList.add(PaymentMethod.fromMap(element));
    });
    setState(ViewState.Idle);

  }

  void onClickNext(){
    navigatorPop();
  }

  void onClickPayment(String paymentOption,BuildContext context,OrderOrPurchases orderOrPurchases)async{
//    setState(ViewState.Busy);
    if(paymentOption==AppPaymentMethods.payPal){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => PayPalPayment(
            onFinish: (number) async {

              // payment done
              print('order id: '+number);

            },
          ),
        ),
      ).then((value){
        StatusBarService.changeStatusBarColor(StatusBarType.White, context);
      });
      setState(ViewState.Idle);
    }else if(paymentOption==AppPaymentMethods.applePay||
        paymentOption==AppPaymentMethods.googlePay){

      PaymentResponseModel response= await StripeService.googleAndApplePay(orderOrPurchases.purchaseDetails.amount);
      if(response.statusCode==1){
        setState(ViewState.Idle);
        navigatorPop();
      }else{
        setState(ViewState.Idle);
        MyUtils().toastdisplay(response.message);
      }
    }else if(paymentOption==AppPaymentMethods.sofortPay){
      PaymentResponseModel response=await StripeService.paySofort(orderOrPurchases.purchaseDetails.amount);
      if(response.statusCode==1){
        setState(ViewState.Idle);
        navigatorPop();

      }else{
        setState(ViewState.Idle);
        MyUtils().toastdisplay(response.message);
      }

    }else if(paymentOption==AppPaymentMethods.cardPay){
      StripeService.payWithCard();
    }
    else{
      setState(ViewState.Idle);
      navigatorPop();

    }

  }

}