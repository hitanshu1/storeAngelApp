import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/enums/item_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/models/participant.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/product_service.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../getIt.dart';
class CourierOrderDetailsTabOneViewModel extends BaseModel{
  bool isChat=false;
  bool changePage=false;
  bool viewClientsList=false;
  OrderByStore orderByStore;
  ClientDetails selectedClient;
  List<ClientDetails>selectedClients=[];
  FirebaseAbstraction _myFirebaseServices = getIt<FirebaseAbstraction>();

  bool get isSelectAll=>selectedClients.length==orderByStore.clients.length;


  List<Product>get products=>_products;
  List<Product>_products=[];

  List<String>_allProductIds=[];
  List<String>_selectedClientsIds=[];
  List<Product>_allProducts=[];


  void initialiseData(OrderByStore val){
    setState(ViewState.Busy);
    orderByStore=val;
  orderByStore.participants.forEach((participant) {
    selectedClients.add(participant.clientDetails);
    _selectedClientsIds.add(participant.clientDetails.id);
  });
    _getProducts();
    setState(ViewState.Idle);
  }

  void onChangeItemView(){

  }

  void onSelectAll(){
    selectedClients=[];
    _selectedClientsIds=[];
    setState(ViewState.Busy);
    orderByStore.clients.forEach((clientVal) {
      selectedClients.add(clientVal);
      _selectedClientsIds.add(clientVal.id);
    });
    _getProducts();
    setState(ViewState.Idle);
  }

  void _getProducts(){
    _allProductIds=[];
    _products=[];
    for (Participant participantVal in orderByStore.participants){
      if(_selectedClientsIds.contains(participantVal.clientDetails.id)){
       for(Product productVal in participantVal.products){
         if(_allProductIds.contains(productVal.id)){
           _products.forEach((element) {
             if(element.id==productVal.id){
               if(element.itemStatus==ItemStatus.Selected&&productVal.itemStatus!=ItemStatus.Selected){
                 element.itemStatus=ItemStatus.Few;
               }else if(element.itemStatus!=ItemStatus.Selected&&productVal.itemStatus==ItemStatus.Selected){
                 element.itemStatus=ItemStatus.Few;
               }
               if(element.id==productVal.id){
                 element.quantity=element.originQuantity+productVal.originQuantity;
               }
             }
           });
         }else{
           productVal.quantity=productVal.originQuantity;
           _allProductIds.add(productVal.id);
           _products.add(productVal);
           _allProducts.add(productVal);
         }
       }
      }
    }
  }

  void onChangeValue(bool val){
    setState(ViewState.Busy);
    isChat=val;

    setState(ViewState.Idle);
  }

  void onSelectClient(ClientDetails client){
    setState(ViewState.Busy);
    if(isChat){
      selectedClient=client;
    }else{

      if(selectedClients.contains(client)){
        selectedClients.remove(client);
        _selectedClientsIds.remove(client.id);
      }else{
        selectedClient=client;
        _selectedClientsIds.add(client.id);
        selectedClients.add(client);
      }
      _getProducts();

    }
    setState(ViewState.Idle);
  }

  double clientViewOpacity(ClientDetails client){
    if(isChat){
      if(selectedClient!=client){
        return .2;
      }else{
        return 1;
      }
    }else{
      if(selectedClients.contains(client)){
        return 1;
      }else{
        return .2;
      }
    }

  }
  bool isSelected(ClientDetails client){
    if(isChat){
      return selectedClient==client;
    }else{
      if(selectedClients.contains(client)){
        return true;
      }else{
        return false;
      }
    }


  }

  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value) {
      _getProducts();
    });
  }

  void onClickShopping()async{
    setState(ViewState.Busy);


    bool _allSelected= _products.every((pVal){
      if(pVal.itemStatus!=ItemStatus.UnSelected){
        return true;
      }else{
        return false;
      }
    });

    if(_allSelected){
      changePage=true;

    }else{

    MyUtils().toastdisplay(AppStrings.PLEASE_SELECT_ALL_PRODUCT.tr());

   }


    setState(ViewState.Idle);
  }

  void onChangeProductStatus(int index){
    setState(ViewState.Busy);
    orderByStore.participants.forEach((participant) {
      participant.products.forEach((productVal) {
        if(productVal.id==_products[index].id){
          ProductService.updateProductStatus(productVal);
        }
      });
    });

    setState(ViewState.Idle);
  }

  Stream<int>clientUnreadMessage(String userID,String otherUserID){
    return _myFirebaseServices.userUnreadMessage(otherUserID, userID);
  }
}