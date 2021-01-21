

import 'package:storeangelApp/ui/shared/base_model.dart';

import '../models/app_image.dart';

class PhotoProvider extends BaseModel{
  List<AppImage>selectImages=[];
  List<String>selectedImagePaths=[];

  void uploadImages(AppImage appImage){
    setState(ViewState.Busy);
    selectImages.add(appImage);
    selectedImagePaths.add(appImage.fileImage.path);
    setState(ViewState.Idle);
  }
  void removePickerImage(AppImage appImage){
    setState(ViewState.Busy);
    selectImages.removeWhere((item) => item.fileImage.path ==appImage.fileImage.path);
    selectedImagePaths.removeWhere((item) => item ==appImage.fileImage.path);
    setState(ViewState.Idle);
  }
  void clear(){
    setState(ViewState.Busy);
    selectImages=[];
    selectedImagePaths=[];
    setState(ViewState.Idle);
  }

}