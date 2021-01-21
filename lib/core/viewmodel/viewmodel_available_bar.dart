import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class AvailableBarViewModel extends BaseModel{
  int available=0;
  int unavailable=0;
  int someAvailable=0;

  void initializeData(List<Product>products){
    setState(ViewState.Busy);
   products.forEach((pElement) {
      if(pElement.availableStatus==AvailableStatus.plenty){
        available+=pElement.quantity;
      }else if(pElement.availableStatus==AvailableStatus.few){
        someAvailable+=pElement.quantity;
      }else if(pElement.availableStatus==AvailableStatus.runOut){
        unavailable+=pElement.quantity;
      }
   });
   setState(ViewState.Idle);
  }
}