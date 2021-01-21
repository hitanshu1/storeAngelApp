
import 'package:storeangelApp/core/models/address.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class MyAddressesViewModel extends BaseModel{

  FirebaseAbstraction database=getIt<FirebaseAbstraction>();

  List<AddressModel>userAddresses=[];

  Future getUserAddresses(String userId)async{

    setState(ViewState.Busy);

    userAddresses=await database.getUserAddresses(userId);
    setState(ViewState.Idle);

  }
}