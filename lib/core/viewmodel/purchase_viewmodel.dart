
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/widgets/purchase/purchase_checkbox.dart';

class PurchaseViewModel extends BaseModel{

  FirebaseAbstraction _myFirebaseServices = getIt<FirebaseAbstraction>();

  PurchaseDetails purchaseDetails;

  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }

  void updatePurchaseDetails(int index, PurchaseCheckBoxStatus status){
    if(purchaseDetails.products!=null&&(purchaseDetails.products?.isNotEmpty??false)){
      if(status==PurchaseCheckBoxStatus.Selected){
        purchaseDetails.products[index].selected = true;
      }else{
        purchaseDetails.products[index].selected = false;
      }
      setState(ViewState.Idle);
    }
  }

  void getPurchaseDetails(String id)async{
    setState(ViewState.Busy);
    purchaseDetails=await _myFirebaseServices.getPurchaseDetails(id);
    setState(ViewState.Idle);
  }


}