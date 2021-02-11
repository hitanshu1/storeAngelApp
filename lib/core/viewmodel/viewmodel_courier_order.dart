
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/models/package_model.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/base_api.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/screens/premium_first_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
class CourierOrderViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  bool viewDetails=false;
  ScrollController scrollController;
  bool hasShadow = false;
  UserModel userDetails;

  List<OrderByStore> get orders{
   List<OrderByStore>_order=[];
   _assignOrders.forEach((val) {
     if(val.status==OrderPurchaseStatus.InOrder){
       _order.add(val);
     }
   });
   return _order;
  }
  List<OrderByStore>get runningOrders{
    List<OrderByStore>_order=[];
    _assignOrders.forEach((val) {
      if(val.status!=OrderPurchaseStatus.InOrder&&val.status!=OrderPurchaseStatus.OrderDelivered&&val.status!=OrderPurchaseStatus.Rejected){
        _order.add(val);
      }

    });

    return _order;
  }
  List<OrderByStore>get pastedOrders{
    List<OrderByStore>_order=[];
    _order.addAll(_pastedOrders);
    _assignOrders.forEach((val) {
      if(val.status==OrderPurchaseStatus.OrderDelivered){
        _order.add(val);
      }
    });
    return _order;
  }
  List<OrderByStore>_pastedOrders=[];
  List<PackageModel>packages=[];
  List<StoreDataModel>stores;
  List<String>selectedStoreIDs=[];


  List<OrderByStore>orderByStoreList=[];

  List<StoreDataModel>selectedStore=[];

  List<OrderByStore>_assignOrders=[];
  List<OrderByStore>_orderData=[];


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
      setState(ViewState.Idle);
    });
  }
  void onSelectStore(StoreDataModel storeVal,int index){
    setState(ViewState.Busy);
    if(selectedStore.contains(storeVal)){
      selectedStore.remove(storeVal);


    }else{
      if(userDetails.premium){
        selectedStore.add(storeVal);
      }else{

        if(index<3){
          selectedStore.add(storeVal);
        }else{
          navigationService.navigateTo(PremiumFirstScreen.routeName);
        }
      }


    }
    _getOrderList();
    setState(ViewState.Idle);
  }
  void _getOrderList(){
    _assignOrders=[];
    _orderData.forEach((element) {
      for (int i = 0; i < selectedStore.length; i++){
        if(selectedStore[i].id==element.storeDetails.id){
          _assignOrders.add(element);
        }
      }
    });
  }

  double storeOpacity(int index){
    if(userDetails.premium){
      if(selectedStore.contains(stores[index])){
        return 1;
      }else{
        return .7;
      }
    }else{
      if(index<3){
        if(selectedStore.contains(stores[index])){
          return 1;
        }else{
          return .7;
        }
      }
      return .1;
    }
  }

  void toggleView(){
    setState(ViewState.Busy);
    viewDetails=!viewDetails;
    setState(ViewState.Idle);
  }
  Future getAssignOrderList(String courierId,String userID)async{
    setState(ViewState.Busy);
    userDetails= await database.getUserDetails(userID);

    _orderData=await database.getOrderByStoreList();
    _orderData.forEach((element) {
      _assignOrders.add(element);
    });
    _pastedOrders=await database.getPastOrders(courierId);
    stores=await database.getStoreData();

    for (int i=0;i<stores.length;i++){
      if(userDetails.premium){
        selectedStore.add(stores[i]);
      }else{
        if(i<3){
          selectedStore.add(stores[i]);
        }
      }
    }
    orderByStoreList=await database.getOrderByStoreList();

    setState(ViewState.Idle);
  }

  String  getStatusTitle(OrderOrPurchases orderVal) {
   if(orderVal.status==OrderPurchaseStatus.PlaceAOrder){
     return AppStrings.PENDING_PAYMENT.tr();
   }else if(orderVal.status==OrderPurchaseStatus.MoneyTransfer){
     return AppStrings.PAYMENT_RECEIVED.tr();
   }else if(orderVal.status==OrderPurchaseStatus.OrderPlaced){
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
    _assignOrders[index].status=status;
    setState(ViewState.Idle);
  }
  void getPackagesList()async{
    setState(ViewState.Busy);
    packages=await database.getPackagesList();
    setState(ViewState.Idle);
  }

  void initialize(ScrollController scrollController,String userID)async{
    Future.delayed(Duration.zero,(){
      this.scrollController = scrollController;
      this.scrollController.addListener(addScrollListener);
    });

    getAssignOrderList('courierId',userID);

  }

  void addScrollListener(){
    if(scrollController.position.pixels==0){
      hasShadow = false;
    }else{
      hasShadow = true;
    }
    setState(ViewState.Idle);
  }
  void onDeletePurchase(OrderByStore orderByStore){
    setState(ViewState.Busy);
    _orderData.remove(orderByStore);
    _assignOrders.remove(orderByStore);
    setState(ViewState.Idle);
  }
}