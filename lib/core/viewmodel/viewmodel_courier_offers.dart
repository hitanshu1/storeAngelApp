import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/base_api.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class CourierOffersViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  bool viewDetails=false;
  ScrollController scrollController;

  bool hasShadow = false;

  List<OrderOrPurchases>offerOrders=[];
  List<OrderOrPurchases>declineOffers=[];
  int acceptedOrders=0;

  void toggleView(){
    setState(ViewState.Busy);
    viewDetails=!viewDetails;
    setState(ViewState.Idle);
  }
  Future getAssignOrderList(String courierId)async{
    setState(ViewState.Busy);
    offerOrders=await database.getOfferOrderForCourier(courierId);
    declineOffers=await database.getDeclineOfferOrderForCourier(courierId);
    acceptedOrders=0;

    setState(ViewState.Idle);
  }

  void initialize(ScrollController scrollController){
    Future.delayed(Duration.zero,(){
      this.scrollController = scrollController;
      this.scrollController.addListener(addScrollListener);
    });
    getAssignOrderList('courierId');
  }

  void navigateTo(String routeName, Object arguments, BuildContext context)async{
    await navigationService.navigateTo(routeName, arguments: arguments);
    StatusBarService.changeStatusBarColor(StatusBarType.Dark, context);
  }

  void addScrollListener(){
    if(scrollController.position.pixels==0){
      hasShadow = false;
    }else{
      hasShadow = true;
    }
    setState(ViewState.Idle);
  }

}