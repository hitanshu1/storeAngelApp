import 'package:storeangelApp/core/enums/item_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/models/participant.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/product_service.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class CourierItemDetailsViewModel extends BaseModel{
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }
  Product get currentProduct{
    if(_products.length>0){
      return _products[initialIndex];
    }else{
      return Product();
    }
  }

  List<Product>get products=>_products;
  List<Product>_products=[];
  int initialIndex=0;
  List<String>_allProductIds=[];
  List<String>_selectedClientsIds=[];
  List<Product>_allProducts=[];
  List<ClientDetails>selectedClients=[];
  List<ClientDetails>clients=[];

  OrderByStore orderByStore;


  bool get isSelectAll=>selectedClients.length==clients.length;
  void initializeData(List<Product>productValues,Product initialValue,List<ClientDetails>clientValues,OrderByStore orderByStoreVal){
    setState(ViewState.Busy);
    _allProducts=productValues;
    orderByStore=orderByStoreVal;
    clients=clientValues;
    orderByStoreVal.participants.forEach((participant) {
      selectedClients.add(participant.clientDetails);
      _selectedClientsIds.add(participant.clientDetails.id);
    });
    _getProducts();
    for (int i=0;i<_products.length;i++){
      if(initialValue!=null){
        if(_products[i].id==initialValue.id){
          initialIndex=i;
        }
      }
    }
    setState(ViewState.Idle);
  }

  void setSelectedIndex(int val){
    setState(ViewState.Busy);
    initialIndex=val;
    setState(ViewState.Idle);
  }

  void _getProducts(){
    _allProductIds=[];
    _products=[];
    for (Participant participant in orderByStore.participants){
      if(_selectedClientsIds.contains(participant.clientDetails.id)){
        for(Product productVal in participant.products){
          if(_allProductIds.contains(productVal.id)){
            _products.forEach((element) {
              if(element.id==productVal.id){
                if(element.itemStatus==ItemStatus.Selected&&productVal.itemStatus!=ItemStatus.Selected){
                  element.itemStatus=ItemStatus.Few;
                }else if(element.itemStatus!=ItemStatus.Selected&&productVal.itemStatus==ItemStatus.Selected){
                  element.itemStatus=ItemStatus.Few;
                }
                element.quantity=element.originQuantity+productVal.originQuantity;
                element.alternativeProduct.addAll(productVal.alternativeProduct);
                List<Product>_alternativeProduct=[];
                for (var k = 0; k < element.alternativeProduct.length; k++) {
                  bool repeated = false;
                  for (var j = 0; j < _alternativeProduct.length; j++) {
                    if (element.alternativeProduct[k].id == _alternativeProduct[j].id) {
                      if( _alternativeProduct[j].alterNativeAddedClients!=null){
                        _alternativeProduct[j].alterNativeAddedClients.add( productVal.assignClient);
                      }else{
                        _alternativeProduct[j].alterNativeAddedClients=[];
                        _alternativeProduct[j].alterNativeAddedClients.add( productVal.assignClient);
                      }
                      repeated = true;
                    }
                  }
                  if (!repeated) {
                    _alternativeProduct.add(element.alternativeProduct[k]);
                  }
                }
                element.alternativeProduct=_alternativeProduct;
              }
            });
          }else{
            productVal.quantity=productVal.originQuantity;
            productVal.alternativeProduct.forEach((element) {
              element.alterNativeAddedClients=[productVal.assignClient];
            });
            _allProductIds.add(productVal.id);
            _products.add(productVal);
          }
        }

      }
    }
  }
  void onSelectClient(ClientDetails client){
    setState(ViewState.Busy);
    if(_products.length>0){
      _products[initialIndex].itemStatus=ItemStatus.UnSelected;
    }
    if(selectedClients.contains(client)){
      selectedClients.remove(client);
      _selectedClientsIds.remove(client.id);
    }else{
      _selectedClientsIds.add(client.id);
      selectedClients.add(client);
    }
    _getProducts();
    setState(ViewState.Idle);
  }

  void onClickProductStatus(int index) {
    setState(ViewState.Busy);
     selectedClients.forEach((_client) {
      for (Participant participant in orderByStore.participants){
        if(participant.clientDetails.id==_client.id){
          for(Product product in participant.products){
            if(product.id==_products[index].id){
              ProductService.updateProductStatus(product);
            }
          }
        }
      }
     });

   _getProducts();
   setState(ViewState.Idle);
  }
}