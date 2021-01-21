
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/enums/courier_order_status.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/widgets/courier/current_order_bottom_widget.dart';

import '../../ui/shared/MyUtils.dart';

class CurrentOrderViewModel extends BaseModel{

  CourierOrderStatus courierOrderStatus=CourierOrderStatus.GOTOSTORE;

  void updateStatus(CourierOrderStatus status){
    setState(ViewState.Busy);
    courierOrderStatus=status;
    setState(ViewState.Idle);
  }
  final _imagePicker = ImagePicker();
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateReplaceToScreen(String routeName,{Object arguments}) {
    navigationService.navigateReplaceTo(routeName, arguments: arguments);
  }
  File deliveredImage,receiptImage;


  Future<bool> openCamera(CurrentPageImageType currentPageImageType) async {
    try {
      final _image = await _imagePicker.getImage(source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front
      );
      if(currentPageImageType==CurrentPageImageType.DeliveredItem){
        deliveredImage = File(_image.path);
      }else{
        receiptImage=File(_image.path);
      }

      navigatorPop();
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }

  Future<bool> openGallery(CurrentPageImageType currentPageImageType) async {
    try {
      final _image = await _imagePicker.getImage(source: ImageSource.gallery);
      if(currentPageImageType==CurrentPageImageType.Receipt){
        receiptImage=File(_image.path);
      }else{
        deliveredImage=File(_image.path);
      }
      navigatorPop();
      setState(ViewState.Idle);
      return true;

    } catch (e) {
      MyUtils().toastdisplay(AppStrings.INSUFFICIENT_PERMISSION.tr());
      return false;
    }
  }

}