import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class WatchListViewModel extends BaseModel {
  bool hasShadow = false;
  ScrollController scrollController;

  FirebaseAbstraction _myFirebaseServices = getIt<FirebaseAbstraction>();
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,BuildContext context,{Object arguments,}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value) {
      StatusBarService.changeStatusBarColor(StatusBarType.Dark,context);
    });
  }

  void initialize(ScrollController scrollController){
    Future.delayed(Duration.zero,(){
      this.scrollController = scrollController;
      this.scrollController.addListener(addScrollListener);
    });
    getUserWishList();
  }

  void addScrollListener(){
    if(scrollController.position.pixels==0){
      hasShadow = false;
    }else{
      hasShadow = true;
    }
    setState(ViewState.Idle);
  }

  List<PurchaseDetails>wishList=[];
  void getUserWishList()async{
    setState(ViewState.Busy);
    wishList=await _myFirebaseServices.getUserWishList('useId');
    setState(ViewState.Idle);

  }

}
