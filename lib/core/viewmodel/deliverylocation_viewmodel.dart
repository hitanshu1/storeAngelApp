import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/models/address.dart';
import 'package:storeangelApp/core/models/payment_option.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/screens/order_courier_flow/estimation_screen.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class DeliveryLocationViewModel extends BaseModel {
  FirebaseAbstraction _myFirebaseServices = getIt<FirebaseAbstraction>();
  DateTime startDate;
  DateTime endDate;

  void navigatorPop() {
    navigationService.pop();
  }

  void navigateToScreen(String routeName, {Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }

  List<PaymentOption> paymentOptions = [
    PaymentOption(title: AppStrings.PREPAYMENT.tr(), paymentOptionEnum: PaymentOptionEnum.prepayment),
    PaymentOption(title: AppStrings.PAYMENT_ON_DELIVERY.tr(), paymentOptionEnum: PaymentOptionEnum.payment_on_delivery),
    PaymentOption(
        title: AppStrings.WITH_BUDGET_RESTRICTION.tr(), paymentOptionEnum: PaymentOptionEnum.withBudgetConstraint),
  ];
  PaymentOption selectedOption =
      PaymentOption(title: AppStrings.NO_PREFERENCES.tr(), paymentOptionEnum: PaymentOptionEnum.prepayment);

  List<AddressModel> addresses = [];
  AddressModel selectedAddress;
  bool leaveAtDestination = true;
  int deliveryTimeSelectValue = 1;
  String selectDateAndTime;
  PurchaseDetails purchaseDetails;

  void getAddress(UserModel user, purchaseValue) async {
    setState(ViewState.Busy);
    addresses = await _myFirebaseServices.getUserAddresses('userid');
    selectedAddress = addresses.first;
    purchaseDetails = purchaseValue;
    purchaseDetails.paymentOption = selectedOption;
    setState(ViewState.Idle);
  }

  void addAddress(AddressModel addressVal) async {
    setState(ViewState.Busy);
    try {
      var address = await Geocoder.local.findAddressesFromQuery(addressVal.name);
      addressVal.zipCode = address.first.postalCode;
      addressVal.street = addresses.first.street;
      addressVal.city = addresses.first.city;
      addressVal.country = addresses.first.country;
      addresses.add(addressVal);
    } catch (e) {
      print(e);
      MyUtils().toastdisplay(AppStrings.LOCATION_NOT_AVAILABLE.tr());
    }
    setState(ViewState.Idle);
  }

  void onSelectAddress(AddressModel addressModel) {
    setState(ViewState.Busy);
    if (selectedAddress != addressModel)
      selectedAddress = addressModel;
    else
      selectedAddress = null;
    setState(ViewState.Idle);
  }

  void updateDestinationType() {
    setState(ViewState.Busy);
    leaveAtDestination = !leaveAtDestination;
    setState(ViewState.Idle);
  }

  void onSelectDeliveryTimeOption(int value) {
    setState(ViewState.Busy);
    if (deliveryTimeSelectValue != value) {
      deliveryTimeSelectValue = value;
    } else {
      if (deliveryTimeSelectValue != 3) {
        deliveryTimeSelectValue = 0;
      }
    }
    if (value != 3) {
      selectDateAndTime = null;
    }
    setState(ViewState.Idle);
  }

  void onSelectStartDate(DateTime dateTime) {
    setState(ViewState.Busy);
    startDate = dateTime;
    setState(ViewState.Idle);
  }

  void onSelectEndDate(DateTime dateTime) {
    setState(ViewState.Busy);
    endDate = dateTime;
    selectDateAndTime =
        '${startDate.day}. ${AppConstants.getMonth(startDate.month)} ${startDate.hour < 10 ? '0${startDate.hour}' : startDate.hour}:${startDate.minute < 10 ? '0${startDate.minute}' : startDate.minute} - ${endDate.hour < 10 ? '0${endDate.hour}' : endDate.hour}:${endDate.minute < 10 ? '0${endDate.minute}' : endDate.minute}';
    setState(ViewState.Idle);
  }

  void changePaymentRestriction() {
    if (purchaseDetails.paymentOption.paymentRestriction != PaymentRestriction.yes) {
      purchaseDetails.paymentOption.paymentRestriction = PaymentRestriction.yes;
    } else {
      purchaseDetails.paymentOption.paymentRestriction = PaymentRestriction.no;
    }
    setState(ViewState.Idle);
  }

  void onSelectPayOption(PaymentOption value) {
    setState(ViewState.Busy);
    selectedOption = value;
    purchaseDetails.paymentOption = value;
    if (value.paymentOptionEnum == PaymentOptionEnum.prepayment) {
      purchaseDetails.paymentOption.paymentRestriction = PaymentRestriction.no;
    }
    setState(ViewState.Idle);
  }

  void init(FocusNode commentNode) {
    commentNode.addListener(() {
      setState(ViewState.Idle);
    });
  }

  void onPublishOrder(key) {
    if (deliveryTimeSelectValue != 0) {
      navigateToScreen(EstimationScreen.routeName, arguments: purchaseDetails);
    } else {
//      MyUtils().toastdisplay(AppStrings.PLEASE_SELECT_A_DELIVERY_DATE.tr());
      key.currentState.showSnackBar(new SnackBar(content: Text(AppStrings.PLEASE_SELECT_A_DELIVERY_DATE.tr())));
    }
  }
}
