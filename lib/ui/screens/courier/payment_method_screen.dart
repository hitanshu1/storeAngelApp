import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_payment_methode_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:storeangelApp/ui/shared/CustomFloatingActionButtonExtended.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/widgets/courier/payment_option_widget.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';

class PaymentMethodScreen extends StatefulWidget {
  static const String routeName = 'paymentMethodScreen';

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PaymentMethodScreenViewModel>(
      onModelReady: (paymentMethodViewModel) => paymentMethodViewModel.initialize(_scrollController),
      builder: (context, paymentMehodViewModel, child) {
        if (paymentMehodViewModel.state == ViewState.Busy) {
          return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: AppConstants.circulerProgressIndicator());
        } else {
          return Scaffold(
            appBar: CustomAppBar(
              elevation: paymentMehodViewModel.hasShadow ? 4 : 0,
              backgroundColor: Theme.of(context).backgroundColor,
              automaticallyImplyLeading: true,
              leading: BackButton(
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                width: SizeConfig.screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        width: SizeConfig.screenWidth * .7,
                        child: Text(
                          AppStrings.ACTIVE_THE_PAYMENT_SERVICES_THAT_YOUR_CLIENTS.tr(),
                          style: AppStyles.BlackStyleWithBold_FontC20(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizeConfig.CVerticalSpacevEMedium(),
                    Center(
                      child: SizedBox(
                          width: SizeConfig.screenWidth * .6,
                          child: Text(
                            AppStrings.THE_MORE_METHODS_YOU.tr(),
                            style: AppStyles.GrayStyle_FontMedium(context).copyWith(height: 1.6),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    SizeConfig.CVerticalSpaceBigger(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: PaymentOptionWithTextWidget(
                        controller: TextEditingController(),
                        onChanged: (value) {
                          paymentMehodViewModel.updatePaypalValue(value);
                        },
                        value: paymentMehodViewModel.paypalValue,
                        title: AppStrings.PAYPAL.tr(),
                        textTitle: AppStrings.WHAT_IS_YOUR_PAYPAL_EMAIL_ACCOUNT.tr(),
                      ),
                    ),
                    SizeConfig.CVerticalSpaceMedium(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: PaymentOptionWithTextWidget(
                        controller: TextEditingController(),
                        onChanged: (value) {
                          paymentMehodViewModel.updateGooglePayValue(value);
                        },
                        value: paymentMehodViewModel.googlePayValue,
                        title: AppStrings.GOOGLE_PAY.tr(),
                        textTitle: AppStrings.WHAT_IS_YOUR_GOOGLEPAY_ID.tr(),
                      ),
                    ),
                    SizeConfig.CVerticalSpaceMedium(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: PaymentOptionWithTextWidget(
                        controller: TextEditingController(),
                        onChanged: (value) {
                          paymentMehodViewModel.updateSofortDientsValue(value);
                        },
                        value: paymentMehodViewModel.sofortDientsValue,
                        title: AppStrings.KLARNA.tr(),
                        textTitle: AppStrings.WHAT_IS_YOUR_SOFORNT_DIENTS_ID.tr(),
                      ),
                    ),
                    SizeConfig.CVerticalSpacevEMedium(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: PaymentOptionWithTextWidget(
                        controller: TextEditingController(),
                        onChanged: (value) {
                          paymentMehodViewModel.updateCreditCardValue(value);
                        },
                        value: paymentMehodViewModel.creditCard,
                        title: AppStrings.CREDIT_CARDS.tr(),
                      ),
                    ),
                    SizeConfig.CVerticalSpacevEMedium(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: PaymentOptionWithTextWidget(
                        controller: TextEditingController(),
                        onChanged: (value) {
                          paymentMehodViewModel.updateCashValue(value);
                        },
                        value: paymentMehodViewModel.cashValue,
                        title: AppStrings.CASH.tr(),
                      ),
                    ),
                    SizeConfig.verticalSpace(SizeConfig.screenHeight*.15),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButtonAnimator: NoScalingAnimation(),
            floatingActionButton: CustomFloatingActionButtonExtended(
              label: Visibility(
                visible: paymentMehodViewModel.selectedPaymentMethods.length > 0 ? true : false,
                child: Container(
                  width: SizeConfig.screenWidth * .8,
                  margin: EdgeInsets.only(bottom: SizeConfig.screenHeight*.05),
                  child: ButtonWidget(
                      radius: AppConstants.button_Radius,
                      fontSize: AppConstants.fontSizeSmall,
                      buttonColor: AppColors.green,
                      buttonText: AppStrings.DONE.tr(),
                      onPressed: () {
                        paymentMehodViewModel.navigateToScreen(LandingScreen.routeName);
                      }),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
