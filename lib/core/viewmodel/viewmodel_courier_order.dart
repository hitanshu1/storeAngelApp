
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/models/package_model.dart';
import 'package:storeangelApp/core/services/base_api.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
class CourierOrderViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  bool viewDetails=false;
  ScrollController scrollController;
  bool hasShadow = false;

  List<OrderOrPurchases> orders=[];

  List<PackageModel>packages=[];
  List<StoreDataModel>stores;

  List<OrderOrPurchases>pastedOrders=[];
  List<OrderByStore>orderByStoreList=[];
  void navigatorPop() {
    navigationService.pop();
  }
  int selectedIndex = 0;

  void setSelectedIndex(int index){
    selectedIndex = index;
    setState(ViewState.Idle);
  }

  void navigateToScreen(String routeName,BuildContext context,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value){
      StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    });
  }

  void toggleView(){
    setState(ViewState.Busy);
    viewDetails=!viewDetails;
    setState(ViewState.Idle);
  }
  Future getAssignOrderList(String courierId)async{
    setState(ViewState.Busy);
    orders=await database.getOrdersForCourier(courierId);
    pastedOrders=await database.getPastOrders(courierId);
    stores=await database.getStoreData();
    orderByStoreList=await database.getOrderByStoreList();

    setState(ViewState.Idle);
  }

  String  getStatusTitle(OrderOrPurchases orderVal) {
   if(orderVal.status==OrderPurchaseStatus.Proposal){
     return AppStrings.PENDING_PAYMENT.tr();
   }else if(orderVal.status==OrderPurchaseStatus.MoneyTransfer){
     return AppStrings.PAYMENT_RECEIVED.tr();
   }else if(orderVal.status==OrderPurchaseStatus.OrderAccepted){
     return AppStrings.PURCHASE_ORDER.tr();
   }else if(orderVal.status==OrderPurchaseStatus.OrderRunning){
     return AppStrings.DELIVERING_ORDER.tr();
   }else if(orderVal.status==OrderPurchaseStatus.OrderDelivered){
     return AppStrings.ORDER_DELIVERED.tr();
   }else{
     return '';
   }
  }

  void updateOrderStatus(OrderPurchaseStatus status,int index){
    setState(ViewState.Busy);
    orders[index].status=status;
    setState(ViewState.Idle);
  }
  void getPackagesList()async{
    setState(ViewState.Busy);
    packages=await database.getPackagesList();
    setState(ViewState.Idle);
  }

  void initialize(ScrollController scrollController){
    Future.delayed(Duration.zero,(){
      this.scrollController = scrollController;
      this.scrollController.addListener(addScrollListener);
    });
    getAssignOrderList('courierId');

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