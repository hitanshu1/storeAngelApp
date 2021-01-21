import 'package:flutter/material.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/models/response_model.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class WatchListDetailViewModel extends BaseModel {


  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  FirebaseAbstraction _myFirebaseServices = getIt<FirebaseAbstraction>();
  PurchaseDetails purchaseDetails;
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,BuildContext context,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value){
      setState(ViewState.Idle);
      StatusBarService.changeStatusBarColor(StatusBarType.Gray,context);
    });
  }

  void initializeData(PurchaseDetails value){
    setState(ViewState.Busy);
    purchaseDetails=value;
    setState(ViewState.Idle);
  }

  void removeProduct(String detailsId,Product product,BuildContext context)async{
    setState(ViewState.Busy);
    ResponseModel response=await _myFirebaseServices.removeProductFomWishlist(detailsId, product);
    if(response.status==1){
      MyUtils().toastsuccessdisplay(response.message);
    }

    setState(ViewState.Idle);
  }

  void onUpdateProduct(List<Product>updateProducts){
    setState(ViewState.Busy);
    purchaseDetails.products.addAll(updateProducts);
    setState(ViewState.Idle);
  }

  Stream<List<Product>>getProductList(PurchaseDetails purchaseDetails){
    return _myFirebaseServices.getWishListProductList(purchaseDetails);
  }

}