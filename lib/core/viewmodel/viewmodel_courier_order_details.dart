
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class CourierOrderDetailsViewModel extends BaseModel{
  bool isGrocery=true;

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



}