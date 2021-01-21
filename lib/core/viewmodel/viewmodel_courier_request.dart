import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/screens/courier/request_details_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import '../../getIt.dart';

class CourierRequestViewModel extends BaseModel{

  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  List<OrderOrPurchases>assignOrders=[];
  List<StoreDataModel>stores;

  Future getAssignOrderList(String courierId)async{
    setState(ViewState.Busy);
    assignOrders=await database.getAssignOrderForCourier(courierId);

    print('length==${assignOrders.length}');
    stores=await database.getStoreData();

    setState(ViewState.Idle);
  }

  Future<void> navigatetoOrderInformationScreen(int index)async{
    await navigationService.navigateTo(RequestDetailsScreen.routeName, arguments: assignOrders[index]);
  }
}