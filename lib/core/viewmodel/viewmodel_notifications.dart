import 'package:storeangelApp/ui/shared/base_model.dart';

class NotificationViewModel extends BaseModel{
  bool notification=false;
  bool outOfStock=false;
  bool newMessage=false;
  bool deliveryStatus=false;
  bool cancelledOrder=false;

  void changeNotification(value){
    notification=value;
    setState(ViewState.Idle);

  }
  void changeOutOfStock(value){
    outOfStock=value;
    setState(ViewState.Idle);

  }
  void changeNewMessage(value){
    newMessage=value;
    setState(ViewState.Idle);

  }
  void changeDeliveryStatus(value){
    deliveryStatus=value;
    setState(ViewState.Idle);

  }
  void changeCancelledOrder(value){
    cancelledOrder=value;
    setState(ViewState.Idle);

  }


}