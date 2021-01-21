import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/models/places_all_model.dart';
import 'package:storeangelApp/core/services/sharedPreference.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/screens/consumer/googleMapsFindAddress_Screen.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class GoogleMapsFindAddressModel extends BaseModel {
  final _prefs = getIt<AppSharedPreferences>();
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  double _latitude;
  double _longitude;
  String _currentAddress;

  List<Place> places = <Place>[];

  void navigateToScreen(String routename, {Object argument}) {
    navigationService.navigateTo(routename, arguments: argument);
  }

  void navigatorPop() {
    navigationService.pop();
  }

  Future getLocation(bool isAllowedSceen) async {
    if(state==ViewState.Idle){
      setState(ViewState.Busy);

      try {
        //to check permission
        _permissionGranted = await location.hasPermission();
        print('permission: $_permissionGranted');

        _serviceEnabled = await location.serviceEnabled();
        print('_serviceEnabled $_serviceEnabled');
        print('location: ${await location.getLocation()}');
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          print('serviceEnabled: $_serviceEnabled');
          if (!_serviceEnabled) {
            return;
          }
        }
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted == PermissionStatus.deniedForever) {
            MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
          }

          if (_permissionGranted != PermissionStatus.granted) {
            return;
          }
        }

        LocationData currentLocation = await location.getLocation();

        _latitude = currentLocation.latitude;

        _longitude = currentLocation.longitude;
        List<Address> _addressList =
            await Geocoder.local.findAddressesFromCoordinates(Coordinates(_latitude, _longitude));
        _currentAddress = _addressList.first.addressLine;

        _prefs.setString(AppSharedPreferences.latitude, _latitude.toString());
        _prefs.setString(AppSharedPreferences.longitude, _longitude.toString());
        _prefs.setString(AppSharedPreferences.currentAddress, _currentAddress);

        setState(ViewState.Idle);

        if (isAllowedSceen == true) {
          navigationService.navigateTo(GoogleMapsFindAddressScreen.routeName);
        }
      } catch (e) {}
    }
  }

  Future<List<Place>> getAllPlaces(String placeName,bool country) async {
    setState(ViewState.Busy);

    //TODO places api call start from here
    setState(ViewState.Busy);

    var uri;
    if(country){
      uri= Uri.parse(
          AppConstants.googleQueryLink +
              placeName +
              "&location=" +
              _latitude.toString() +
              "," +
              _longitude.toString() +
              "&radius=4000");
    }else{
      uri= Uri.parse(
          AppConstants.googleQueryLink +
              placeName +
              "&location=" +
              _latitude.toString() +
              "," +
              _longitude.toString() +
              "&radius=4000");
    }


    var reponse = await http.get(uri, headers: {"Accept": "application/json"});

    List data = json.decode(reponse.body)["predictions"];

    print("response####### " + data.toString());

    places.clear();
    data.forEach((f) => places.add(new Place(
      name: f["structured_formatting"]["main_text"],
      lat: _latitude,long: _longitude,
      address: f["description"]


    )));

    setState(ViewState.Idle);

    return places;
  }
}
