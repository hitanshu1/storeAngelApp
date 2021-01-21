import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  String googleID;
  String productID;
  bool bitDisabled;
  DateTime dateChange;
  DateTime dateCreated;
  String name;
  String picture;
  ProductModel({this.productID,this.picture,this.name,this.bitDisabled,this.dateChange,this.dateCreated,this.googleID});
  ProductModel.fromMap(Map snapshot):
        googleID=snapshot['ID_GoogleID']??'',
        productID=snapshot['ID_Product']??'',
        bitDisabled=snapshot['bit_Disabled'],
        dateChange=snapshot['dat_ChangeDate'].runtimeType==Timestamp?snapshot['dat_ChangeDate'].toDate():DateTime.parse(snapshot['dat_ChangeDate']),
        dateCreated=snapshot['dat_CreateDate'].runtimeType==Timestamp?snapshot['dat_CreateDate']:DateTime.parse(snapshot['dat_CreateDate']),
        name=snapshot['txt_Name'],
        picture=snapshot['txt_Picture'];

  toJson() {
    return {
      "ID_GoogleID": googleID,
      "ID_Product":productID,
      "bit_Disabled":bitDisabled,
      "dat_ChangeDate":dateChange,
      "dat_CreateDate":dateCreated,
      "txt_Name":name,
      "txt_Picture":picture

    };
  }
}