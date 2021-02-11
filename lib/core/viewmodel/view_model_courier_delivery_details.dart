import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class CourierDeliveryDetailsViewModel extends BaseModel{

  OrderByStore orderByStore;

  void initializeData(OrderByStore orderVal){
    setState(ViewState.Busy);
    orderByStore=orderVal;
    setState(ViewState.Idle);
  }
}