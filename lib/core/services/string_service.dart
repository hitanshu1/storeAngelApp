
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/budgetNameModel.dart';
import 'package:storeangelApp/core/models/payment_option.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:easy_localization/easy_localization.dart';

class StringService {
  static BudgetNameModel  getBudgetName(PurchaseDetails purchaseDetails) {
    int productWithItems = 0;
    for (int i = 0; i < purchaseDetails.products.length; i++) {
      if (purchaseDetails.products[i].price > 0) {
        productWithItems++;
      }
    }

    if (purchaseDetails.paymentOption.paymentOptionEnum == PaymentOptionEnum.prepayment &&
        productWithItems == purchaseDetails.products.length) {

      return BudgetNameModel(
        name: AppStrings.CALCULATED_TOTAL_PRICE.tr(),
        description: AppStrings.ESTIMATION_TOTAL_PRICE_DESCRIPTION_1_TO_3.tr()
      );
    } else if (purchaseDetails.paymentOption.paymentOptionEnum == PaymentOptionEnum.prepayment &&
        productWithItems < purchaseDetails.products.length &&
        purchaseDetails.products.length > 0) {
      return BudgetNameModel(
        name: AppStrings.PENDING_TOTAL_PRICE.tr(),
        description: AppStrings.ESTIMATION_TOTAL_PRICE_DESCRIPTION_4_TO_6.tr()
      );
    } else if (purchaseDetails.paymentOption.paymentOptionEnum == PaymentOptionEnum.prepayment &&
        productWithItems == 0) {
      return BudgetNameModel(
        name: AppStrings.ESTIMATED_TOTAL_PRICE.tr(),
        description: AppStrings.ESTIMATION_TOTAL_PRICE_DESCRIPTION_7_TO_9.tr()
      );
    } else {
      return BudgetNameModel(
        name:  AppStrings.YOUR_BUDGET.tr(),
        description:  AppStrings.MAX_AMOUNT_A_COURIER_CAN_SPEND.tr()

      );

    }
  }
  static String  getEstimationPageTitle(PurchaseDetails purchaseDetails) {
    int productWithItems = 0;
    for (int i = 0; i < purchaseDetails.products.length; i++) {
      if (purchaseDetails.products[i].price > 0) {
        productWithItems++;
      }
    }

    if (productWithItems == purchaseDetails.products.length) {

      return AppStrings.CHECK_THE_PRICES.tr();
    } else if (
        productWithItems < purchaseDetails.products.length &&
        purchaseDetails.products.length > 0) {
      return AppStrings.COMPLETE_THE_PRICES.tr();
    } else if (
        productWithItems == 0) {
      return AppStrings.COMPLETE_THE_PRICE_INFORMATION.tr();
    } else {
      return '';

    }
  }
  static String getCandidate(Locale locale,int offers){

    if(locale.languageCode=='en'){
      return 'You have $offers offers';

    }
    return 'Du hast $offers Angebote';
  }

  static String total(PaymentOption paymentOption){
    if(paymentOption.paymentOptionEnum==PaymentOptionEnum.prepayment){
      return AppStrings.TOTAL_TRANSFER_AMOUNT.tr();
    }else{
      return AppStrings.TOTAL_AMOUNT.tr();
    }

  }
  static BudgetNameModel  getCourierBudgetName(PurchaseDetails purchaseDetails) {
    int productWithItems = 0;
    for (int i = 0; i < purchaseDetails.products.length; i++) {
      if (purchaseDetails.products[i].price > 0) {
        productWithItems++;
      }
    }

    if (purchaseDetails.paymentOption.paymentOptionEnum == PaymentOptionEnum.prepayment &&
        productWithItems == purchaseDetails.products.length) {

      return BudgetNameModel(
          name: AppStrings.PURCHASE_AMOUNT.tr(),
      );
    } else if (purchaseDetails.paymentOption.paymentOptionEnum == PaymentOptionEnum.prepayment &&
        productWithItems < purchaseDetails.products.length &&
        purchaseDetails.products.length > 0) {
      return BudgetNameModel(
          name: AppStrings.CALCULATED_AMOUNT.tr(),

      );
    } else if (purchaseDetails.paymentOption.paymentOptionEnum == PaymentOptionEnum.prepayment &&
        productWithItems == 0) {
      return BudgetNameModel(
          name: AppStrings.PURCHASE_BUDGET.tr(),
      );
    } else {
      return BudgetNameModel(
          name:  AppStrings.PURCHASE_BUDGET.tr(),


      );

    }
  }
  static String getConditionStatus(int step){
    if(step==1){
      return AppStrings.TERMS_OF_ENGAGEMENT.tr();
    }else if(step==2){
      return AppStrings.CHECK_THE_PRICES.tr();
    }else if(step==3){
      return AppStrings.SUMMARY.tr();
    }

    return AppStrings.TERMS_OF_ENGAGEMENT.tr();
  }

  static String orderStatus(OrderPurchaseStatus status){
    if(status==OrderPurchaseStatus.Pending){
      return AppStrings.WAIT_FOR_AN_OFFER.tr();
    }
    return AppStrings.PURCHASING_ACTIVE.tr();
  }

}