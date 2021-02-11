
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/payment_option.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/rating_model.dart';
import 'package:storeangelApp/core/models/user.dart';

class PurchaseDetails {
  String id;
  String listName;
  StoreDataModel storeDetails;
  String notificationType;
  double amount;
  int quantity;
  List purchaseProofImages;
  PaymentOption paymentOption;


  DateTime time;
  UserModel customer=UserModel();
  List<Product> products;

  PurchaseDetails(
      {this.notificationType,
      this.id,
      this.customer,
      this.quantity,
      this.time,
      this.amount,
      this.listName,
      this.storeDetails,
      this.products,this.purchaseProofImages,this.paymentOption});

  double get totalAmount{
    if(products?.isNotEmpty??false){
      return products.fold(0, (previousValue, product) => previousValue+product.price);
    }

    return 0;
  }

}

class PurchaseProducts {
  String id;
  String category;
  List<Product> products;

  PurchaseProducts({this.id, this.category, this.products});
}
