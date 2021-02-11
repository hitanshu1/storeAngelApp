import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/enums/item_status.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/user.dart';

class Product {
  String id;
  String name;
  int quantity;
  int originQuantity;
  String category;
  bool select;
  String imageUrl;
  double price;
  double newPrice;
  String description;
  StoreDataModel storeDetails;
  AvailableStatus availableStatus;
  ItemStatus itemStatus;
  bool selected;
  Product selectedAlterNative;
  List<Product> alternativeProduct=[];
  UserModel createdBy;
  ClientDetails assignClient;
  List wishList;
  double averageRating;
  List<ClientDetails>alterNativeAddedClients;
  int ratingCount;
  bool enableUnit;

  String type;

  Product(
      {this.id,
        this.originQuantity:0,
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
      this.assignClient,this.enableUnit:false,this.itemStatus:ItemStatus.UnSelected,this.alterNativeAddedClients}) {
    wishList = [];
  }
}
