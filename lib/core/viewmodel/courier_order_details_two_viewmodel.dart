import 'package:storeangelApp/core/enums/item_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/models/participant.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class CourierOrderDetailsTwoViewModel extends BaseModel{
OrderByStore orderByStore;
ClientDetails selectedClient;
List<ClientDetails>selectedClients=[];
FirebaseAbstraction _myFirebaseServices = getIt<FirebaseAbstraction>();

List<Product>get products=>_products;
List<Product>_products=[];
List<String>_allProductIds=[];
List<String>_selectedClientsIds=[];
List<Product>_allProducts=[];

void initialiseData(OrderByStore val){
  setState(ViewState.Busy);
//  orderByStore=val;
//  selectedClient=val.clients.first;
  orderByStore=val;
  orderByStore.participants.forEach((participant) {
    selectedClients.add(participant.clientDetails);
    _selectedClientsIds.add(participant.clientDetails.id);
  });
  _getProducts();
  setState(ViewState.Idle);
}

void _getProducts(){
  _allProductIds=[];
  _products=[];
  for (Participant participant in orderByStore.participants){
    if(_selectedClientsIds.contains(participant.clientDetails.id)){
      for(Product productVal in participant.products){
        if(_allProductIds.contains(productVal.id)){


          for(int i=0;i<_products.length;i++){
            if(_products[i].id==productVal.id){
              if(productVal.itemStatus==ItemStatus.Selected){
                _products[i].quantity=_products[i].originQuantity+productVal.originQuantity;
              }



            }
          }
      }else{
          productVal.quantity=productVal.originQuantity;
          print('${productVal.name}====${productVal.itemStatus}');

          if(productVal.itemStatus==ItemStatus.Few||productVal.itemStatus==ItemStatus.Selected){
            _allProductIds.add(productVal.id);
            _products.add(productVal);
            _allProducts.add(productVal);
          }


        }
    }
  }

  }
}

double clientViewOpacity(ClientDetails client){
  if(selectedClients.contains(client)){
    return 1;
  }else{
    return .2;
  }

}
bool isSelected(ClientDetails client){
  if(selectedClients.contains(client)){
    return true;
  }else{
    return false;
  }


}

void onSelectClient(ClientDetails client){
  setState(ViewState.Busy);
  if(selectedClients.contains(client)){
    selectedClients.remove(client);
    _selectedClientsIds.remove(client.id);
  }else{
    selectedClient=client;
    _selectedClientsIds.add(client.id);
    selectedClients.add(client);
  }
  _getProducts();
  setState(ViewState.Idle);
}




}
