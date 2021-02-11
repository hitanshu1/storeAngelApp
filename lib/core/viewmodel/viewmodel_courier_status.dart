import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/enums/order_status.dart';
import 'package:storeangelApp/core/models/chat_message.dart';
import 'package:storeangelApp/core/models/response_model.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class CourierStatusViewModel extends BaseModel{
  OrderStatus orderStatus=OrderStatus.Ontheway;
  FirebaseAbstraction _myFirebaseServices = getIt<FirebaseAbstraction>();

  TextEditingController messageController=TextEditingController();
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }

  void pushNamedAndRemoveUntil(String routeName, {Object arguments}){
    navigationService.pushNamedAndRemoveUntil(routeName, arguments: arguments);
  }

  OrderPurchaseStatus status=OrderPurchaseStatus.OrderPlaced;

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
}
