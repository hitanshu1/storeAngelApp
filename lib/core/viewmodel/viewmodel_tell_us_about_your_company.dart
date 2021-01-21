
import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/ui/screens/consumer/allow_Location_Screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class TellUsAboutYourCompanyViewModel extends BaseModel{
  bool hasShadow = false;
  ScrollController scrollController;

  void navigateTo(String routeName) {
    navigationService.navigateTo(routeName);
  }

  TextEditingController companyNameController=TextEditingController();
  TextEditingController companyEmailController=TextEditingController();
  TextEditingController taxIdentificationController=TextEditingController();
  TextEditingController countryController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController streetController=TextEditingController();

  void disposeController(){
    companyEmailController.dispose();
    companyEmailController.dispose();
    taxIdentificationController.dispose();
    countryController.dispose();
    cityController.dispose();
    streetController.dispose();
  }


  void onPressNext(){
    navigateTo(AllowLocationScreen.routeName);
  }

  void initialize(ScrollController scrollController){
    Future.delayed(Duration.zero,(){
      this.scrollController = scrollController;
      this.scrollController.addListener(addScrollListener);
    });
  }

  void addScrollListener(){
    if(scrollController.position.pixels==0){
      hasShadow = false;
    }else{
      hasShadow = true;
    }
    setState(ViewState.Idle);
  }
}