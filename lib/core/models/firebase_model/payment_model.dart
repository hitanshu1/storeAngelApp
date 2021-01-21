
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  String docID;
  String orderID;
  String paymentID;
  String userID;
  String userPaymentByID;
  DateTime datPaymentDate;
  int amount;
  String currency;
  String transactionDetails;
  PaymentModel({this.userID,this.currency,this.orderID,this.amount,this.datPaymentDate,this.paymentID,
    this.transactionDetails,this.userPaymentByID});

  PaymentModel.fromMap(Map snapshot,String docID):
        docID=docID,
        orderID=snapshot['ID_Order']??'',
        paymentID=snapshot['ID_Payment']??'',
        userID=snapshot['ID_User']??'',
        userPaymentByID=snapshot['ID_User_Payment_By'],
        datPaymentDate=snapshot['dat_Paymentdate'].runtimeType==Timestamp?snapshot['dat_Paymentdate'].toDate():DateTime.parse(snapshot['dat_Paymentdate']),
        amount=snapshot['int_Amount'],
        currency=snapshot['txt_Currency'],
        transactionDetails=snapshot['txt_TransactionDetails'];

  toJson() {
    return {
      "ID_Order": orderID,
      "ID_Payment":paymentID,
      "ID_User":userID,
      "ID_User_Payment_By":userPaymentByID,
      "dat_Paymentdate":datPaymentDate,
      "int_Amount":amount,
      "txt_Currency":currency,
      "txt_TransactionDetails":transactionDetails,

    };
  }


}