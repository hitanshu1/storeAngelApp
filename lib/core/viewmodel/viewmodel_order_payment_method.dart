import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/app_payment_methods.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/paymentMethod.dart';
import 'package:storeangelApp/core/models/payment_responsemodel.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/services/stripe_service.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/screens/consumer/home_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/mainApp_Screen.dart';
import 'package:storeangelApp/ui/screens/courier_status_screen.dart';
import 'package:storeangelApp/ui/screens/payment/paypalpage.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class OrderPaymentMethodViewModel extends BaseModel {
  FirebaseAbstraction database = getIt<FirebaseAbstraction>();
  List<PaymentMethod> paymentMethodList = [];
  PaymentMethod selectedPaymentMethod;

  void navigatorPop() {
    navigationService.pop();
  }

  void navigateToScreen(String routeName, BuildContext context, {Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value) {
      StatusBarService.changeStatusBarColor(StatusBarType.Light, context);
    });
  }

  void getPaymentMethods() {
    setState(ViewState.Busy);
    AppSampleData.prePaidPaymentMethods.forEach((element) {
      paymentMethodList.add(PaymentMethod.fromMap(element));
    });
    setState(ViewState.Idle);
  }

  void onSelectPaymentMethod(PaymentMethod method){
    setState(ViewState.Busy);
    selectedPaymentMethod=method;
    setState(ViewState.Idle);
}

  void onClickNext(OrderOrPurchases orderOrPurchases){
    orderOrPurchases.status = OrderPurchaseStatus.OrderAccepted;
    navigationService.navigateTo(MainAppScreen.routeName,);
  }

  void onClickPayment(String paymentOption, BuildContext context, OrderOrPurchases orderOrPurchases) async {
//    setState(ViewState.Busy);
    orderOrPurchases.status = OrderPurchaseStatus.Proposal;
    if (paymentOption == AppPaymentMethods.payPal) {
      Navigator.of(context)
          .push(
        MaterialPageRoute(
          builder: (BuildContext context) => PayPalPayment(
            onFinish: (number) async {
              // payment done
              print('order id: ' + number);
            },
          ),
        ),
      )
          .then((value) {
        StatusBarService.changeStatusBarColor(StatusBarType.White, context);
      });
      setState(ViewState.Idle);
    } else if (paymentOption == AppPaymentMethods.applePay || paymentOption == AppPaymentMethods.googlePay) {
      PaymentResponseModel response = await StripeService.googleAndApplePay(orderOrPurchases.purchaseDetails.amount);
      if (response.statusCode == 1) {
        setState(ViewState.Idle);
        navigationService.navigateTo(MainAppScreen.routeName,);
//        navigationService.navigateTo(CourierStatusScreen.routeName,
//            arguments: CourierStatusScreenArgument(
//              orderOrPurchases: orderOrPurchases,
//            ));
      } else {
        setState(ViewState.Idle);
        MyUtils().toastdisplay(response.message);
      }
    } else if (paymentOption == AppPaymentMethods.sofortPay) {
      PaymentResponseModel response = await StripeService.paySofort(orderOrPurchases.purchaseDetails.amount);
      if (response.statusCode == 1) {
        setState(ViewState.Idle);
        navigationService.navigateTo(MainAppScreen.routeName,);
//        navigationService.navigateTo(CourierStatusScreen.routeName,
//            arguments: CourierStatusScreenArgument(
//              orderOrPurchases: orderOrPurchases,
//            )
//        );
      } else {
        setState(ViewState.Idle);
        MyUtils().toastdisplay(response.message);
      }
    } else if (paymentOption == AppPaymentMethods.cardPay) {
      StripeService.payWithCard();
    } else {
      setState(ViewState.Idle);
      navigationService.navigateTo(MainAppScreen.routeName,
          );
    }
  }
}
