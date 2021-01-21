
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/models/places_all_model.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
class BusinessInformationViewModel extends BaseModel{

  List<Place> places = <Place>[];
  final _imagePicker = ImagePicker();
  bool hasShadow = false;
  ScrollController scrollController;

  void navigatorPop() {
    navigationService.pop();
  }
  File _imageFile;
  File get imageFile =>_imageFile;
  TextEditingController companyNameController=TextEditingController();
  TextEditingController companyEmailController=TextEditingController();
  TextEditingController taxIdentificationController=TextEditingController();
  TextEditingController countryController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController streetController=TextEditingController();
  final firstNameFocusNode = FocusNode();
  final secondNameFocusNode = FocusNode();


  Future<bool> openCamera() async {
    try {
      final _image = await _imagePicker.getImage(source: ImageSource.camera);
      _imageFile = File(_image.path);
      navigatorPop();
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }

  Future<bool> openGallery() async {
    setState(ViewState.Busy);
    try {
      final _image = await _imagePicker.getImage(source: ImageSource.gallery);
      _imageFile = File(_image.path);
      navigatorPop();
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      setState(ViewState.Idle);
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }
  double _latitude;
  double _longitude;
  var location = new Location();
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
            _latitude.toString()+
            "," +
            _longitude.toString() +
            "&radius=4000");

    final response = await http.get(
        uri, headers: {"Accept": "application/json"});

    List data = json.decode(response.body)["predictions"];

    places.clear();
    data.forEach((f) =>
    places.add(new Place(
        name: f["structured_formatting"]["main_text"],
        lat: _latitude,long: _longitude,
        address: f["description"]

    )));

    setState(ViewState.Idle);

    return places;
  }

  void initialize(ScrollController scrollController){
    Future.delayed(Duration.zero,(){
      this.scrollController = scrollController;
      this.scrollController.addListener(addScrollListener);
    });
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