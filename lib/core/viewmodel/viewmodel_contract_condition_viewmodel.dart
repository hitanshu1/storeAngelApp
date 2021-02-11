
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/models/address.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:easy_localization/easy_localization.dart';

class ContractConditionViewModel extends BaseModel{

  PurchaseDetails purchaseDetails;
  String selectDateAndTime;
  int deliveryTimeSelectValue;
  DateTime startDate;
  DateTime endDate;
  String selectPayment=AppStrings.PREPAYMENT.tr();
  String selectedDeliveryPeriod=AppStrings.AS_SOON_AS_POSSIBLE.tr();
  List<String>timeOfPayments=[
    AppStrings.PREPAYMENT.tr(),
    AppStrings.PAYMENT_ON_DELIVERY.tr(),
    AppStrings.WITH_BUDGET_RESTRICTION.tr()
  ];
  List<String>deliveryPeriods=[
    AppStrings.AS_SOON_AS_POSSIBLE.tr(),
    AppStrings.TOMORROW_DELIVERY.tr(),
    AppStrings.CHOOSE_PERIOD.tr()
  ];
  void navigatorPop() {
    navigationService.pop();
  }

  void navigateToScreen(String routeName, {Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }

  void initializeData(PurchaseDetails val){
    setState(ViewState.Busy);
    purchaseDetails=val;
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

  bool  paymentValue(String val)=>selectPayment==val;


  int step=1;


  bool value=false;
  bool furtherValue=false;


  bool  addressValue(String id){
    return id==selectedAddress.id;

  }

  List<AddressModel>userAddress=[
    AddressModel(
      id:'1',

      name: 'Petra-Maria Kraupp',
        street: 'Dunnheimerstr. 3a',
        city: 'Düsseldorf',
        zipCode: '84375',

    ),
    AddressModel(
      id: '2',
      name: 'Petra-Maria Kraupp',
      street: 'Dunnheimerstr. 3a',
      city: 'Düsseldorf',
      zipCode: '84375',

    )
  ];
  AddressModel selectedAddress=AddressModel(
    id:'1',

    name: 'Petra-Maria Kraupp',
    street: 'Dunnheimerstr. 3a',
    city: 'Düsseldorf',
    zipCode: '84375',

  );

  void onSelectAddress(AddressModel address){
    setState(ViewState.Busy);
    value=true;
    selectedAddress=address;
    furtherValue=false;
    setState(ViewState.Idle);

  }
  void onSelectPayment(String val){
    setState(ViewState.Busy);
    selectPayment=val;
    setState(ViewState.Idle);

  }
  void onSelectDeliveryPeriod(String val){
    setState(ViewState.Busy);
    selectedDeliveryPeriod=val;
    setState(ViewState.Idle);

  }

  void onSelectFurther(){
    setState(ViewState.Busy);
    selectedAddress=AddressModel();
    furtherValue=true;
    setState(ViewState.Idle);
  }



  void onChangeStep(int val){
    setState(ViewState.Busy);
    step=val;
    setState(ViewState.Idle);
  }

}