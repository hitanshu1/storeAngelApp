
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/screens/courier/courier_main_page.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class CourierCurrentOrderTabViewModel extends BaseModel{


  void navigatorPop(OrderOrPurchases order) {
    if(order!=null){
      if(order.status==OrderPurchaseStatus.OrderRunning){
        navigationService.navigateTo(CourierMainAppScreen.routeName,arguments: 2);
        return;
      }
    }
    navigationService.pop();


  }
  void navigateToScreen(String routeName,BuildContext context,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments).then((value){
      StatusBarService.changeStatusBarColor(StatusBarType.White, context);
    });
  }
  final _imagePicker = ImagePicker();
  File _imageFile;
  File get imageFile =>_imageFile;
  List<UserModel>clientList=[];
  List<UserModel>selectedClients=[];
  File deliveryItemsImage;
  List<File>receiptsImages=[];

  List<Product>products=[];
  OrderOrPurchases order;
  bool get selectedValues{
    return clientList.length==selectedClients.length;
  }
  void onSelectCandidate(int index){
    setState(ViewState.Busy);
    if(order.status==OrderPurchaseStatus.OrderAccepted||order.status==OrderPurchaseStatus.PriceCheck){
      if(selectedValues){
        if (selectedClients.contains(clientList[index])) {
          getProduct();
        } else {
          selectedClients.add(order.clientlist[index]);
          getProduct();
        }
      }else{
        selectedClients = [];
        selectedClients.add(clientList[index]);
      }
    }else{
      selectedClients=[];
      selectedClients.add(order.clientlist[index]);
      getProduct();
    }


    setState(ViewState.Idle);
  }
  void onSelectAll(){
    setState(ViewState.Busy);

    selectedClients=order.clientlist;
    //getProduct();
    setState(ViewState.Idle);
  }

  void onUnSelectAll(){
    setState(ViewState.Busy);
    selectedClients=[order.clientlist.first];
    //getProduct();
    setState(ViewState.Idle);
  }

  bool get deleteVisible=>order.status == OrderPurchaseStatus.Proposal || order.status == OrderPurchaseStatus.MoneyTransfer;
  bool get shareVisible=>order.status == OrderPurchaseStatus.OrderAccepted;
  bool get enableSelect=>order.status == OrderPurchaseStatus.OrderAccepted || order.status == OrderPurchaseStatus.PriceCheck;
  bool get bigHeight=>order.status == OrderPurchaseStatus.OrderAccepted || order.status == OrderPurchaseStatus.PriceCheck;
  bool get isProposalOrMoneyTransferView=>order.status == OrderPurchaseStatus.Proposal || order.status == OrderPurchaseStatus.MoneyTransfer;
  bool get isOrderAccepted=>order.status == OrderPurchaseStatus.OrderAccepted;
  bool get isPriceCheckView=>order.status == OrderPurchaseStatus.PriceCheck;
  bool get isOrderRunningView=>order.status == OrderPurchaseStatus.OrderRunning;
  bool get isOrderDeliveredView =>order.status == OrderPurchaseStatus.OrderDelivered;

  void initializeData(OrderOrPurchases orderValue){
    setState(ViewState.Busy);
    order=orderValue;
    clientList=orderValue.clientlist;
    selectedClients.add(orderValue.clientlist.first);
    getProduct();
    setState(ViewState.Idle);
  }

  void getProduct(){
    products=[];
    selectedClients.forEach((element) {
      order.purchaseDetails.products.forEach((productValue) {
        //if(productValue.assignClient?.id==element?.id){
          products.add(productValue);
       // }
      });
    });
    setState(ViewState.Idle);
  }

  void updateOrderStatus(OrderPurchaseStatus orderPurchaseStatus){
    order.status=orderPurchaseStatus;
    setState(ViewState.Idle);
  }
  void onSelectDeliveryImages(PlatformFile selectedImage){
    setState(ViewState.Busy);
   deliveryItemsImage=File(selectedImage.path);
    setState(ViewState.Idle);
  }
  Future<bool> openCameraForDeliveryImage() async {
    try {
      final _image = await _imagePicker.getImage(source: ImageSource.camera);
      deliveryItemsImage = File(_image.path);
      navigationService.pop();
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }

  Future<bool> openGalleryForDeliveryImage() async {
    setState(ViewState.Busy);
    try {
      final _image = await _imagePicker.getImage(source: ImageSource.gallery);
      deliveryItemsImage = File(_image.path);
      navigationService.pop();
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      setState(ViewState.Idle);
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }
  Future<bool> openCameraForReceiptImages() async {
    try {
      final _image = await _imagePicker.getImage(source: ImageSource.camera);
      receiptsImages.add(File(_image.path));
      navigationService.pop();
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }

  Future<bool> openGalleryForReceiptImages() async {
    setState(ViewState.Busy);
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true
      );
      if(result!=null){
        result.files.forEach((element) {
          receiptsImages.add(File(element.path));
        });
      }
      navigationService.pop();
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      setState(ViewState.Idle);
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }


}