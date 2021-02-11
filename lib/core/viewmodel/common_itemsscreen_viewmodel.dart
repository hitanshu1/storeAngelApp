import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/consts/notification_type.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/enums/varify_status.dart';
import 'package:storeangelApp/core/models/app_image.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/multiple_imagepicker.dart';

import '../../ui/shared/MyUtils.dart';

class CommonItemScreenViewModel extends BaseModel{
  int selectedIndex = 0;
  bool loading = true;
  bool blurScreen = false;
  List<String>units=["Stk", "Ltr", "ml", "kg", "gr" , "mg"];

  String selectUnit;
  void onSelectUnit(String val){
    setState(ViewState.Busy);
    selectUnit=val;
    setState(ViewState.Idle);
  }

  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  final _imagePicker = ImagePicker();
  bool hasShadow = false;

  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,BuildContext context,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value){
      StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    });
  }
  List<File>lastItemFileimages=[];

  List<Product>selectedProduct=[];
  List<Product>products=[];
  void getStroeProductList(String storename,String productname)async{
    setState(ViewState.Busy);
    products=await database.getStoreProduct(storename,productname);
    setState(ViewState.Idle);
  }

  void clearFileImage(){
    lastItemFileimages=[];
    setState(ViewState.Idle);
  }

  void initializeData( List<Product>products){
    selectedProduct=[];
    setState(ViewState.Busy);
    selectedProduct =products;
    setState(ViewState.Idle);
  }

  void addAlternativeProductToProduct(List<Product>altProductList,int currentIndex){
    setState(ViewState.Busy);
    if(selectedProduct[currentIndex].alternativeProduct!=null){
      selectedProduct[currentIndex].alternativeProduct.addAll(altProductList);
    }else{
      selectedProduct[currentIndex].alternativeProduct=altProductList;
    }
    setState(ViewState.Idle);
  }
  void onIncrement(int index){
    setState(ViewState.Busy);
    products[index].quantity++;
    setState(ViewState.Idle);
  }

 int get length{
    int length=0;
    products.forEach((element) {
      if(element.quantity>0){
        length++;
      }
    });
    return length;
 }
 void getSelectedProduct(){
    selectedProduct=[];
    products.forEach((element) {
      if(element.quantity>0){
        selectedProduct.add(element);
        setState(ViewState.Idle);
      }
    });
 }
 List<Product> get selectedProductList{
    List<Product>_products=[];
   products.forEach((element) {
     if(element.quantity>0){
       _products.add(element);
       setState(ViewState.Idle);
     }
   });
   return _products;
 }

 set setSelectedIndex(int index){
    selectedIndex = index;
    hasShadow = false;
    setState(ViewState.Idle);
 }

 set setBlur(bool blur){
    this.blurScreen = blur;
    setState(ViewState.Idle);
 }

  void onDecrement(int index){
    setState(ViewState.Busy);

    products[index].quantity--;
    setState(ViewState.Idle);
  }
  void onRemoveImage(int index){
    setState(ViewState.Busy);
    lastItemFileimages.removeAt(index);
    setState(ViewState.Idle);
  }

  void addImage(File imageFile){
    setState(ViewState.Busy);
    lastItemFileimages.add(imageFile);
    setState(ViewState.Idle);
  }


  Future<bool> openCamera(BuildContext context) async {
    try {
      StatusBarService.changeColor(Colors.black);
      final _image = await _imagePicker.getImage(source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.rear
      );
      StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);

      lastItemFileimages.add(File(_image.path));
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }

 void openGallery(BuildContext context) async {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>PlugInImageGalleryList())).then((value){
      if(value!=null){
        List<AppImage>images=[];
        images.addAll(value);
        images.forEach((element) {
          addImage(element.fileImage);
        });
      }

    });
  }

  void checkIfHasShadow(bool isScrolled){
    if(isScrolled)hasShadow = true;
    else hasShadow = false;

    setState(ViewState.Idle);
  }

  void addToOrderList(){
    setState(ViewState.Busy);
    AppSampleData.orderList.add(OrderOrPurchases(
      type: OrderAndPurchaseType.Purchase,
      productName: 'Soy Milk',
      shopName: 'Metro',
      orderAmount: 130,
      status: OrderPurchaseStatus.OrderPlaced,
      quantity: 5,
      purchaseDetails: PurchaseDetails(
          listName: 'Household',
          notificationType: NotificationType.shareNotification.notificationValue,
          storeDetails: StoreDataModel(
              image: 'assets/images/sample_images/lidl.png',
              name: 'Metro',
              street: 'Hauptstrable 12',
              city: 'Nürnberg',
              txtZip: '92323',
              openingTime: '9:00',
              closingTime: '22:00'),
          amount: 400,
          customer: UserModel(name: 'Bernand Flores', imageUrl: 'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/sample_profile.png?alt=media&token=5bbcd983-45aa-4c98-8487-1b8a79650ac7'),
          quantity: 9,
          time: DateTime.now(),
          products: selectedProduct),
      proposalDetails: ProposalDetails(
          totalProposals: 9, unseenProposal: 5, time: DateTime.now().subtract(new Duration(minutes: 15))),
      candidates: [CourierCandidate(
        name: 'ack Fisher',
        stars: 3,
        verifyStatus: VerifyStatus.Reliable,
        time: '1 hours ago',
        imageUrl:
        'https://www.stuttgarter-nachrichten.de/media.media.d8c538e0-8bc1-4efc-84b3-ac0ef7241c24.original1024.jpg',
        status: 'Updated',
      ),
        CourierCandidate(
          name: 'ack Fisher',
          stars: 3,
          verifyStatus: VerifyStatus.Reliable,
          time: '1 hours ago',
          imageUrl:
          'https://www.stuttgarter-nachrichten.de/media.media.d8c538e0-8bc1-4efc-84b3-ac0ef7241c24.original1024.jpg',
          status: 'Updated',
        )],
    ));
    setState(ViewState.Idle);
  }

}