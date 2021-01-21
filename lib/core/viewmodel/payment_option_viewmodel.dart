
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentOptionViewModel extends BaseModel{
  List selectedPaymentMethods=[];
  bool paypalValue=false;
  bool googlePayValue=false;
  bool sofortDientsValue=false;
  bool cashValue=false;
  bool creditCard=false;

  void updatePaypalValue(value){
    setState(ViewState.Busy);
    if(value){

      if(selectedPaymentMethods.length<2){
        paypalValue=value;
        selectedPaymentMethods.add(AppStrings.PAYPAL.tr());
      }

    }else{
      paypalValue=value;
      selectedPaymentMethods.remove(AppStrings.PAYPAL.tr());
    }
    setState(ViewState.Idle);
  }
  void updateGooglePayValue(value){
    setState(ViewState.Busy);
    if(value){
      if(selectedPaymentMethods.length<2){
        googlePayValue=value;
        selectedPaymentMethods.add(AppStrings.GOOGLE_PAY.tr());
      }

    }else{
      googlePayValue=value;
      selectedPaymentMethods.remove(AppStrings.GOOGLE_PAY.tr());
    }
    setState(ViewState.Idle);
  }
  void updateSofortDientsValue(value){
    setState(ViewState.Busy);
    if(value){
      if(selectedPaymentMethods.length<2){
        sofortDientsValue=value;
        selectedPaymentMethods.add(AppStrings.SOFORT_DIENTS.tr());
      }

    }else{
      sofortDientsValue=value;
      selectedPaymentMethods.remove(AppStrings.SOFORT_DIENTS.tr());
    }
    setState(ViewState.Idle);
  }
  void updateCashValue(value){
    setState(ViewState.Busy);
    if(value){
      if(selectedPaymentMethods.length<2){
        cashValue=value;
        selectedPaymentMethods.add(AppStrings.CASH.tr());
      }

    }else{
      cashValue=value;
      selectedPaymentMethods.remove(AppStrings.CASH.tr());
    }
    setState(ViewState.Idle);
  }
  void updateCreditCardValue(value){
    setState(ViewState.Busy);
    if(value){
      if(selectedPaymentMethods.length<2){
        creditCard=value;
        selectedPaymentMethods.add(AppStrings.CREDIT_CARDS.tr());
      }

    }else{
      creditCard=value;
      selectedPaymentMethods.remove(AppStrings.CREDIT_CARDS.tr());
    }
    setState(ViewState.Idle);
  }

}