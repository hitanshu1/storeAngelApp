import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/regexService.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/payment_option_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/shared/smalltextfield.dart';
import 'package:storeangelApp/ui/widgets/courier/payment_option_widget.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';

class PaymentOption extends StatefulWidget {
  @override
  _PaymentOptionState createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _feeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _feeController.text = AppStrings.euroSymbol+NumberService.addAfterCommaTwoZeros('10', context);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _feeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    final profileModel = Provider.of<ProfileViewModel>(context);
    return BaseView<PaymentOptionViewModel>(builder: (context, paymentOptionViewModel, child) {
      return Scaffold(
        appBar: CustomAppBar(
          elevation: 0,
          leading: BackButton(
            color: Theme.of(context).iconTheme.color,
            onPressed: () {
              profileModel.changeView(ProfilePageView.home);
            },
          ),
          title: Text(
            AppStrings.PAYMENT_OPTIONS.tr(),
            style: AppStyles.BlackStyleWithBold800Font_24(context),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: SizeConfig.padding,
          child: ListView(
            controller: _scrollController,
            children: [
              SizeConfig.verticalSpaceSmall(),
              Padding(
                padding: SizeConfig.sidepadding,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      AppStrings.DEFAULT_RATE.tr(),
                      style: AppStyles.BlackStyleWithBold800Font_20(context),
                    )),
                    Form(
                      key: _formKey,
                      child: Container(
                        width: SizeConfig.screenWidth * .4,
                        alignment: Alignment.center,
                        height: SizeConfig.adaptiveHeight(SizeConfig.screenHeight * .05),
                        child: SmallTextField(
                          hasBorderSideColor: false,
                          controller: _feeController,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          textInputAction: TextInputAction.done,
                          enableSuffixIfTextIsNotEmpty: true,
                          style: AppStyles.BlackStyleFont_20(context),
                          onSubmit: (val) {
                            String _val=val.replaceAll(AppStrings.euroSymbol, '');
                            try {

                              if (double.parse(_val) <= 0) {
                                _feeController.text = AppStrings.euroSymbol+NumberService.addAfterCommaTwoZeros(_val, context);
                              }
                            } catch (e) {
                              print(e);
                              _feeController.text = AppStrings.euroSymbol+NumberService.addAfterCommaTwoZeros(_val, context);
                            }
                          },
                          validator: (value) {
                            String _val=value.replaceAll(AppStrings.euroSymbol, '');
                            final n = num.tryParse(_val);
                            if (n < 1) {
                              return 'Invalid charge';
                            }
                            return null;
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegexService.doubleRegexWithCommaOrDotAndTwoDigit)
                          ],
                          textInputType: TextInputType.numberWithOptions(signed: true, decimal: true),
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(SizeConfig.borderRadius)),
                      ),
                    ),
                  ],
                ),
              ),
              SizeConfig.verticalSpaceMedium(),
              Center(
                child: SizedBox(
                    width: SizeConfig.screenWidth * .8,
                    child: Text(
                      AppStrings.THE_MORE_METHODS_YOU.tr(),
                      style: AppStyles.GrayStyle_FontMedium(context).copyWith(height: 1.25),
                      textAlign: TextAlign.center,
                    )),
              ),
              SizeConfig.verticalSpaceSmall(),
              Padding(
                padding: SizeConfig.sidepadding,
                child: PaymentOptionWithTextWidget(
                  controller: TextEditingController(),
                  onChanged: (value) {
                    paymentOptionViewModel.updatePaypalValue(value);
                  },
                  value: paymentOptionViewModel.paypalValue,
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
                    paymentOptionViewModel.updateGooglePayValue(value);
                  },
                  value: paymentOptionViewModel.googlePayValue,
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
                    paymentOptionViewModel.updateSofortDientsValue(value);
                  },
                  value: paymentOptionViewModel.sofortDientsValue,
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
                    paymentOptionViewModel.updateCreditCardValue(value);
                  },
                  value: paymentOptionViewModel.creditCard,
                  title: AppStrings.CREDIT_CARDS.tr(),
                ),
              ),
              SizeConfig.CVerticalSpacevEMedium(),
              Padding(
                padding: SizeConfig.sidepadding,
                child: PaymentOptionWithTextWidget(
                  controller: TextEditingController(),
                  onChanged: (value) {
                    paymentOptionViewModel.updateCashValue(value);
                  },
                  value: paymentOptionViewModel.cashValue,
                  title: AppStrings.CASH.tr(),
                ),
              ),
              SizeConfig.verticalSpace(SizeConfig.screenHeight * .15),
            ],
          ),
        ),
        floatingActionButtonAnimator: NoScalingAnimation(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Visibility(
          visible: paymentOptionViewModel.selectedPaymentMethods.length > 0 ? true : false,
          child: Padding(
            padding: SizeConfig.sidepadding.copyWith(bottom: SizeConfig.screenHeight * .005),
            child: ButtonWidget(
              onPressed: () {
               MyUtils().toastdisplay('The service is not yet available');
              },
              radius: AppConstants.button_Radius,
              fontSize: AppConstants.fontSizeSmall,
              buttonText: AppStrings.DONE.tr(),
              buttonColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
      );
    });
  }
}
