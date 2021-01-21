import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class CourierDetailsTabViewModel extends BaseModel{
  OrderOrPurchases order;

  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,BuildContext context,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value){
      StatusBarService.changeStatusBarColor(StatusBarType.White, context);
    });
  }
  UserModel selectedClient;
  List<Product>products=[];

  void initializeData(OrderOrPurchases value){
    setState(ViewState.Busy);
    order=value;
    selectedClient=order.clientlist.first;
    products=[];
    order.purchaseDetails.products.forEach((product) {
      //if(product.assignClient.id==selectedClient.id){
        products.add(product);
      //}
    });
    setState(ViewState.Idle);
  }

  void onSelectClient(UserModel client){
    setState(ViewState.Busy);
    selectedClient=client;
    setState(ViewState.Idle);
  }
}
