
import 'package:storeangelApp/core/models/chat_message.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class CourierOrderChatViewModel extends BaseModel{

  FirebaseAbstraction _myFirebaseServices = getIt<FirebaseAbstraction>();
  Stream<List<ChatMessage>> getMessages(){
    return _myFirebaseServices.getMessageList();
  }
}