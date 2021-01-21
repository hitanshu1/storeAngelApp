
import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/models/chat_message.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/response_model.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/base_api.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';


class CourierChatTabViewModel extends BaseModel{
  FirebaseAbstraction _myFirebaseServices = getIt<FirebaseAbstraction>();

  TextEditingController messageController=TextEditingController();
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }
  OrderOrPurchases order;
  UserModel selectedClient;

  void initializeData(OrderOrPurchases value){
    setState(ViewState.Busy);
    order=value;
    selectedClient=value.clientlist.first;
    setState(ViewState.Idle);
  }

  void onSelectClient(UserModel client){
    setState(ViewState.Busy);
    selectedClient=client;
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

}