
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  String messageID;
  String sentByID;
  DateTime datSent;
  String message;
  MessageModel({this.message,this.datSent,this.messageID,this.sentByID});
  MessageModel.fromMap(Map snapshot):
        messageID=snapshot['ID_Message']??'',
        datSent=snapshot['dat_Sent'].runtimeType==Timestamp?snapshot['dat_Sent'].toDate():DateTime.parse(snapshot['dat_Sent']),
        sentByID=snapshot['ID_SentBy'],
        message=snapshot['txt_Message'];

  toJson() {
    return {
      "ID_Message": messageID,
      "dat_Sent":datSent,
      "ID_SentBy":sentByID,
      "txt_Message":message

    };
  }
}