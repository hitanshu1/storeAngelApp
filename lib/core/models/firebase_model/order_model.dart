
class OrderModel {
  String orderID;
  String txtOrderBill;
  String shopListID;
  String deliveryType;
  DateTime datDeliveryStart;
  String deliveryPlace;
  int reaFee;
  String userID;
  String paymentType;
  bool bitDisabled;
  int reaBudget;
  DateTime deliveryEnd;
  OrderStatus orderStatus;
  String supplierID;
  String currency;
  String comment;
  String storeID;

  OrderModel({this.userID,this.comment,this.bitDisabled,this.currency,this.datDeliveryStart,this.deliveryEnd,this.deliveryPlace,
    this.deliveryType,this.orderID,this.orderStatus,this.paymentType,this.reaBudget,this.reaFee,this.shopListID,this.storeID,this.supplierID,this.txtOrderBill});
  OrderModel.fromMap(Map snapshot) :

        orderID = snapshot['ID_Order'] ?? '',
         txtOrderBill=snapshot['txt_OrderBill']??'',
        shopListID=snapshot['ID_Shop_List']??'',
        deliveryType=snapshot['txt_DeliveryType']??'',
        datDeliveryStart=snapshot['dat_Delivery_Start'].runtimeType!=String?snapshot['dat_Delivery_Start'].toDate():DateTime.parse(snapshot['dat_Delivery_Start']),
        deliveryPlace=snapshot['txt_Delivery_Place']??'',
        reaFee=snapshot['rea_Fee']??0,
        userID=snapshot['ID_User'],
        paymentType=snapshot['txt_PaymentType']??'',
        bitDisabled=snapshot['bit_Disabled']??false,
        reaBudget=snapshot['rea_Budget']??0,
        deliveryEnd=snapshot['dat_Delivery_End'].runtimeType!=String?snapshot['dat_Delivery_End'].toDate():DateTime.parse(snapshot['dat_Delivery_Start']),
        orderStatus=OrderStatus.fromMap(snapshot['map_OrderStatus']),
        supplierID=snapshot['ID_Supplier']??'',
        currency=snapshot['txt_Currency'],
        comment=snapshot['txt_Comment'],
        storeID=snapshot['ID_Store'];




  toJson() {
    return {
      "orderID": orderID,
      "txt_OrderBill":txtOrderBill,
      "ID_Shop_List":shopListID,
      "txt_DeliveryType":deliveryType,
      "dat_Delivery_Start":datDeliveryStart,
      "txt_Delivery_Place":deliveryPlace,
      "rea_Fee":reaFee,
      "ID_User":userID,
      "txt_PaymentType":paymentType,
      "bit_Disabled":bitDisabled,
      "rea_Budget":reaBudget,
      "dat_Delivery_End":deliveryEnd,
      "map_OrderStatus":orderStatus.toJson(),
      "ID_Supplier":supplierID,
      "txt_Currency":currency,
      "txt_Comment":comment,
      "ID_Store":storeID

    };
  }



}

class OrderStatus{
  StatusClass pendingStatus;
  StatusClass startStatus;
  StatusClass finishStatus;
  StatusClass acceptedStatus;
  StatusClass deliverStatus;
  OrderStatus({this.pendingStatus,this.acceptedStatus,this.deliverStatus,this.finishStatus,this.startStatus});
  OrderStatus.fromMap(Map snapshot):
      pendingStatus=StatusClass.fromMap(snapshot['map_PendingStatus']),
        startStatus=StatusClass.fromMap(snapshot['map_StartStatus']),
        finishStatus=StatusClass.fromMap(snapshot['map_FinishedStatus']),
        acceptedStatus=StatusClass.fromMap(snapshot['map_AcceptStatus']),
        deliverStatus=StatusClass.fromMap(snapshot['map_DeliveredStatus']);
  toJson() {
    return {
      "map_PendingStatus": pendingStatus.toJson(),
      "map_StartStatus":startStatus.toJson(),
      "map_FinishedStatus":finishStatus.toJson(),
      "map_AcceptStatus":acceptedStatus.toJson(),
      "map_DeliveredStatus":deliverStatus.toJson()



    };
  }
}

class StatusClass{
  DateTime endDate;
  String status;
  DateTime startDate;
  StatusClass({this.status,this.endDate,this.startDate});
  StatusClass.fromMap(Map snapshot):
        endDate=snapshot['dat_Enddate'].runtimeType!=String?snapshot['dat_Enddate'].toDate():DateTime.parse(snapshot['dat_Enddate']),
        status=snapshot['status'],
        startDate=snapshot['dat_Startdate'].runtimeType!=String?snapshot['dat_Startdate'].toDate():DateTime.parse(snapshot['dat_Startdate'])
        ;
  toJson() {
    return {
      "dat_Enddate": endDate,
      "status":status,
      "dat_Startdate":startDate

    };
  }

}
