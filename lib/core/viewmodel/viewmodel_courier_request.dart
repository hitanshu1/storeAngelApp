import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/screens/courier/request_details_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import '../../getIt.dart';

class CourierRequestViewModel extends BaseModel{

  FirebaseAbstraction database=getIt<FirebaseAbstraction>();

  List<StoreDataModel>stores=[];

  List<StoreDataModel>selectedStore=[];

  List<OrderOrPurchases>_assignOrders=[];
  List<OrderOrPurchases>_orderData=[];

  bool reverse=false;
  UserModel userDetails;

  List<OrderOrPurchases> get assignOrders{
    if(reverse){
      return  _assignOrders.reversed.toList();
    }else{
      return _assignOrders;
    }
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

  Future getAssignOrderList(String courierId,String userID)async{
    setState(ViewState.Busy);
    userDetails= await database.getUserDetails(userID);
    _orderData=await database.getAssignOrderForCourier(courierId);
    _assignOrders=_orderData;

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


    setState(ViewState.Idle);
  }
  void onSelectStore(StoreDataModel storeVal){
    setState(ViewState.Busy);
    if(selectedStore.contains(storeVal)){
      selectedStore.remove(storeVal);


    }else{
      selectedStore.add(storeVal);
    }
    _assignOrders=[];
    _orderData.forEach((element) {
      for (int i = 0; i < selectedStore.length; i++){
        if(selectedStore[i].id==element.storeDetails.id){
          _assignOrders.add(element);
        }
      }
    });
    setState(ViewState.Idle);
  }

  void onReverse(){
    setState(ViewState.Busy);
    reverse=!reverse;
    setState(ViewState.Idle);
  }

  Future<void> navigateToOrderInformationScreen(OrderOrPurchases order)async{
    await navigationService.navigateTo(RequestDetailsScreen.routeName, arguments: order);
  }
}