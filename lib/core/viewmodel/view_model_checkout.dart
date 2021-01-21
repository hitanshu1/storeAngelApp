import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/enums/payment_mode.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/payment_option.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/screens/order/afterwards/order_payment_afterwards_screen.dart';
import 'package:storeangelApp/ui/screens/order/order_payment_method_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class CheckOutViewModel extends BaseModel{


  PaymentMode selectedPaymentMode=PaymentMode.PayPal;

  void updatePaymentMode(PaymentMode paymentMode){
    setState(ViewState.Busy);
    selectedPaymentMode=paymentMode;
    setState(ViewState.Idle);
  }
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,BuildContext context,{Object arguments,}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value){
      StatusBarService.changeStatusBarColor(StatusBarType.Gray,context);
    });
  }

  void onSubmit(OrderOrPurchases order,BuildContext context){

    if(order.purchaseDetails.paymentOption.paymentOptionEnum==PaymentOptionEnum.prepayment){
      navigateToScreen(OrderPaymentMethodScreen.routeName, context,
          arguments:OrderPaymentMethodScreenArgument(
            orderOrPurchases: order,
          ));
    }else{
      navigateToScreen(OrderPaymentAfterWardsScreen.routeName, context,
          arguments: order);
    }

  }


}