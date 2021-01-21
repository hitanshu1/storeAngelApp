import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel{
  String docID;
  String storeID;
  String userID;
  bool bitDisabled;
  DateTime datChangeDate;
  DateTime datCloseTime;
  DateTime datCreateDate;
  DateTime datOpenTime;
  var intLatitude;
  var intLongitude;
  int intSubscribed;
  String city;
  String discription;
  String email;
  String internet;
  String land;
  String name;
  String phone;
  String picture;
  String street;
  String zip;
  StoreModel({this.bitDisabled,this.storeID,this.userID,this.phone,this.name,this.email,this.street,this.zip,this.city,
  this.datChangeDate,this.datCloseTime,this.datCreateDate,this.datOpenTime,this.discription,this.internet,this.intLatitude,
  this.intLongitude,this.intSubscribed,this.land,this.picture});
  StoreModel.fromMap(Map snapshot,String docID):
        docID=docID,
        storeID=snapshot['ID_Store']??'',
        userID=snapshot['ID_USER']??'',
        bitDisabled=snapshot['bit_Disabled']??'',
        datChangeDate=snapshot['dat_ChangeDate'].runtimeType==Timestamp?snapshot['dat_ChangeDate'].toDate():DateTime.parse(snapshot['dat_ChangeDate']),
        datCloseTime=snapshot['dat_CloseTime'].runtimeType==Timestamp?snapshot['dat_CloseTime'].toDate():DateTime.parse(snapshot['dat_CloseTime']),
        datCreateDate=snapshot['dat_CreateDate'].runtimeType==Timestamp?snapshot['dat_CreateDate'].toDate():DateTime.parse(snapshot['dat_CreateDate']),
        datOpenTime=snapshot['dat_OpenTime'].runtimeType!=String?snapshot['dat_OpenTime'].toDate():DateTime.parse(snapshot['dat_OpenTime']),
        intLatitude=snapshot['int_Latitude'],
        intLongitude=snapshot['int_Longitude']??0,
        intSubscribed=snapshot['int_Subscribed']??0,
        city=snapshot['txt_City']??'',
        discription=snapshot['txt_Description'],
        email=snapshot['txt_Email'],
        internet=snapshot['txt_Internet'],
        land=snapshot['txt_Land'],
        name=snapshot['txt_Name'],
        phone=snapshot['txt_Phone'],
        picture=snapshot['txt_Picture'],
        street=snapshot['txt_Street'],
        zip=snapshot['txt_ZIP'];
  toJson() {
    return {
      "ID_Store": storeID,
      "ID_USER":userID,
      "bitDisabled":bitDisabled,
      "datChangeDate":datChangeDate,
      "dat_CloseTime":datCloseTime,
      "dat_CreateDate":datCreateDate,
      "dat_OpenTime":datOpenTime,
      "int_Latitude":intLatitude,
      "int_Longitude":intLongitude,
      "int_Subscribed":intSubscribed,
      "txt_City":city,
      "txt_Description":discription,
      "txt_Email":email,
      "txt_Internet":internet,
      "txt_Land":land,
      "txt_Name":name,
      "txt_Phone":phone,
      "txt_Picture":picture,
      "txt_Street":street,
      "txt_ZIP":zip,
    };
  }


}