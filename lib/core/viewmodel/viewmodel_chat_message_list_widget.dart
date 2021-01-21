
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class ChatMessageListViewModel extends BaseModel{
  void navigatorPop() {
    navigationService.pop();
  }

  Future<void> navigateToScreen(String routeName,{Object arguments,Function onPop}) async{
    await navigationService.navigateTo(routeName, arguments: arguments).then((value){
      if(onPop!=null){
        onPop();
      }
    });
  }

  bool hasPayedBack = false;

  set setHasPayedBack(bool val){
    hasPayedBack = val;
    setState(ViewState.Idle);
  }

  void initialized(){
  }

  int chatListLength(OrderPurchaseStatus status,int chatLength,bool prePaid){
    if(status == OrderPurchaseStatus.OrderRunning){
      return chatLength+1;
    }else if(status == OrderPurchaseStatus.MoneyTransfer && !prePaid){
      return chatLength+1;
    }else{
      return chatLength;
    }
  }
}