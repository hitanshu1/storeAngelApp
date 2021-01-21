
import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class ItemSearchViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  TextEditingController searchController=TextEditingController();

  List<Product>products=[];

  void onSearchText(String val)async{
    setState(ViewState.Busy);
    products=[];
    products=await database.onSeachProduct(val);

    print(products.length);
    setState(ViewState.Idle);
  }
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }


}