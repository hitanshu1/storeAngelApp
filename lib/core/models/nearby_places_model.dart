import 'package:flutter/material.dart';

class NearByPlace {
  String icon;
  String placeId;
  String name;
  String rating;
  String vicinity;
  double lat;
  double long;
  String photoUrl;
  String distance;
  List<dynamic> imageUrlList;

  String formattedAddress;
  String internationalPhoneNumber;
  List<String> weekdayText;

  String url;

  NearByPlace(
      {@required this.placeId,
      @required this.name,
      @required this.icon,
      @required this.rating,
      @required this.vicinity,
      @required this.lat,
      @required this.long,
      @required this.imageUrlList});
}
