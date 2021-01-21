import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class ProposalCongratulationViewModel extends BaseModel{

  OrderOrPurchases order;
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();

  Future getOrder(String courierId)async{
    setState(ViewState.Busy);
    order=await database.getOfferbyCourier(courierId);
    setState(ViewState.Idle);
  }

}