
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/models/participant.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

enum CourierOrderSummeryView{Repayment,RepaymentDone}

class CourierOrderSummeryViewModel extends BaseModel{
  OrderByStore orderByStore;
  ClientDetails clientDetails;
  Participant participant;
  CourierOrderSummeryView view=CourierOrderSummeryView.Repayment;
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }

  void initializeData(OrderByStore orderVal, ClientDetails clientVal, Participant participantVal){
    setState(ViewState.Busy);
    orderByStore=orderVal;
    participant=participantVal;
    participant.status=OrderPurchaseStatus.OrderDelivered;
    clientDetails=clientVal;
    setState(ViewState.Idle);
  }

  void onRepayment(){
    setState(ViewState.Busy);
    view=CourierOrderSummeryView.RepaymentDone;
    setState(ViewState.Idle);
  }
  void onCancel(){
    setState(ViewState.Busy);
    participant.status=OrderPurchaseStatus.OrderRunning;
    navigationService.pop();
    navigationService.pop();


    setState(ViewState.Idle);
  }

  void onEndOrder(){
    navigationService.pop();
    navigationService.pop();
    navigationService.pop();
  }
}