
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class CourierOrderDeliveredSummaryViewModel extends BaseModel{
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }

  List transferOptions=[AppStrings.PAYPAL.tr(),AppStrings.HANDED_OVER_PERSONALLY.tr()];
  String selectedOption=AppStrings.PAYPAL.tr();

    OrderOrPurchases order;
  UserModel selectedClient;
  List<Product>products=[];
  bool viewAllProduct=false;
  String countryCode;

  void initializeData(OrderOrPurchases value){
    setState(ViewState.Busy);

    order=value;
    selectedClient=order.clientlist.first;
    value.purchaseDetails.products.forEach((product) {
      //if(product.assignClient.id==selectedClient.id){
        products.add(product);
      //}
    });
    setState(ViewState.Idle);
  }

  void onSelectClient(UserModel value){
    setState(ViewState.Busy);
    selectedClient=value;
    products=[];
    order.purchaseDetails.products.forEach((product) {
      //if(product.assignClient.id==selectedClient.id){
        products.add(product);
     // }
    });
    setState(ViewState.Idle);
  }
  void onTapViewAll(){
    setState(ViewState.Busy);
    viewAllProduct=true;
    setState(ViewState.Idle);
  }
  void onUpdatePayment(){
    setState(ViewState.Busy);
    order.paid=true;
    navigatorPop();
    setState(ViewState.Idle);
  }

  void onSelectTranferOption(String value){
    setState(ViewState.Busy);
    selectedOption=value;
    setState(ViewState.Idle);
  }
}