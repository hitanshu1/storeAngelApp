
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class CourierOrderDetailsTabOneViewModel extends BaseModel{
  bool isChat=false;

  OrderByStore orderByStore;
  ClientDetails selectedClient;

  void initialiseData(OrderByStore val){
    setState(ViewState.Busy);
    orderByStore=val;
    setState(ViewState.Idle);
  }

  void onChangeValue(bool val){
    setState(ViewState.Busy);
    isChat=val;
    if(isChat){
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
    if(!isChat){
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