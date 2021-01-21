
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/ui/screens/consumer/order_details_and_chat_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/summery_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';

class CourierCandidateDetailsViewModel extends BaseModel{


  int initialIndex=0;
  List<CourierCandidate>candidates=[];

  CourierCandidate get currentCandidate=>candidates[initialIndex];
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }



  void initialiseData(int index,List<CourierCandidate>values){
    setState(ViewState.Busy);
    initialIndex=index;
    candidates=values;
    setState(ViewState.Idle);
  }
  void setSelectedIndex(index){
    setState(ViewState.Busy);
    initialIndex=index;
    setState(ViewState.Idle);
  }
  void onSubmit(OrderOrPurchases order){
    if(order.status==OrderPurchaseStatus.Pending){
      navigateToScreen(SummeryScreen.routeName,
          arguments: SummeryScreenArgument(
              orPurchases: order,
              candidate: currentCandidate
          ));
    }else{
      navigateToScreen(OrderDetailsAndChatScreen.routeName,
          arguments: OrderDetailsAndChatScreenArguments(
              orPurchases: order,
              candidate: currentCandidate
          ));
    }
  }


}