import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/payment_mode.dart';
import 'package:storeangelApp/core/viewmodel/view_model_checkout.dart';

class PaymentOptionWidget extends StatelessWidget {
  final CheckOutViewModel model;
  PaymentOptionWidget({this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              child: Container(
                height: 50,
                child: Center(child: Text(AppStrings.PAYPAL.tr(),
                  style: model.selectedPaymentMode==PaymentMode.PayPal?AppStyles.WhiteStyleWithBold600_Font16:
                  AppStyles.BlackStyleWithBold600Font_16,)),
                decoration: BoxDecoration(
                    color: model.selectedPaymentMode==PaymentMode.PayPal?AppColors.green:AppColors.lightGreyColor.withOpacity(.2),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        topLeft: Radius.circular(12)
                    ),
                    border: Border.all(color: AppColors.lightGrayLittleColor)

                ),
              ),
              onTap: (){
                model.updatePaymentMode(PaymentMode.PayPal);
              },
            ),
          ),
          Expanded(
            child: InkWell(
              child: Container(
                height: 50,
                child: Center(child: Text(AppStrings.AMAZONPAY.tr(),
                  style:model.selectedPaymentMode==PaymentMode.AmazonPay?AppStyles.WhiteStyleWithBold600_Font16: AppStyles.BlackStyleWithBold600Font_16,)),
                decoration: BoxDecoration(
                    color: model.selectedPaymentMode==PaymentMode.AmazonPay?AppColors.green:AppColors.lightGreyColor.withOpacity(.2),
                    border: Border.all(color: AppColors.lightGrayLittleColor)

                ),
              ),
              onTap: (){
                model.updatePaymentMode(PaymentMode.AmazonPay);
              },
            ),
          ),

          Expanded(
            child: InkWell(
              child: Container(
                height: 50,
                child: Center(child: Text(AppStrings.SOFORT_DIENTS.tr(),
                  style: model.selectedPaymentMode==PaymentMode.SofortDients?AppStyles.WhiteStyleWithBold600_Font16:AppStyles.BlackStyleWithBold600Font_16,)),
                decoration: BoxDecoration(
                    color: model.selectedPaymentMode==PaymentMode.SofortDients?AppColors.green:AppColors.lightGreyColor.withOpacity(.2),
                    border: Border.all(color: AppColors.lightGrayLittleColor)

                ),
              ),
              onTap: (){
                model.updatePaymentMode(PaymentMode.SofortDients);
              },
            ),
          ),

          Expanded(
            child: InkWell(
              child: Container(
                height: 50,
                child: Center(child: Text(AppStrings.CASH.tr(),textAlign: TextAlign.center,
                    style: model.selectedPaymentMode==PaymentMode.Cash?AppStyles.WhiteStyleWithBold600_Font16:AppStyles.BlackStyleWithBold600Font_16)),
                decoration: BoxDecoration(
                    color: model.selectedPaymentMode==PaymentMode.Cash?AppColors.green:AppColors.lightGreyColor.withOpacity(.2),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),

                    ),
                    border: Border.all(color: AppColors.lightGrayLittleColor)
                ),
              ),
              onTap: (){
                model.updatePaymentMode(PaymentMode.Cash);
              },
            ),
          ),

        ],
      ),
    );
  }
}
