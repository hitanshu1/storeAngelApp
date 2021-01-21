
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItem{
  String docID;
  String allItemID;
  String orderItemID;
  String ordersID;
  bool disabled;
  DateTime changedDate;
  DateTime createdDate;
  int quantity;
  int sortValue;
  String ownerName;

  OrderItem({this.allItemID,this.orderItemID,this.ordersID,this.disabled,this.createdDate,this.changedDate,this.quantity,this.ownerName,this.sortValue});
  OrderItem.fromMap(Map snapshot,String docID):
      docID=docID,
        allItemID=snapshot['ID_All_Item']??'',
        orderItemID=snapshot['ID_Order_Item']??'',
        ordersID=snapshot['ID_Orders']??'',
        disabled=snapshot['bit_Disabled']??false,
        changedDate=snapshot['dat_Changedate'].runtimeType==Timestamp?snapshot['dat_Changedate'].toDate():DateTime.parse(snapshot['dat_Changedate']),
        createdDate=snapshot['dat_Createdate'].runtimeType==Timestamp?snapshot['dat_Createdate'].toDate():DateTime.parse(snapshot['dat_Createdate']),
        quantity=snapshot['int_Quantity'],
        sortValue=snapshot['int_Sortvalue'],
        ownerName=snapshot['txt_Ownname'];

  toJson() {
    return {
      "ID_All_Item": allItemID,
      "ID_Order_Item":orderItemID,
      "ID_Orders":ordersID,
      "bit_Disabled":disabled,
      'dat_Changedate':changedDate,
      'dat_Createdate':createdDate,
      'int_Quantity':quantity,
      'int_Sortvalue':sortValue,
      'txt_Ownname':ownerName
    };
  }
}