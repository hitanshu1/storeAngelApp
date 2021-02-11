
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class PremiumFirstScreenViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  List<StoreDataModel>stores=[];
  void initializeData()async{
    setState(ViewState.Busy);
    stores=await database.getStoreData();
    setState(ViewState.Idle);

  }

}