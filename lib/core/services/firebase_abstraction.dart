
import 'package:storeangelApp/core/models/address.dart';
import 'package:storeangelApp/core/models/chat_message.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/firebase_model/courier_proposal.dart';
import 'package:storeangelApp/core/models/firebase_model/notification_model.dart';
import 'package:storeangelApp/core/models/firebase_model/order_item.dart';
import 'package:storeangelApp/core/models/firebase_model/payment_model.dart';
import 'package:storeangelApp/core/models/firebase_model/shop_item_model.dart';
import 'package:storeangelApp/core/models/firebase_model/shop_model.dart';
import 'package:storeangelApp/core/models/firebase_model/store_model.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/package_model.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/models/response_model.dart';
import 'package:storeangelApp/core/models/user.dart';

abstract class FirebaseAbstraction {

  Future getStoreData();
  Future getOrderByStoreList();
  Future<ResponseModel>saveUser(UserModel user);
  Future requestMoreData();
  Future addSelectedStores(List<StoreDataModel>slist);
  Stream listenToStoresRealTime();
  Future Search(String searchText);
  Future getOrderList();
  Future getCompletedOrders();
  Future getPurchaseDetails(String id);
  Future getUserWishList(String useId);
  Future getUserNotificationList(String useId);
  Future getStoreProduct(String storeName,String searchtext);
  Future onSeachProduct(String searchText);
  Future getUserStore(String userId);
  Future deleteSelectedStore(StoreDataModel  store);
  Future getUserDetails(String userId);
  Future getUserAddress(String userId);
  Future getUserList();
  Future searchUserList(String searchtext);
  Future shareUser(UserModel user);
  Future removeUser(UserModel user);
  Stream<List<CourierCandidate>> getCandidatesList();
  Future<ResponseModel>onUpdateCandidate(CourierCandidate candidate);
  Stream<List<ChatMessage>>getMessageList();
  Future getAlternativeicon(String serachtext,String storeName);
  Future getAssignOrderForCourier(String courierId);
  Future getOfferbyCourier(String courierId);
  Future<ResponseModel> removeProductFomWishlist(String detailsId,Product product);
  Future<ResponseModel> updateWishList(String detailsId,String productList_id,Product product);
  Future<List<AddressModel>>getUserAddresses(String userid);
  Future<bool>checkUserData(UserModel user);
  Future<ResponseModel>sendMessage(String message,UserModel sendBy);
  Stream<List<Product>>getWishListProductList(PurchaseDetails purchaseDetails);
  Future<ResponseModel>onUpdateVerifyField(int value,UserModel user);
  Future getOfferOrderForCourier(String courierId);
  Future getOrdersForCourier(String courierId);
  Future<List<OrderOrPurchases>> getPastOrders(String courierID);
  Future getCourierCandidateList();
  Future<List<PackageModel>>getPackagesList();
  Future<ResponseModel>onDeleteOffer(OrderOrPurchases order);
  Future<List<ShopModel>>getShopList();
  Stream<List<StoreModel>>getStoreList();
  Future<List<PaymentModel>>getPayments();
  Future<List<NotificationModel>>getNotificationList();
  Stream<List<ShopItemModel>>getShopItems(String shopListID);
  Stream<List<OrderItem>>getOrderItems(String orderID);
  Stream<List<CourierProposal>>getOrderProposal(String orderID);






}