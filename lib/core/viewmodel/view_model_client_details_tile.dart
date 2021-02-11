
import 'package:storeangelApp/core/enums/item_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/participant.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/product_service.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class ClientDetailsTileViewModel extends BaseModel{
  List<Product>products=[];


  bool showProduct=false;

  void toggleShowProductList(){
    setState(ViewState.Busy);
    showProduct=!showProduct;
    setState(ViewState.Idle);
  }
  int get selctedProduct{
    int val=0;
    participant.products.forEach((product) {
      if(product.itemStatus==ItemStatus.Selected){
        val++;
      }
    });
    return val;
  }

  Participant participant;

  void initializeValue(Participant val){
    setState(ViewState.Busy);
    participant=val;

    setState(ViewState.Idle);
  }
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }



  void getProductList(ClientDetails clientDetails,List<Product>productValues){
    setState(ViewState.Busy);
    for (Product val in productValues){
      if(val.assignClient.id==clientDetails.id){
        val.quantity=val.originQuantity;
        products.add(val);
      }
    }
    setState(ViewState.Idle);
  }

 void onUpdateStatus(Product productVal){
    setState(ViewState.Busy);
    ProductService.updateProductStatus(productVal);
    setState(ViewState.Idle);
 }


}