
import 'package:storeangelApp/ui/shared/base_model.dart';

class OrderDetailsAndChatViewModel extends BaseModel{

  bool isChatTab=false;


  void onChangeTab(bool val){
    setState(ViewState.Busy);
    isChatTab=val;
    setState(ViewState.Idle);
  }

}