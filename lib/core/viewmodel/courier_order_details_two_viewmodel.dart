import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class CourierOrderDetailsTwoViewModel extends BaseModel{
OrderByStore orderByStore;
ClientDetails selectedClient;

void initialiseData(OrderByStore val){
  setState(ViewState.Busy);
  orderByStore=val;
  selectedClient=val.clients.first;
  setState(ViewState.Idle);
}


void onSelectClient(ClientDetails client){
  setState(ViewState.Busy);
  selectedClient=client;
  setState(ViewState.Idle);
}

double clientViewOpacity(ClientDetails client){
    if(selectedClient!=client){
      return .2;
    }else{
      return 1;
    }

}
}
