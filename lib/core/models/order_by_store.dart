
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/product.dart';

import 'firebase_storedata_model.dart';

class OrderByStore{
  StoreDataModel storeDetails;
  DateTime orderTime;
  double orderAmount;
  String status;
  List<Product>products;
  List<ClientDetails>clients;
  OrderByStore({this.clients,this.storeDetails,this.products,this.orderAmount,this.orderTime,this.status:"Ready to go shopping"});
}