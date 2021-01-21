
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel{
  String docID;
  String notificationID;
  String storeID;
  String userID;
  DateTime createdDate;
  String payload;
  String title;
  String type;
  String message;
  String token;
  NotificationModel({this.userID,this.storeID,this.createdDate,this.title,this.type,
    this.message,this.notificationID,this.payload,this.token});
  NotificationModel.fromMap(Map snapshot,String docID):
        docID=docID,
        notificationID=snapshot['ID_Notification']??'',
        storeID=snapshot['ID_Store']??'',
        userID=snapshot['ID_User']??'',
        payload=snapshot['txt_Payload'],
        createdDate=snapshot['dat_CreatedDate'].runtimeType==Timestamp?snapshot['dat_CreatedDate'].toDate():DateTime.parse(snapshot['dat_CreatedDate']),
        title=snapshot['txt_Title'],
        type=snapshot['txt_Type'],
        message=snapshot['txt_message'],
        token=snapshot['txt_token'];

  toJson() {
    return {
      "ID_Notification": notificationID,
      "ID_Store":storeID,
      "ID_User":userID,
      "txt_Payload":payload,
      "dat_CreatedDate":createdDate,
      "txt_Title":title,
      "txt_Type":type,
      "txt_message":message,
      "txt_token":token

    };
  }

}