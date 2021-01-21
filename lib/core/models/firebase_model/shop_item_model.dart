
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopItemModel{
  String docID;
  String listItemID;
  String shopListID;
  bool bitDisabled;
  bool bitInform;
  bool bitOrder;
  DateTime changeDate;
  DateTime createdDate;
  int budget;
  int quantity;
  int sortValue;
  String reaPrice;
  String ownerName;
  String currency;
  List altItems;
  ShopItemModel({this.currency,this.bitDisabled,this.shopListID,this.sortValue,this.quantity,this.bitInform,this.bitOrder,this.budget,this.changeDate,
  this.createdDate,this.listItemID,this.ownerName,this.reaPrice,this.altItems});
  ShopItemModel.fromMap(Map snapshot,String docID):
      docID=docID,
      listItemID=snapshot['ID_List_Item']??'',
        shopListID=snapshot['ID_Shop_List']??'',
        bitDisabled=snapshot['bit_Disabled']??false,
        bitInform=snapshot['bit_Inform']??false,
        bitOrder=snapshot['bit_Order']??'',
        changeDate=snapshot['dat_ChangeDate'].runtimeType==Timestamp?snapshot['dat_ChangeDate'].toDate():DateTime.parse(snapshot['dat_ChangeDate']),
        createdDate=snapshot['dat_CreateDate'].runtimeType==Timestamp?snapshot['dat_CreateDate'].toDate():snapshot['dat_CreateDate'],
  budget=snapshot['int_Budget']??0,
  quantity=snapshot['int_Quantity']??0,
        sortValue=snapshot['int_Sortvalue']??0,
        reaPrice=snapshot['rea_Price']??'',
        ownerName=snapshot['txt_Ownname']??'',
        currency=snapshot['txt_PriceCurrency']??'',
        altItems=snapshot['array_ID_Alt_Items'];
  toJson() {
    return {
      "ID_List_Item": listItemID,
      "ID_Shop_List":shopListID,
      "bitDisabled":bitDisabled,
      "bit_Inform":bitInform,
      "bit_Disabled":bitDisabled,
      "bit_Order":bitOrder,
      "dat_ChangeDate":changeDate,
      "dat_CreateDate":createdDate,
      "int_Budget":budget,
      "int_Quantity":quantity,
      "int_Sortvalue":sortValue,
      "rea_Price":reaPrice,
      "txt_Ownname":ownerName,
      "txt_PriceCurrency":currency,
      "array_ID_Alt_Items":altItems


    };
  }

}