
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:easy_localization/easy_localization.dart';


enum CourierOrderView{ProductListAndChat,CheckPrices,DeliveryAddress}

class CourierOrderDetailsViewModel extends BaseModel{
  bool isGrocery=true;
  bool showAllTogether=true;

  CourierOrderView view=CourierOrderView.ProductListAndChat;

  OrderByStore orderByStore;
  ClientDetails selectedClient;
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }

  void initialiseData(OrderByStore val){
    setState(ViewState.Busy);
    orderByStore=val;
    setState(ViewState.Idle);
  }
  void onToggleShowAll(){
    setState(ViewState.Busy);
    showAllTogether=!showAllTogether;
    setState(ViewState.Idle);
  }

  void onToggleTabView(){
    setState(ViewState.Busy);
    isGrocery=!isGrocery;
    if(!isGrocery){
      selectedClient=orderByStore.clients.first;
    }
    setState(ViewState.Idle);
  }

  void onSelectClient(ClientDetails client){
    setState(ViewState.Busy);
    selectedClient=client;
    setState(ViewState.Idle);
  }

  double clientViewOpacity(ClientDetails client){
    if(isGrocery){
      return 1;
    }else{
      if(selectedClient!=client){
        return .2;
      }else{
        return 1;
      }
    }
  }

  void onPlaceOrder(){

    print('working');
    setState(ViewState.Busy);
    orderByStore.status=OrderPurchaseStatus.OrderPlaced;
    setState(ViewState.Idle);
  }

  void onChangeView(CourierOrderView val){
    setState(ViewState.Busy);
    if(view==CourierOrderView.CheckPrices){

      orderByStore.status=OrderPurchaseStatus.OrderRunning;
      orderByStore.participants.forEach((participant) {
        participant.status=OrderPurchaseStatus.OrderRunning;
      });
    }
    view=val;

    setState(ViewState.Idle);
  }
String get titleString{
    if(view==CourierOrderView.CheckPrices){
      return AppStrings.CHECK_PRICES.tr();
    }else if(view==CourierOrderView.DeliveryAddress){
      return AppStrings.IN_SERVICE.tr();
    }
    return AppStrings.PURCHASING_ACTIVE.tr();
}

void onCancel(){
    setState(ViewState.Busy);
     view=CourierOrderView.ProductListAndChat;
    orderByStore.status=OrderPurchaseStatus.InOrder;
    navigationService.pop();
    setState(ViewState.Idle);
}


}