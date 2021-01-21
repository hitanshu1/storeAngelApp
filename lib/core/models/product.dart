import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/user.dart';

class Product {
  String id;
  String name;
  int quantity;
  String category;
  bool select;
  String imageUrl;
  double price;
  double newPrice;
  String description;
  StoreDataModel storeDetails;
  AvailableStatus availableStatus;
  bool selected;
  Product selectedAlterNative;
  List<Product> alternativeProduct;
  UserModel createdBy;
  UserModel assignClient;
  List wishList;
  double averageRating;
  int ratingCount;
  bool enableUnit;

  String type;

  Product(
      {this.id,
      this.selected: false,
      this.selectedAlterNative,
      this.alternativeProduct,
      this.category,
        this.newPrice,
      this.price,
      this.imageUrl,
      this.name,
      this.quantity: 0,
      this.select: false,
      this.type,
      this.storeDetails,
      this.description,
      this.createdBy,
      this.wishList,
      this.availableStatus,
      this.assignClient,this.enableUnit:false}) {
    wishList = [];
  }
}
