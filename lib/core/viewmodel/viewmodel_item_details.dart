
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class ItemDetailsViewModel extends BaseModel{
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }


  Product get currentProduct=>products[initialIndex];

  List<Product>products=[];
  int initialIndex=0;

  void initializeData(List<Product>productValues,int initialValue){
    setState(ViewState.Busy);
    products=productValues;
    initialIndex=initialValue;

    setState(ViewState.Idle);
  }

  void setSelectedIndex(int val){
    setState(ViewState.Busy);
    initialIndex=val;
    setState(ViewState.Idle);
  }

}