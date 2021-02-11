
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/product.dart';

class Participant{
  List<Product>products;
  ClientDetails clientDetails;
  OrderPurchaseStatus status;
  Participant({this.clientDetails,this.products,this.status});
}