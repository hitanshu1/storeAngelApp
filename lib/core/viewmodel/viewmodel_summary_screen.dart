
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class SummaryViewModel extends BaseModel{


   OrderOrPurchases orPurchases;
   CourierCandidate candidate;

   double get totalPrice=>orPurchases.purchaseDetails.totalAmount+candidate.charge;

   void initializeData(OrderOrPurchases orPurchasesVal,CourierCandidate candidateVal){
     setState(ViewState.Busy);
     orPurchases=orPurchasesVal;
     candidate=candidateVal;
     setState(ViewState.Idle);
   }

   void navigatorPop() {
     navigationService.pop();
   }
   void navigateToScreen(String routeName,{Object arguments}) {
     navigationService.navigateTo(routeName, arguments: arguments);
   }

}