
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/participant.dart';
import 'package:storeangelApp/core/models/product.dart';

import 'firebase_storedata_model.dart';

class OrderByStore{
  List<Participant>participants;
  StoreDataModel storeDetails;
  DateTime orderTime;
  double orderAmount;
  double courierFee;
  OrderPurchaseStatus status;
  List<Product>products;
  List<ClientDetails>clients;
  OrderByStore({this.courierFee,this.participants,this.clients,this.storeDetails,this.products,this.orderAmount,this.orderTime,this.status:OrderPurchaseStatus.PlaceAOrder});
}