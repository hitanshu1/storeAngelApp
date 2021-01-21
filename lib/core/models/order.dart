import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/models/user.dart';

enum OrderAndPurchaseType { Order, Purchase }

class OrderOrPurchases {
  OrderAndPurchaseType type;
  String orderID;
  String paymentMethod;
  DateTime postedAt;
  int alreadyDone;

  String shopName;
  double orderAmount;
  String productName;
  int quantity;
  ProposalDetails proposalDetails;
  List receipts = [];

  ClientDetails clientDetails;
  PurchaseDetails purchaseDetails;
  List<CourierCandidate> candidates;
  StoreDataModel storeDetails;
  OrderPurchaseStatus status;
  String orderPayment;
  DateTime selectedDate;
  String timeDuration;
  DateTime deliveredAt;
  List<UserModel> clientlist;
  String comment;
  bool paid;

  OrderOrPurchases(
      {this.orderAmount,
      this.timeDuration,
      this.productName,
      this.alreadyDone,
      this.quantity,
      this.shopName,
      this.proposalDetails,
      this.clientDetails,
      this.storeDetails,
      this.purchaseDetails,
      this.candidates,
      this.status,
      this.comment:'',
      this.type,
      this.orderPayment,
      this.selectedDate,
      this.clientlist,
      this.orderID,
      this.paymentMethod,
      this.postedAt,
      this.deliveredAt,
      this.paid,
      this.receipts});
}

class CourierBoy {
  String name;
  String imageUrl;
  int rating;
  String status;
  String time;

  CourierBoy(
      {this.name,
      this.status,
      this.rating,
      this.time,
      this.imageUrl:
          'https://www.stuttgarter-nachrichten.de/media.media.d8c538e0-8bc1-4efc-84b3-ac0ef7241c24.original1024.jpg'});
}

class ClientDetails {
  String name;
  String imageUrl;
  int rating;
  String status;
  String time;
  String street;
  String streetNo;
  String city;
  String zip;

  String get addressLine => city + ', ' + street;
  String get addressWithName =>name+', '+ city + ', ' + street;

  String get zipCity => zip + ' ' + city;

  String get address => zip + ' ' + city + ' ' + street;
  String get twoLineAddress=>street+'\n'+zip+', '+city;
  String get twoLineAddressWithName=>name+"\n"+street+'\n'+zip+', '+city;

  ClientDetails(
      {this.name,
      this.status,
        this.zip,
      this.rating,
      this.time,
      this.street,
      this.city,
        this.streetNo,
      this.imageUrl:
          'https://www.stuttgarter-nachrichten.de/media.media.d8c538e0-8bc1-4efc-84b3-ac0ef7241c24.original1024.jpg'});


}

class ProposalDetails {
  int totalProposals;
  DateTime time;
  int unseenProposal;

  ProposalDetails({this.totalProposals, this.time, this.unseenProposal});
}
