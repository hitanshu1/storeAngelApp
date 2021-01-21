import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/models/payment_option.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:easy_localization/easy_localization.dart';

class EstimationViewModel extends BaseModel {
  TextEditingController totalSumTextEditingController = TextEditingController();
  PurchaseDetails purchaseDetails;

  void navigatorPop() {
    navigationService.pop();
  }

  void navigateToScreen(String routeName, BuildContext context, {Object arguments}) {
    navigationService.pushNamedAndRemoveUntil(routeName, arguments: purchaseDetails).then((value) {
      StatusBarService.changeStatusBarColor(StatusBarType.Light, context);
    });
  }

  void init(PurchaseDetails details) {
    purchaseDetails = details;
    getBudgetName();
  }

  //User can set an total amount and this function will calculate with this setting the single amount for one item
  //and will update the UI with the according data
  void changeTotalAndSingleAmount(String value, int productIndex) {
    final product = purchaseDetails.products[productIndex];
    double priceForAllUnits = double.parse(value.replaceAll(',', '.'));
    double priceForOneUnit = priceForAllUnits / product.quantity;
    purchaseDetails.products[productIndex].price = priceForOneUnit;

    setState(ViewState.Idle);
  }

  void setTotalSumValue(String val, BuildContext context) {
    double valAmount = double.parse(val.replaceAll(',', '.'));
    double calculatedTotalAmount = calcTotalAmount;

    if (calculatedTotalAmount <= valAmount) {
      totalSumTextEditingController.text = NumberService.addAfterCommaTwoZeros(valAmount.toString(), context);
      return null;
    }
    totalSumTextEditingController.text = NumberService.addAfterCommaTwoZeros(calculatedTotalAmount.toString(), context);
  }

  double get calcTotalAmount {
    double calculatedTotalAmount = 0;
    final productList = purchaseDetails.products;
    for (int i = 0; i < productList.length; i++) {
      calculatedTotalAmount += (productList[i].price ?? 1) * (productList[i].quantity ?? 1);
    }

    return calculatedTotalAmount;
  }

  String budgetName = '';
  String budgetDescription = '';

  void getBudgetName() {
    int productWithItems = 0;
    for (int i = 0; i < purchaseDetails.products.length; i++) {
      if (purchaseDetails.products[i].price > 0) {
        productWithItems++;
      }
    }


    if (purchaseDetails.paymentOption.paymentOptionEnum == PaymentOptionEnum.prepayment &&
        productWithItems == purchaseDetails.products.length) {
      budgetName = AppStrings.CALCULATED_TOTAL_PRICE.tr();
      budgetDescription = AppStrings.ESTIMATION_TOTAL_PRICE_DESCRIPTION_1_TO_3.tr();
    } else if (purchaseDetails.paymentOption.paymentOptionEnum == PaymentOptionEnum.prepayment &&
        productWithItems < purchaseDetails.products.length &&
        purchaseDetails.products.length > 0) {
      budgetName = AppStrings.PENDING_TOTAL_PRICE.tr();
      budgetDescription = AppStrings.ESTIMATION_TOTAL_PRICE_DESCRIPTION_4_TO_6.tr();
    } else if (purchaseDetails.paymentOption.paymentOptionEnum == PaymentOptionEnum.prepayment &&
        productWithItems == 0) {
      budgetName = AppStrings.ESTIMATED_TOTAL_PRICE.tr();
      budgetDescription = AppStrings.ESTIMATION_TOTAL_PRICE_DESCRIPTION_7_TO_9.tr();
    } else {
      budgetName = AppStrings.YOUR_BUDGET.tr();
      budgetDescription = AppStrings.MAX_AMOUNT_A_COURIER_CAN_SPEND.tr();
    }
  }
}
