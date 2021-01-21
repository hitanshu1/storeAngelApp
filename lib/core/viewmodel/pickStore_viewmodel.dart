import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/enums/user_type.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/places_all_model.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:storeangelApp/ui/screens/courier/courier_signup_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../ui/shared/base_model.dart';
import '../consts/appConstants.dart';

class PickStoreViewModel extends BaseModel {
  List<Place> places = <Place>[];
  FocusNode textFieldNode;
  TextEditingController searchController = TextEditingController();

  //data List from database (placeholder or real doesnt matter)
  List<StoreDataModel> _storeDetailList = [];

  List<StoreDataModel> get storeDetailList => _storeDetailList;
  List<StoreDataModel> _searchList = <StoreDataModel>[];

  FirebaseAbstraction _myFirebaseServices = getIt<FirebaseAbstraction>();

  //Counter of the picked stores
  int _pickedStoreCount = 0;

  int get pickedStoreCount => _pickedStoreCount;

  //Store Item List of the selectedStores
  List<StoreDataModel> selectedStoreList = [];

  List<StoreDataModel> get searchList => _searchList;

  //Is done button visible variable
  bool _isDoneButtonVisible = false;

  bool get isDoneButtonVisible => _isDoneButtonVisible;

  Future getStoreData() async {
    //_searchList = await _myFirebaseServices.getStoreData();
    _searchList = AppSampleData.storeList;
    /*var list = await _myFirebaseServices.getUserStore('');
    if (list != null) {
      _storeDetailList.addAll(list);
    }*/

    setState(ViewState.Idle);
  }

  void searchStore(String searchText) async {
    setState(ViewState.Busy);
    _searchList = await _myFirebaseServices.Search(searchText);
    setState(ViewState.Idle);
  }

  void storeItemTapped(StoreDataModel storeDataModel) {
    setState(ViewState.Busy);
    if (selectedStoreList.contains(storeDataModel)) {
      selectedStoreList.remove(storeDataModel);
      _pickedStoreCount = _pickedStoreCount-1;
    } else {
      if (selectedStoreList.length < 3) {
        selectedStoreList.add(storeDataModel);
        _pickedStoreCount = _pickedStoreCount+1;
      }
    }
    setState(ViewState.Idle);
  }

  String pickTextFieldtext;

  Future<bool> onTextFieldChanged(String value) async {
    setState(ViewState.Busy);
    await Future.delayed(Duration(milliseconds: 1000));

    if(pickTextFieldtext!=value)return true;
    _storeDetailList = _searchList.where((u) => (u.name.toLowerCase().contains(value.toLowerCase()))).toList();

    if (storeDetailList.length == 0) {
      setState(ViewState.Idle);
      return false;
    }

    setState(ViewState.Idle);
    return true;
  }

  void requestMoreData() => _myFirebaseServices.requestMoreData();

  void navigateToScreen() {
    if (AppConstants.userType == UserType.Customer) {
      navigationService.navigateTo(LandingScreen.routeName);
    } else {
      navigationService.navigateTo(CourierVerifyScreen.routeName);
    }
  }

  void updateList() {
    setState(ViewState.Busy);
    _myFirebaseServices.addSelectedStores(storeDetailList);
    setState(ViewState.Idle);
  }

  void popToScreen() {
    navigationService.pop();

  }
}
