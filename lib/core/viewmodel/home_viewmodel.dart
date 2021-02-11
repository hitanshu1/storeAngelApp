import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/places_all_model.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class HomeViewModel extends BaseModel {
  List<Place> places = <Place>[];
  List<PurchaseDetails>watchlist=[];
  List<PurchaseDetails>notificationList=[];
  List<PurchaseDetails>inspireList=[];
  UserModel user=UserModel();
  var location = new Location();
  FirebaseAbstraction _myFirebaseServices = getIt<FirebaseAbstraction>();
  bool running=true;
  double _latitude;
  double _longitude;
  List<OrderOrPurchases>orderList=[];
  List<OrderOrPurchases>completedOrders=[];

  int selectedIndex = 0;

  void setSelectedIndex(int index){
    selectedIndex = index;
    setState(ViewState.Idle);
  }

  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,BuildContext context,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
//        .then((value){
//      StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
//    });
  }

  void initialize(String userID){

    getUserNotificationList(userID);

    getOrderList(running);
  }

  Future<List<Place>> getAllPlaces(String placeName) async {
    setState(ViewState.Busy);
    try {
      LocationData currentLocation = await location.getLocation();

      _latitude = currentLocation.latitude;

      _longitude = currentLocation.longitude;

    } catch (e) {
      print(e);
    }

    var uri = Uri.parse(
        AppConstants.googleQueryLink +
            placeName +
            "&location=" +
            _latitude.toString() +
            "," +
            _longitude.toString() +
            "&radius=4000");

    final response = await http.get(uri, headers: {"Accept": "application/json"});

    List data = json.decode(response.body)["predictions"];

    places.clear();
//    data.forEach((f) => places.add(new Place(
//          f["structured_formatting"]["main_text"],
//          f["description"]
//        )));
    data.forEach((f) => places.add(new Place(
      name: f["structured_formatting"]["main_text"]
    )));

    setState(ViewState.Idle);

    return places;
  }
  void changeView(bool value){
    setState(ViewState.Busy);
    running=value;
    setState(ViewState.Idle);
  }

  Future getOrderList(bool value)async{
    setState(ViewState.Busy);
    orderList =await _myFirebaseServices.getOrderList();
    completedOrders=await _myFirebaseServices.getCompletedOrders();
    setState(ViewState.Idle);


  }

  Future getUserWatchlist()async{
    setState(ViewState.Busy);
    watchlist=await _myFirebaseServices.getUserWishList('useId');
    setState(ViewState.Idle);

  }

  Future getUserNotificationList(String userId)async{
    setState(ViewState.Busy);
    user=await _myFirebaseServices.getUserDetails(userId);


    //List is not supposed to be longer than 10 items
    List<PurchaseDetails> list =(await _myFirebaseServices.getUserNotificationList('useId'));
    notificationList = list.take(2).toList();
    inspireList=list.take(10).toList();
    final result=await _myFirebaseServices.getOrderProposal('SRr3JaSxGuoLSJ3tgwmo').first;

    setState(ViewState.Idle);
  }

}
