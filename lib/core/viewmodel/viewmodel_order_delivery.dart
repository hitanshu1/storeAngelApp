
import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class OrderDeliveryViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();


  List receipts=[
    'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/proof2.png?alt=media&token=3d446718-e039-4dd0-b236-09595ea6561c',
    'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/proof2.png?alt=media&token=3d446718-e039-4dd0-b236-09595ea6561c',
    'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/proof2.png?alt=media&token=3d446718-e039-4dd0-b236-09595ea6561c',
    'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/proof2.png?alt=media&token=3d446718-e039-4dd0-b236-09595ea6561c',
    'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/proof2.png?alt=media&token=3d446718-e039-4dd0-b236-09595ea6561c'
  ];

  PurchaseDetails purchaseDetails;
  OrderOrPurchases order;

  bool showReceipt=false;
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments,}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }

  void getPurchaseDetails(OrderOrPurchases value){
    setState(ViewState.Busy);
//    purchaseDetails =await database.getPurchaseDetails('id');
    purchaseDetails=value.purchaseDetails;
    purchaseDetails.customer.city='95455 Nürnberg';
    order=value;
    print(order.status);
    order.receipts=receipts;

    setState(ViewState.Idle);
  }

  void onChangeReceiptVisibility(bool value,BuildContext context){
    setState(ViewState.Busy);
    if(value){
      StatusBarService.changeStatusBarColor(StatusBarType.Dark, context);
    }else{
      StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    }
    showReceipt=value;
    setState(ViewState.Idle);
  }
}