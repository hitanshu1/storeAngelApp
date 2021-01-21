import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/services/uintlist_converter_service.dart';
import 'package:storeangelApp/core/services/navigation_service.dart';
import 'package:storeangelApp/core/services/sharedPreference.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/screens/consumer/pick_Store_Screen.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';



class SelectAddressViewModel extends BaseModel {
  double _currentLatitude;
  double get currentLatitude =>_currentLatitude;
  double _currentLongitude;
  double get currentLongitude =>_currentLongitude;

  BitmapDescriptor markerIcon;
  List<Marker> allMarker = <Marker>[];
  List<Circle> circles=<Circle>[];
  String mapStyle;
  String currentAddress = '';

  GoogleMapController mapController;

  final _navigationService = getIt<NavigationService>();

  void navigateToScreen(String routename, Object argument) {
    _navigationService.navigateTo(routename, arguments: PickStoreScreenArguments(
      address: argument
    ));
  }

  void popToScreen() {
    _navigationService.pop();
  }

  void loadMapStyle()async {
//    setState(ViewState.Busy);
    final initialValue = await getIt<AppSharedPreferences>().getAppInitialValues();
    if (initialValue.darkMode){
      rootBundle.loadString('assets/map_styles/dark.json').then((string) {
        mapStyle = string;
        setState(ViewState.Idle);
      });
    }else{
      rootBundle.loadString('assets/map_styles/light.json').then((string) {
        mapStyle = string;
        setState(ViewState.Idle);
      });
    }

  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  Future onChangeMarker(String address)async{
    allMarker=[];
    circles=[];
    currentAddress=address;
    final Uint8List marketIcon=await UintListConverterService.getUintListFromIcon(iconData: Icons.location_on,
    height: 70);
    double lat;
    double lng;
    await Geocoder.local.findAddressesFromQuery(address).then((value){
      lat=value.first.coordinates.latitude;
      lng=value.first.coordinates.longitude;
      mapController.moveCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 16));
      allMarker.add(Marker(
          markerId: MarkerId('1'),
          draggable: false,

          icon: BitmapDescriptor.fromBytes(marketIcon),
          infoWindow: InfoWindow(title: 'sssss',),
          onTap: () {
            MyUtils().toastdisplay("tap marker");
          },
          position: LatLng(lat, lng)));
      circles.addAll([Circle(
        circleId: CircleId("1"),
        consumeTapEvents: true,
        strokeColor: AppColors.primaryColor.withOpacity(0.08),
        fillColor: AppColors.primaryColor.withOpacity(.2),
        center: LatLng(lat, lng),
        strokeWidth: 1,
        radius: 7,
      ),
        Circle(
          circleId: CircleId("2"),
          consumeTapEvents: true,
          strokeColor: AppColors.primaryColor.withOpacity(0.08),
          fillColor: AppColors.primaryColor.withOpacity(.1),
          center: LatLng(lat, lng),
          strokeWidth: 1,
          radius: 15,
        ),
        Circle(
          circleId: CircleId("3"),
          consumeTapEvents: true,
          strokeColor: AppColors.primaryColor.withOpacity(0.08),
          fillColor: AppColors.primaryColor.withOpacity(.06),
          center: LatLng(lat, lng),
          strokeWidth: 1,
          radius: 30,
        )]);
    });

    setState(ViewState.Idle);
  }

  Future createMarker(String id) async {
    setState(ViewState.Busy);
    loadMapStyle();

    getIt<AppSharedPreferences>().getStringInPref('latitude').then((value) {
      if (value != null) {
        _currentLatitude = double.parse(value);

      }
    });

    getIt<AppSharedPreferences>().getStringInPref('longitude').then((value) async{
      if (value != null) {
        _currentLongitude = double.parse(value);
        await getAddFromLatLong(_currentLatitude, _currentLongitude).then((value) {
          String country = value.first.countryName;
          String cityZip = value.first.postalCode;
          String city = value.first.locality;
          String street = value.first.featureName;

          print('$street $city $cityZip $country');

          currentAddress='$street, $cityZip $city, $country';
        });

        final Uint8List marketIcon=await UintListConverterService.getUintListFromIcon(iconData: Icons.location_on,
        height: 85);
        allMarker.add(Marker(
            markerId: MarkerId(id),
            draggable: false,

            icon: BitmapDescriptor.fromBytes(marketIcon),
            infoWindow: InfoWindow(title: 'sssss',),
            onTap: () {
              MyUtils().toastdisplay("tap marker");
            },
            position: LatLng(_currentLatitude, _currentLongitude)));
        circles.addAll([Circle(
          circleId: CircleId("1"),
          consumeTapEvents: true,
          strokeColor: AppColors.primaryColor.withOpacity(0.08),
          fillColor: AppColors.primaryColor.withOpacity(.2),
          center: LatLng(_currentLatitude, _currentLongitude),
          strokeWidth: 1,
          radius: 15,
        ),
          Circle(
            circleId: CircleId("2"),
            consumeTapEvents: true,
            strokeColor: AppColors.primaryColor.withOpacity(0.08),
            fillColor: AppColors.primaryColor.withOpacity(.1),
            center: LatLng(_currentLatitude, _currentLongitude),
            strokeWidth: 1,
            radius: 30,
          ),
          Circle(
            circleId: CircleId("3"),
            consumeTapEvents: true,
            strokeColor: AppColors.primaryColor.withOpacity(0.08),
            fillColor: AppColors.primaryColor.withOpacity(.06),
            center: LatLng(_currentLatitude, _currentLongitude),
            strokeWidth: 1,
            radius: 60,
          )]);
        setState(ViewState.Idle);

      }
    });
  }

  Future getLatLongFromAddress(String address) async {
    currentAddress = address;
    setState(ViewState.Busy);
    var uri = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?address=" +
        address +
        "&key=${AppConstants.googleQueryLink}");
    http.get(uri, headers: {"Accept": "application/json"}).then((onValue) {
      List data = json.decode(onValue.body)["results"];
      if(data?.isNotEmpty??false){

        print("response Adreess lat long " + data.toString());
        var lat = data[0]["geometry"]["location"]["lat"];
        var long = data[0]["geometry"]["location"]["lng"];
        print("lat long geocoder" + lat.toString() + " " + long.toString());

        getIt<AppSharedPreferences>().setString('latitude', lat.toString());
        getIt<AppSharedPreferences>().setString('longitude', long.toString());

        createMarker("2");
      }
    });
    setState(ViewState.Idle);
  }
  static Future<List<Address>> getAddFromLatLong(double lat,double lng){
    return  Geocoder.local.findAddressesFromCoordinates(Coordinates(lat, lng));
  }

}
