
import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/chat_message.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/response_model.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/base_api.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class OrderPaymentAfterWardViewModel extends BaseModel{
  FirebaseAbstraction _myFirebaseServices = getIt<FirebaseAbstraction>();
  OrderOrPurchases order;
  OrderPurchaseStatus status=OrderPurchaseStatus.OrderRunning;
  void navigatorPop() {
    navigationService.pop();
  }
  TextEditingController messageController=TextEditingController();

  void navigateToScreen(String routeName,BuildContext context,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value){
      StatusBarService.changeStatusBarColor(StatusBarType.Light, context);
    });
  }

  void pushNamedAndRemoveUntil(String routeName, {Object arguments}){
    navigationService.pushNamedAndRemoveUntil(routeName, arguments: arguments);
  }

  void initializeData(OrderOrPurchases value){
    setState(ViewState.Busy);
    order=value;
    setState(ViewState.Idle);
  }

  Stream<List<ChatMessage>> getMessages(){
    return _myFirebaseServices.getMessageList();
  }

  void onSubmitMessage(UserModel sendBy)async{
    setState(ViewState.Busy);
    ResponseModel response=await _myFirebaseServices.sendMessage(messageController.text, sendBy);
    if(response.status==1){
      messageController.clear();
    }
    setState(ViewState.Idle);
  }

  void onUpdateStatus(OrderPurchaseStatus statusValue){
    setState(ViewState.Busy);
    status=statusValue;
    setState(ViewState.Idle);
  }


}