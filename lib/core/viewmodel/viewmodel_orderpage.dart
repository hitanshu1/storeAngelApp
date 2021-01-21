import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/enums/order_status.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/response_model.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class OrderPageViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();


  CourierCandidate selectCandidate;
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,BuildContext context,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value){
      StatusBarService.changeStatusBarColor(StatusBarType.Light, context);
    });
  }

  Stream<List<CourierCandidate>> getuserList(){
   return database.getCandidatesList();
  }

  void updateOrderStatus({OrderStatus orderStatus,CourierCandidate courierCandidate}){
    setState(ViewState.Busy);

    if(courierCandidate!=null){
      selectCandidate =courierCandidate;
    }

    setState(ViewState.Idle);
  }
  void onToggleFav(CourierCandidate candidate)async{
    setState(ViewState.Busy);
    candidate.favourite=!candidate.favourite;
    ResponseModel responseModel=await database.onUpdateCandidate(candidate);

    setState(ViewState.Idle);
  }
}