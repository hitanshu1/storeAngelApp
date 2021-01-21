
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/screens/deliverylocation_screen.dart';
import 'package:storeangelApp/ui/screens/order_courier_flow/estimation_screen.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectProductViewModel extends BaseModel{
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,BuildContext context,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value){
      StatusBarService.changeStatusBarColor(StatusBarType.Light,context);
    });
  }
  PurchaseDetails purchaseDetails;

  bool get isAllSelected=>selectedProducts.length==purchaseDetails.products.length;


  List<Product>selectedProducts=[];

  void initializeData(PurchaseDetails value){
    setState(ViewState.Busy);
    purchaseDetails=value;
    setState(ViewState.Idle);
  }

  void onSelectUnselectAll(){
    setState(ViewState.Busy);
    if(isAllSelected){
      selectedProducts=[];
    }else{
      selectedProducts=[];
      selectedProducts.addAll(purchaseDetails.products);
    }

    setState(ViewState.Idle);
  }

  void onSelectProduct(Product val){
    if(!selectedProducts.contains(val)){
      selectedProducts.add(val);
    }else{
      selectedProducts.remove(val);
    }

    setState(ViewState.Idle);
  }
  void onClickNext(BuildContext context){
    if(selectedProducts.length>0){

      setState(ViewState.Idle);
      navigateToScreen(DeliveryLocationScreen.routeName, context,
          arguments: PurchaseDetails(id: purchaseDetails.id,customer: purchaseDetails.customer,
          products: selectedProducts,paymentOption: purchaseDetails.paymentOption,purchaseProofImages: purchaseDetails.purchaseProofImages,
          notificationType: purchaseDetails.notificationType,amount: purchaseDetails.amount,listName: purchaseDetails.listName,
          storeDetails: purchaseDetails.storeDetails,quantity: purchaseDetails.quantity,time: purchaseDetails.time,));
    }else{
      MyUtils().toastdisplay(AppStrings.PLEASE_SELECT_PRODUCT_FIRST.tr());
    }


  }

}