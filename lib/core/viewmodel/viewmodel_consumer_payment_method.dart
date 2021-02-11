
import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/paymentMethod.dart';
import 'package:storeangelApp/ui/screens/consumer/order_details_and_chat_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class ConsumerPaymentMethodViewModel extends BaseModel{
  List<PaymentMethod> paymentMethodList = [];


  void getPaymentMethods() {
    setState(ViewState.Busy);
    AppSampleData.prePaidPaymentMethods.forEach((element) {
      paymentMethodList.add(PaymentMethod.fromMap(element));
    });
    setState(ViewState.Idle);
  }
  void onClickPayment(String paymentOption, BuildContext context, OrderOrPurchases orderOrPurchases,CourierCandidate candidate) async {
//    setState(ViewState.Busy);
    orderOrPurchases.status = OrderPurchaseStatus.Purchasing;

    navigationService.navigateTo(OrderDetailsAndChatScreen.routeName,
    arguments: OrderDetailsAndChatScreenArguments(
      orPurchases: orderOrPurchases,
      candidate: candidate
    ));

  }
}