import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/consts/database_url.dart';
import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/enums/share_status.dart';
import 'package:storeangelApp/core/enums/varify_status.dart';
import 'package:storeangelApp/core/models/address.dart';
import 'package:storeangelApp/core/models/chat_message.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/firebase_model/courier_proposal.dart';
import 'package:storeangelApp/core/models/firebase_model/notification_model.dart';
import 'package:storeangelApp/core/models/firebase_model/order_item.dart';
import 'package:storeangelApp/core/models/firebase_model/order_model.dart';
import 'package:storeangelApp/core/models/firebase_model/payment_model.dart';
import 'package:storeangelApp/core/models/firebase_model/shop_item_model.dart';
import 'package:storeangelApp/core/models/firebase_model/shop_model.dart';
import 'package:storeangelApp/core/models/firebase_model/store_model.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/models/package_model.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/models/rating_model.dart';
import 'package:storeangelApp/core/models/response_model.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/firebase_service.dart';
import 'firebase_abstraction.dart';

class MyFirebaseServiceImpl extends FirebaseAbstraction {
  final FireStoreServices _fireStoreService = FireStoreServices.instance;
  final fireStore = FirebaseFirestore.instance;
  List<StoreDataModel> storeDetailList;

//  final StreamController<List<StoreDataModel>> _postsController =
//  StreamController<List<StoreDataModel>>.broadcast();

  // #6: Create a list that will keep the paged results
//  List<List<StoreDataModel>> _allPagedResults = List<List<StoreDataModel>>();

//  final CollectionReference _postsCollectionReference = FirebaseFirestore.instance.collection('col_Stores');

  static const int PostsLimit = 5;

  @override
  Future<ResponseModel> saveUser(UserModel user) async {
    try {
      print('userID==${user.id}');
      await _fireStoreService.setDataWithID(path: '${DatabaseUrls.colUsers}', docID: user.id, data: user.toJson());
      return ResponseModel(message: 'SignUp successful', status: 1);
    } catch (e) {
      print(e.toString());
      return ResponseModel(message: e.message.toString(), status: 0);
    }
  }

  @override
  Future getStoreData() async {
    Future<List<StoreDataModel>> storeDetailList = Future.delayed(Duration.zero, () {
      return AppSampleData.storeList;
    });

    print('${(await storeDetailList).map((e) => e.id)} lists loaded');

    return storeDetailList;
  }

  @override
  Future addSelectedStores(List<StoreDataModel> slist) {
    slist.forEach((element) {
      if (!AppSampleData.userSelectedStores.contains(element)) {
        AppSampleData.userSelectedStores.add(element);
      }
    });
  }

  @override
  Future requestMoreData() {
    return null;
  }

  @override
  Future Search(String searchText) async {
    List<StoreDataModel>_stores=[];
    AppSampleData.storeList.forEach((element) {
      if(element.name.toLowerCase().contains(searchText.toLowerCase())){
        _stores.add(element);
      }
    });

    return _stores;
  }

  @override
  Stream listenToStoresRealTime() {
    return null;
  }

  @override
  Future getOrderList() async{
    var result = await _fireStoreService.collectionStream(path: DatabaseUrls.colOrders,
        builder: (r,id){
          return r;
        }
    );
    List<OrderModel>_orders=[];
    result.first.then((values){
      values.forEach((element) {

        _orders.add(OrderModel.fromMap(element));

      });
    });
    Future orderList = Future.delayed(Duration.zero, () {
      return AppSampleData.orderList;
    });

    return orderList;
  }

  @override
  Future getPurchaseDetails(String id) {
    return Future.delayed(Duration.zero, () {
      return AppSampleData.wishlist.first;
    });
  }

  @override
  Future<List<AddressModel>> getUserAddresses(String userId) {
    Future<List<AddressModel>> myAddresses = Future.delayed(Duration.zero, () {
      return AppSampleData.userAddresses;
    });
    return myAddresses;
  }

  @override
  Future<ResponseModel> removeProductFomWishlist(String detailsId, Product product) async {
    try {
      AppSampleData.wishlist.forEach((element) {
        if (element.id == detailsId) {
          element.products.remove(product);
        }
      });
      return ResponseModel(status: 1, message: 'Product successfully deleted');
    } catch (e) {
      return ResponseModel(status: 0, message: e.toString());
    }
  }

  @override
  Future<ResponseModel> updateWishList(String detailsId, String productList_id, Product product) {
    Future response = Future.delayed(Duration.zero, () {
      try {
        AppSampleData.wishlist.forEach((element) {
          if (element.id == detailsId) {
            element.products.add(product);

            return ResponseModel(status: 1, message: 'Product successfully Updated');
          }
        });
      } catch (e) {
        return ResponseModel(status: 0, message: e.toString());
      }
    });
    return response;
  }

  @override
  Future getUserWishList(String useId) {
    Future userWishList = Future.delayed(Duration.zero, () {
      return AppSampleData.wishlist;
    });
    return userWishList;
  }

  @override
  Future getStoreProduct(String storeName, String searchText) async{
    var result = await _fireStoreService.collectionStream(path: DatabaseUrls.colProducts,
      builder: (r,id){
      return r;
      }
       );

    result.first.then((value){
      print(value);
    });
    
    List<PurchaseDetails> stores = [
      PurchaseDetails(
        listName: 'Weekly food',
        amount: 350,
        customer: UserModel(name: 'Bernand Flores', city: '95455 Nürnberg'),
        storeDetails: StoreDataModel(
            name: 'REWE',
            image:
                'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
            street: 'Domstrasse 20 ',
          txtZip: '50668',
          city: 'Nürnberg',),
        quantity: 0,
        time: DateTime.now(),
        products: [
          Product(
              id: 'r1',
              name: 'Semi Skimmed Milk',
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              quantity: 0,
              price: 3,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                image:
                    'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
              )),
          Product(
              id: 'r2',
              name: 'A pieu, Milk One-Pack, White Milk One-Pack',
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
              quantity: 0,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              availableStatus: AvailableStatus.few,

              storeDetails: StoreDataModel(
                name: 'REWE',
                image:
                    'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              id: 'r3',
              name: 'Green milk 1L',
              
              quantity: 0,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/alpro.png?alt=media&token=5f1ce6bb-f206-461d-bd3e-dd9e3cbbdbc3',
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                name: 'REWE',
                image:
                    'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
        ],
      ),
      PurchaseDetails(
        listName: 'Weekly food',
        amount: 350,
        customer: UserModel(name: 'Bernand Flores', city: '95455 Nürnberg'),
        storeDetails: StoreDataModel(
          name: 'REWE',
          image:
              'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
          street: 'Domstrasse 20 ',
          txtZip: '50668',
          city: 'Nürnberg',
        ),
        quantity: 0,
        time: DateTime.now(),
        products: [
          Product(
              id: 'm1',
              name: 'Wagyu Beef Ribeye Steak',
              quantity: 0,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff'),
              category: 'GROCERY',
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
              availableStatus: AvailableStatus.runOut,
              
              storeDetails: StoreDataModel(
                image:
                    'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                name: 'Lidl',
                street: 'Hauptstrasse 6a',
                city: 'Aarbergen',
                txtZip: '56456',
              )),
          Product(
              id: 'm2',
              name: 'Semi Skimmed Milk',
              
              quantity: 0,
              price: 4,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                image:
                    'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                name: 'REWE',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
            id: 'm3',
            name: 'Organic Black Peppercorns',
            quantity: 0,
            category: 'GROCERY',
            createdBy: UserModel(
                name: 'Vanessa Gantikow-Schröder',
                imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
            price: 5,
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
            availableStatus: AvailableStatus.plenty,
            storeDetails: StoreDataModel(
              image:
                  'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
              name: 'Lidl',
              street: 'Hauptstrasse 6a',
              city: 'Aarbergen',
              txtZip: '56456',
            ),

          ),
          Product(
              id: 'm4',
              category: 'GROCERY',
              name: 'Yogurt Energy Cake',
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
              quantity: 0,
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                image:
                    'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                name: 'Lidl',
                street: 'Hauptstrasse 6a',
                city: 'Aarbergen',
                txtZip: '56456',
              )),
        ],
      ),
      PurchaseDetails(
          listName: 'Household',
          amount: 4,
          customer: UserModel(name: 'Bernand Flores', city: '95455 Nürnberg'),
          storeDetails: StoreDataModel(name: 'Lidl',
            street: 'Hauptstrasse 6a',
            city: 'Aarbergen',
            txtZip: '56456',),
          quantity: 0,
          time: DateTime.now(),
          products: [
            Product(
                id: 'm1',
                name: 'Wagyu Beef Ribeye Steak',
                quantity: 0,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                price: 2,
                imageUrl:
                    'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                availableStatus: AvailableStatus.runOut,
                
                storeDetails: StoreDataModel(
                  image:
                      'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  name: 'Lidl',
                  street: 'Hauptstrasse 6a',
                  city: 'Aarbergen',
                  txtZip: '56456',
                )),
            Product(
                id: 'm2',
                name: 'Semi Skimmed Milk',
                
                quantity: 0,
                price: 4,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                    'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  image:
                      'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  name: 'Lidl',
                  street: 'Hauptstrasse 6a',
                  city: 'Aarbergen',
                  txtZip: '56456',
                )),
            Product(
              id: 'm3',
              name: 'Organic Black Peppercorns',
              quantity: 0,
              price: 5,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
              availableStatus: AvailableStatus.plenty,
              storeDetails: StoreDataModel(
                image:
                    'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                name: 'Lidl',
                street: 'Hauptstrasse 6a',
                city: 'Aarbergen',
                txtZip: '56456',
              ),

            ),
            Product(
                id: 'm4',
                name: 'Yogurt Energy Cake',


                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
                quantity: 0,
                availableStatus: AvailableStatus.runOut,
                storeDetails: StoreDataModel(
                  image:
                      'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  name: 'Lidl',
                  street: 'Hauptstrasse 6a',
                  city: 'Aarbergen',
                  txtZip: '56456',
                )),
          ])
    ];

    Future<List<Product>> productlist = Future.delayed(Duration.zero, () {
      List<Product> _products = [];
      stores.forEach((element) {
        if (element.storeDetails.name.toLowerCase() == storeName.toLowerCase()) {
          element.products.forEach((pelement) {
            if (pelement.name.toLowerCase().contains(searchText.toLowerCase())) {
              pelement.type = element.listName;
              _products.add(pelement);
            }
          });
        }
      });
      return _products;
    });
    return productlist;
  }

  @override
  Future getUserStore(String userId) {
    Future userStores = Future.delayed(Duration.zero, () {
      return AppSampleData.userSelectedStores;
    });
    return userStores;
  }

  @override
  Future deleteSelectedStore(StoreDataModel store) {
    AppSampleData.userSelectedStores.remove(store);
  }

  @override
  Future getUserDetails(String userId) async {
    print('start get User Details');
    final result =
        _fireStoreService.documentFuture(path: '${DatabaseUrls.colUsers}/$userId', builder: (data, docId) => data);
    var data = await result;
    print('end get User Details: $result');
    if (data != null) {
      UserModel user = UserModel.fromMap(data);
      return user;
    } else {
      return UserModel();
    }
  }

  @override
  Future getUserAddress(String userId) {
    // TODO: implement getUserAddress
    Future userAddresses = Future.delayed(Duration.zero, () {
      return <AddressModel>[
        AddressModel(
            country: 'Germany',
            name: 'Berlin',
            street: 'Dunnheimerstraße 3a',
            city: 'Berlin',
            zipCode: '92932',
            state: 'Berlin',
            apartment: '72',
            entrance: '1',
            floor: '6'),
        AddressModel(
            country: 'Germany',
            name: 'Berlin',
            street: 'Dunnheimerstraße 3a',
            city: 'Berlin',
            zipCode: '92932',
            state: 'Berlin',
            apartment: '72',
            entrance: '1',
            floor: '6'),
        AddressModel(
            country: 'Germany',
            name: 'Berlin',
            street: 'Dunnheimerstraße 3a',
            city: 'Berlin',
            zipCode: '92932',
            state: 'Berlin',
            apartment: '72',
            entrance: '1',
            floor: '6')
      ];
    });
    return userAddresses;
  }

  List<UserModel> userlist = [
    UserModel(
        name: 'Jessica miles',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/sample_profile.png?alt=media&token=5bbcd983-45aa-4c98-8487-1b8a79650ac7',
        status: ShareStatus.Approve),
  ];

//  @override
//  Future getUserList() {
//    // TODO: implement getUserList
//    final users = Future.delayed(Duration.zero, () {
//      return userlist;
//    });
//    return users;
//  }

  List<UserModel> allusers = [
    UserModel(
        name: 'Jakob Merz',
        imageUrl:
            'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',
        status: ShareStatus.Unknown,
        city: '95455 Nürnberg'),
    UserModel(
        name: 'Sck coo',
        imageUrl:
            'https://images.unsplash.com/photo-1563122870-6b0b48a0af09?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8YmxhY2slMjBtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
        status: ShareStatus.Unknown,
      street: 'Domstrasse 20 ',
      zipCode: '50668',
      city: 'Nürnberg',
    country: 'Germany',),
    UserModel(
        name: 'B Ajdj',
        imageUrl:
            'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
        status: ShareStatus.Unknown,

      street: 'Domstrasse 20 ',
      zipCode: '50668',
      city: 'Nürnberg',),
    UserModel(
        name: 'Jane Cooper',
        street: 'Domstrasse 20 ',
        zipCode: '50668',
        country: 'Germany',
        city: 'Nürnberg',
        imageUrl:
            'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',

        status: ShareStatus.Unknown),
    UserModel(
        name: 'Jane Fisher',
        street: 'Domstrasse 20 ',
        zipCode: '50668',
        city: 'Nürnberg',
        country: 'Germany',
        imageUrl:
            'https://menandhealing.ca/wp-content/uploads/2020/09/banner-psy-735x550.jpg',
        status: ShareStatus.Unknown),
    UserModel(
        name: 'Jane Warren',
        street: 'Domstrasse 20 ',
        zipCode: '50668',
        city: 'Nürnberg',
        country: 'Germany',
        imageUrl:
            'https://globalnews.ca/wp-content/uploads/2020/06/daniel-salisbury-from-facebook.jpg?quality=85&strip=all',
        status: ShareStatus.Unknown),
  ];

  @override
  Future searchUserList(String searchtext) {
    // TODO: implement searchUserList
    print(searchtext);
    Future searchUserList = Future.delayed(Duration.zero, () {
      List<UserModel> user = [];
      allusers.forEach((element) {
        if (element.name.toLowerCase().contains(searchtext.toLowerCase())) {
          user.add(element);
          print('added');
        }
      });
      return user;
    });
    return searchUserList;
  }

  @override
  Future shareUser(UserModel user) {
    // TODO: implement shareUser
    userlist.add(user);
  }

  @override
  Future removeUser(UserModel user) {
    // TODO: implement removeUser
    userlist.remove(user);
    allusers.forEach((element) {
      if (element.name == user.name) {
        element.status = ShareStatus.Unknown;
      }
    });
  }

  @override
  Stream<List<CourierCandidate>> getCandidatesList() {
    StreamController<List<CourierCandidate>> controller = StreamController();

    controller.add(AppSampleData.candidatesList);
    controller.close();
    return controller.stream;
  }

  @override
  Future<ResponseModel> onUpdateCandidate(CourierCandidate candidate) async {
    try {
      for (int i = 0; i < AppSampleData.candidatesList.length; i++) {
        if (AppSampleData.candidatesList[i].id == candidate.id) {
          AppSampleData.candidatesList[i] = candidate;
        }
      }
      return ResponseModel(status: 1, message: 'Successfully updated');
    } catch (e) {
      return ResponseModel(status: 0, message: e);
    }
  }

  @override
  Future getAlternativeicon(String serachtext, String storeName) {
    List<PurchaseDetails> stores = [
      PurchaseDetails(
        listName: 'Weekly food',
        amount: 350,
        customer: UserModel(
          name: 'Bernand Flores',
          city: '95455 Nürnberg',
        ),
        storeDetails: StoreDataModel(
          name: 'REWE',
          image:
              'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
          street: 'numbrecht Hauptstrable 12',
        ),
        quantity: 0,
        time: DateTime.now(),
        products: [
          Product(
              name: 'Semi Skimmed Milk',
              
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              quantity: 0,
              price: 3,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'Appliances',
              availableStatus: AvailableStatus.plenty,
              storeDetails: StoreDataModel(
                name: 'REWE',
                image:
                    'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'numbrecht Hauptstrable 12',
              )),
          Product(
              name: 'A pieu, Milk One-Pack, White Milk One-Pack',
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
              quantity: 0,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'Appliances',
              availableStatus: AvailableStatus.few,

              storeDetails: StoreDataModel(
                name: 'REWE',
                image:
                    'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'numbrecht Hauptstrable 12',
              )),
          Product(
              name: 'Green milk 1L',
              
              quantity: 0,
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'Appliances',
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/alpro.png?alt=media&token=5f1ce6bb-f206-461d-bd3e-dd9e3cbbdbc3',
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                name: 'REWE',
                image:
                    'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'numbrecht Hauptstrable 12',
              )),
          Product(
              name: 'Wagyu Beef Ribeye Steak',
              quantity: 0,
              price: 4,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              imageUrl:
                  'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              availableStatus: AvailableStatus.runOut,
              
              storeDetails: StoreDataModel(
                image:
                    'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                name: 'Lidl',
                street: 'Hauptstrasse 6a',
                city: 'Aarbergen',
                txtZip: '56456',
              )),
          Product(
              name: 'Semi Skimmed Milk',
              
              quantity: 0,
              price: 5,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              availableStatus: AvailableStatus.few,
              storeDetails: StoreDataModel(
                image:
                    'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                name: 'Lidl',
                street: 'Hauptstrasse 6a',
                city: 'Aarbergen',
                txtZip: '56456',
              )),
          Product(
              name: 'Organic Black Peppercorns',
              quantity: 0,
              price: 5,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
              availableStatus: AvailableStatus.plenty,

              storeDetails: StoreDataModel(
                image:
                    'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                name: 'Lidl',
                street: 'Hauptstrasse 6a',
                city: 'Aarbergen',
                txtZip: '56456',
              )),
          Product(
              name: 'Yogurt Energy Cake',


              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
              quantity: 0,
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                image:
                    'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                name: 'Lidl',
                street: 'Hauptstrasse 6a',
                city: 'Aarbergen',
                txtZip: '56456',
              )),
        ],
      ),
      PurchaseDetails(
        listName: 'Weekly food',
        amount: 350,
        customer: UserModel(name: 'Bernand Flores', city: '95455 Nürnberg'),
        storeDetails: StoreDataModel(
          name: 'REWE',
          image:
              'ttps://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
          street: 'Domstrasse 20 ',
          txtZip: '50668',
          city: 'Nürnberg',
        ),
        quantity: 0,
        time: DateTime.now(),
        products: [
          Product(
              name: 'Semi Skimmed Milk',
              
              imageUrl:
                  'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
              quantity: 0,
              price: 7,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              availableStatus: AvailableStatus.plenty,
              storeDetails: StoreDataModel(
                name: 'REWE',
                image:
                    'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'A pieu, Milk One-Pack, White Milk One-Pack',
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
              quantity: 0,
              price: 5,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              availableStatus: AvailableStatus.few,

              storeDetails: StoreDataModel(
                name: 'REWE',
                image:
                    'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
          Product(
              name: 'Green milk 1L',
              quantity: 0,
              
              category: 'GROCERY',
              price: 2,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/alpro.png?alt=media&token=5f1ce6bb-f206-461d-bd3e-dd9e3cbbdbc3',
              availableStatus: AvailableStatus.runOut,
              storeDetails: StoreDataModel(
                name: 'REWE',
                image:
                    'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                street: 'Domstrasse 20 ',
                txtZip: '50668',
                city: 'Nürnberg',
              )),
        ],
      ),
      PurchaseDetails(
          listName: 'Household',
          amount: 4,
          customer: UserModel(name: 'Bernand Flores', city: '95455 Nürnberg'),
          storeDetails: StoreDataModel(name: 'Lidl', street: 'numbrecht Hauptstrable 12'),
          quantity: 0,
          time: DateTime.now(),
          products: [
            Product(
                name: 'Wagyu Beef Ribeye Steak',

                quantity: 0,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                category: 'GROCERY',
                imageUrl:
                    'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                availableStatus: AvailableStatus.runOut,
                
                storeDetails: StoreDataModel(
                  image:
                      'https://dwkujuq9vpuly.cloudfront.net/news/wp-content/uploads/2019/10/Lidl.jpg',
                  name: 'Lidl',
                  street: 'Hauptstrasse 6a',
                  city: 'Aarbergen',
                  txtZip: '56456',
                )),
            Product(
                name: 'Semi Skimmed Milk',
                
                quantity: 0,
                price: 4,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                category: 'GROCERY',
                imageUrl:
                    'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                availableStatus: AvailableStatus.few),
            Product(
              name: 'Organic Black Peppercorns',
              quantity: 0,
              price: 5,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                      'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              category: 'GROCERY',
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
              availableStatus: AvailableStatus.plenty,

            ),
            Product(
                category: 'GROCERY',
                name: 'Yogurt Energy Cake',


                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                        'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
                quantity: 0,
                availableStatus: AvailableStatus.runOut),
          ])
    ];

    Future<List<Product>> productlist = Future.delayed(Duration.zero, () {
      print('object==$storeName==$serachtext');
      List<Product> _products = [];
      stores.forEach((element) {
        print('element${element.storeDetails.name.toLowerCase()}');
        print('store==$storeName');
        if (element.storeDetails.name.toLowerCase() == storeName.toLowerCase()) {
          element.products.forEach((pelement) {
            if (pelement.name.toLowerCase().contains(serachtext.toLowerCase())) {
              pelement.type = element.listName;
              _products.add(pelement);
            }
          });
        }
      });
      return _products;
    });
    return productlist;
  }

  @override
  Future getAssignOrderForCourier(String courierId) {
    Future orders = Future.delayed(Duration.zero, () {
      return AppSampleData.asignCourierOrder;
    });
    return orders;
  }

  @override
  Future getOfferbyCourier(String courierId) {
    // TODO: implement getOfferbyCourier
    Future order = Future.delayed(Duration.zero, () {
      return OrderOrPurchases(
        purchaseDetails: PurchaseDetails(
          products: [
            Product(
                name: 'Wagyu Beef Ribeye Steak',
                
                imageUrl:
                'https://i5.walmartimages.com/asr/600b3ccf-8ac8-4ae9-aef3-98297d811c22.25df701727c94821224d691001902711.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                quantity: 2,
                price: 3,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.plenty,
                storeDetails: StoreDataModel(
                  name: 'REWE',
                  image:
                  'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                ),
                alternativeProduct: [
                  Product(
                      name: 'Orangic Black Peppercorns',
                      quantity: 1,

                      price: 2,
                      createdBy: UserModel(
                          name: 'Vanessa Gantikow-Schröder',
                          imageUrl:
                          'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                      imageUrl:
                      'https://i5.walmartimages.com/asr/dd80f1d3-6347-4cff-a3f5-89333367f804.c16c18b1bf6febd8fc208e4033d59e15.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                      availableStatus: AvailableStatus.runOut,
                      storeDetails: StoreDataModel(
                        name: 'REWE',
                        image:
                        'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                        street: 'Domstrasse 20 ',
                        txtZip: '50668',
                        city: 'Nürnberg',
                      )),
                ]),
            Product(
                name: 'Semi Skimmed Milk',
                
                imageUrl:
                'https://i5.walmartimages.com/asr/11cddf33-e7d7-4946-9580-578d7136a0a7_1.8e96101312ffe08a9d74f2709255173c.jpeg?odnWidth=undefined&odnHeight=undefined&odnBg=ffffff',
                quantity: 10,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  name: 'REWE',
                  image:
                  'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                ),
                alternativeProduct: [
                  Product(
                      name: 'Orangic Black Peppercorns',
                      quantity: 1,

                      price: 2,
                      createdBy: UserModel(
                          name: 'Vanessa Gantikow-Schröder',
                          imageUrl:
                          'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                      imageUrl:
                      'https://i5.walmartimages.com/asr/dd80f1d3-6347-4cff-a3f5-89333367f804.c16c18b1bf6febd8fc208e4033d59e15.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                      availableStatus: AvailableStatus.runOut,
                      storeDetails: StoreDataModel(
                        name: 'REWE',
                        image:
                        'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                        street: 'Domstrasse 20 ',
                        txtZip: '50668',
                        city: 'Nürnberg',
                      )),
                ]),
            Product(
                name: 'Orangic Black Peppercorns',
                quantity: 1,

                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                price: 2,
                imageUrl:
                'https://i5.walmartimages.com/asr/dd80f1d3-6347-4cff-a3f5-89333367f804.c16c18b1bf6febd8fc208e4033d59e15.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
                availableStatus: AvailableStatus.runOut,
                storeDetails: StoreDataModel(
                  name: 'REWE',
                  image:
                  'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                name: 'Yogurt Energy Cake',


                quantity: 1,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/alpro.png?alt=media&token=5f1ce6bb-f206-461d-bd3e-dd9e3cbbdbc3',
                availableStatus: AvailableStatus.unknown,
                storeDetails: StoreDataModel(
                  name: 'REWE',
                  image:
                  'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                name: 'Miracle Milk Hand-Bath Oil Coca-Vanilla',
                
                quantity: 2,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/alpro.png?alt=media&token=5f1ce6bb-f206-461d-bd3e-dd9e3cbbdbc3',
                availableStatus: AvailableStatus.few,
                storeDetails: StoreDataModel(
                  name: 'REWE',
                  image:
                  'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                name: 'Soya Kokos PROFESSIONAL Milk',
                
                quantity: 10,
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/alpro.png?alt=media&token=5f1ce6bb-f206-461d-bd3e-dd9e3cbbdbc3',
                availableStatus: AvailableStatus.runOut,
                storeDetails: StoreDataModel(
                  name: 'REWE',
                  image:
                  'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
                name: 'Short-grain rice',
                
                price: 2,
                createdBy: UserModel(
                    name: 'Vanessa Gantikow-Schröder',
                    imageUrl:
                    'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
                imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/alpro.png?alt=media&token=5f1ce6bb-f206-461d-bd3e-dd9e3cbbdbc3',
                availableStatus: AvailableStatus.plenty,
                storeDetails: StoreDataModel(
                  name: 'REWE',
                  image:
                  'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
                  street: 'Domstrasse 20 ',
                  txtZip: '50668',
                  city: 'Nürnberg',
                )),
            Product(
              name: 'Organic Black Peppercorns',
              quantity: 0,
              price: 5,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
              'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
              availableStatus: AvailableStatus.plenty,

            ),
            Product(
              name: 'Organic Black Peppercorns',
              quantity: 0,
              price: 5,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
              'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
              availableStatus: AvailableStatus.plenty,

            ),
            Product(
              name: 'Organic Black Peppercorns',
              quantity: 0,
              price: 5,
              createdBy: UserModel(
                  name: 'Vanessa Gantikow-Schröder',
                  imageUrl:
                  'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg'),
              imageUrl:
              'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/vanille.png?alt=media&token=757f4ab2-1d55-4dfa-bf48-e8fd671ee1dd',
              availableStatus: AvailableStatus.plenty,

            ),
          ],
        ),
        orderAmount: 350,
        clientDetails: ClientDetails(
            name: 'Bernand Flores',
            street: 'Knesebeckstrasse 76',
            city: 'Nürnberg',
            zip: '92323',
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/user_zack.png?alt=media&token=6973510b-ca98-4ec5-a641-a3643b88d415'),
        storeDetails: StoreDataModel(
          name: 'REWE',
          image:
              'https://www.strategeast.org/wp-content/uploads/2018/11/Rewe.jpg',
          street: 'Domstrasse 20 ',
          txtZip: '50668',
          city: 'Nürnberg',
        ),
        quantity: 10,
      );
    });
    return order;
  }

  @override
  Future getUserNotificationList(String useId) {
    Future notificationList = Future.delayed(Duration.zero, () {
      return AppSampleData.notificationList;
    });
    return notificationList;
  }

  @override
  Future<bool> checkUserData(UserModel user) async {
    // TODO: implement checkUserData

    final result =
        _fireStoreService.documentStream(path: '${DatabaseUrls.colUsers}/${user.id}', builder: (data, docId) => data);
    print(result.first);
    if (result.first != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Stream<List<ChatMessage>> getMessageList() {
    StreamController<List<ChatMessage>> controller = StreamController();
    controller.sink.add(AppSampleData.chatMessages);

    controller.close();
    return controller.stream;
  }

  @override
  Future<ResponseModel> sendMessage(String message, UserModel sendBy) async {
    try {
      AppSampleData.chatMessages.add(ChatMessage(createdAt: DateTime.now(), message: message, sendBy: sendBy));
      return ResponseModel(status: 1, message: 'Success');
    } catch (e) {
      return ResponseModel(status: 0, message: e.toString());
    }
  }

  @override
  Stream<List<Product>> getWishListProductList(PurchaseDetails purchaseDetails) {
    StreamController<List<Product>> controller = StreamController();
    AppSampleData.wishlist.forEach((element) {
      if (element.id == purchaseDetails.id) {
        controller.sink.add(element.products);
      }
    });

    controller.close();
    return controller.stream;
  }

  @override
  Future<ResponseModel> onUpdateVerifyField(int value, UserModel user) async {
    try {
      await _fireStoreService.updateData(path: '${DatabaseUrls.colUsers}', docID: user.id, data: {'verify': value});
      return ResponseModel(status: 1, message: 'Update successfully');
    } catch (e) {
      return ResponseModel(status: 0, message: e.message);
    }
  }

  @override
  Future getOfferOrderForCourier(String courierId) async {
    Future orders = Future.delayed(Duration.zero, () {
      return AppSampleData.courierOffers;
    });
    return orders;
  }
  @override
  Future getDeclineOfferOrderForCourier(String courierId) async {
    Future orders = Future.delayed(Duration.zero, () {
      return AppSampleData.declineOffers;
    });
    return orders;
  }

  @override
  Future<ResponseModel> onDeleteOffer(OrderOrPurchases order) async {
    try {
      for (int i = 0; i < AppSampleData.courierOffers.length; i++) {
        if (AppSampleData.courierOffers[i].orderID == order.orderID) {
          AppSampleData.courierOffers.removeAt(i);
        }
      }
      return ResponseModel(status: 1, message: 'Success');
    } catch (e) {
      return ResponseModel(status: 0, message: e);
    }
  }

  @override
  Future<List<OrderByStore>> getPastOrders(String courierID) async {
    return AppSampleData.pastOrders;
  }

  @override
  Future getOrdersForCourier(String courierId) async {
    Future orders = Future.delayed(Duration.zero, () {
      if (AppSampleData.courierOrders != null) return AppSampleData.courierOrders;
    });
    return orders;
  }

  @override
  Future getCourierCandidateList() async {
    List<CourierCandidate> candidatesList = [
      CourierCandidate(
          imageUrl:
              'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
          name: 'Vanessa Gantikow-Schröder',
          stars: 3,
          reviews: 45,
          totalOrder: 1,
          verifyStatus: VerifyStatus.Varified,
          insurance: true,
          phoneNumber: '(702) 875-4605',
          time: '8:00-20:00',
          date: DateTime.now(),
          ratings: [
            RatingModel(
              rateBy: UserModel(
                id: '1',
              ),
              rating: 3
            ),
            RatingModel(
                rateBy: UserModel(
                  id: '2',
                ),
                rating: 3
            ),
          ],
          charge: 10),
      CourierCandidate(
          imageUrl:
              'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',
          name: 'Connie Webb',
          stars: 3,
          reviews: 30,
          totalOrder: 90,
          verifyStatus: VerifyStatus.Reliable,
          phoneNumber: '(702) 875-4605',
          time: '8:00-20:00',
    ratings: [
    RatingModel(
    rateBy: UserModel(
    id: '1',
    ),
    rating: 3
    ),
    RatingModel(
    rateBy: UserModel(
    id: '2',
    ),
    rating: 3
    ),],
          date: DateTime.now(),

          insurance: false,
          charge: 12),
      CourierCandidate(
          imageUrl:
              'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',
          name: 'Marjorie Miles',
          stars: 4,
          reviews: 24,
          totalOrder: 1,
          verifyStatus: VerifyStatus.Unknown,
          phoneNumber: '(702) 875-4605',
          insurance: false,
          time: '8:00-20:00',
          ratings: [
            RatingModel(
                rateBy: UserModel(
                  id: '1',
                ),
                rating: 3
            ),
            RatingModel(
                rateBy: UserModel(
                  id: '2',
                ),
                rating: 3
            ),],
          date: DateTime.now(),
          charge: 15),
    ];
    return candidatesList;
  }

  @override
  Future<List<PackageModel>> getPackagesList() async {
    // TODO: implement getPackagesList
    return [
      PackageModel(
          clientDetails: UserModel(
            imageUrl:
                'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
            name: 'Vanessa Gantikow-Schröder',
            street: '92323 Nürnberg',
            addressLine: 'Knesebeckstrasse 76',
          ),
          totalItems: 10),
      PackageModel(
          clientDetails: UserModel(
            imageUrl:
                'https://hips.hearstapps.com/hbz.h-cdn.co/assets/17/15/hbz-hottest-men-jon-hamm-gettyimages-141278424.jpg',
            name: 'John Fisher',
            street: '82323 Nürnberg',
            addressLine: 'Knesebeckstrasse 75',
          ),
          totalItems: 55),
      PackageModel(
          clientDetails: UserModel(
            imageUrl:
                'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
            name: 'Smith Fisher',
            street: '22323 Nürnberg',
            addressLine: 'Knesebeckstrasse 70',
          ),
          totalItems: 127),
      PackageModel(
          clientDetails: UserModel(
            imageUrl:
                'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F04%2Fjlcloseup-2000.jpg',
            name: 'Andro Fisher',
            street: '94323 Nürnberg',
            addressLine: 'Knesebeckstrasse 72',
          ),
          totalItems: 27),
    ];
  }

  @override
  Future<List<ShopModel>> getShopList() async{
    var result =  _fireStoreService.collectionStream(path: DatabaseUrls.colShopList,
        builder: (data,id){
          return ShopModel.fromMap(data,id);
        }
    );
    List<ShopModel>_shopList=[];
    result.first.then((values){
      values.forEach((element) {
        _shopList.add(element);

      });

      AppConstants.printWrapped(values.toString());
    });
    return _shopList;
  }


  @override
  Stream<List<StoreModel>> getStoreList() {
    var result =  _fireStoreService.collectionStream(path: DatabaseUrls.colStores,
        builder: (data,id){
          return StoreModel.fromMap(data,id);
        }
    );
    return result;
  }

  @override
  Future<List<PaymentModel>> getPayments() async{
    var result =  _fireStoreService.collectionStream(path: DatabaseUrls.colPayments,
        builder: (data,id){
          return PaymentModel.fromMap(data,id);
        }
    );
    List<PaymentModel>payments=[];
    result.first.then((values){
      values.forEach((element) {
        payments.add(element);

      });

      AppConstants.printWrapped(values.toString());
    });
    return payments;
  }

  @override
  Future<List<NotificationModel>> getNotificationList() async{
    var result = await _fireStoreService.collectionStream(path: DatabaseUrls.colNotifications,
        builder: (data,id){
          return NotificationModel.fromMap(data,id);
        }
    );
    List<NotificationModel>notifications=[];
    result.first.then((values){
      values.forEach((element) {
        notifications.add(element);

      });
      print('orderLength=${notifications.length}');
      AppConstants.printWrapped(values.toString());
    });
    return notifications;
  }

  @override
  Stream<List<ShopItemModel>> getShopItems(String shopListID) {
    final result = _fireStoreService.collectionStream(
      path: '${DatabaseUrls.colShopList}/$shopListID/col_List_Items',
      builder: (data, docId) {
        return ShopItemModel.fromMap(data,docId);
      },
    );
    return result;
  }

  @override
  Stream<List<OrderItem>> getOrderItems(String orderID) {
    final result = _fireStoreService.collectionStream(
      path: '${DatabaseUrls.colOrders}/$orderID/col_Order_Items',
      builder: (data, docId) {
        return OrderItem.fromMap(data,docId);
      },
    );
    return result;
  }

  @override
  Stream<List<CourierProposal>> getOrderProposal(String orderID) {
    final result = _fireStoreService.collectionStream(
      path: '${DatabaseUrls.colOrders}/$orderID/Col_CourierProposed',
      builder: (data, docId) {
        print('ddd$data');
        return CourierProposal.fromMap(data,docId);
      },
    );
    return result;
  }

  @override
  Future getOrderByStoreList() {
    return Future.delayed(Duration.zero, () {
      return AppSampleData.orderByStoreList;
    });
  }

  @override
  Future onSeachProduct(String searchText) {
    Future<List<Product>> productlist = Future.delayed(Duration.zero, () {
      List<Product> _products = [];

      AppSampleData.productList.forEach((element) {
       if( element.name.toLowerCase().contains(searchText.toLowerCase())){
         _products.add(element);
       }
      });

      return _products;
    });
    return productlist;
  }

  @override
  Future getCompletedOrders() {
    Future orderList = Future.delayed(Duration.zero, () {
      return AppSampleData.completedOrderList;
    });

    return orderList;
  }

  @override
  Future<List<UserModel>> getUserList() {
    final result = _fireStoreService.collectionFuture(
      path: '${DatabaseUrls.colUsers}',
      builder: (data, docId) {
        UserModel _user=UserModel.fromMap(data);
        return _user;


      },
    );

    return result;
  }

  @override
  Stream<int> userUnreadMessage(String otherUserID, String userID) {
    print('otherUserId==$otherUserID');

    final StreamController<int> unReadMessageController = StreamController<int>();
      if(otherUserID=='2'){
        unReadMessageController.sink.add(1);

      }




      return unReadMessageController.stream;

  }

}
