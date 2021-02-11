import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_order_delivery.dart';
import 'package:storeangelApp/ui/screens/receipt_view_screen.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/circuler_button_widget.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/widgets/orderDelivered/order_delivered_info_row.dart';
import 'package:storeangelApp/ui/widgets/orderDelivered/rating_dialog_widget.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';
import 'package:storeangelApp/ui/widgets/watchlist/dashline_widget.dart';

import 'consumer/landing_Screen.dart';

class OrderDeliveredScreen extends StatefulWidget {
  final OrderDeliveredScreenArgument argument;

  OrderDeliveredScreen({this.argument});

  static const String routeName = 'orderDeliveryScreen';

  @override
  _OrderDeliveredScreenState createState() => _OrderDeliveredScreenState();
}

class _OrderDeliveredScreenState extends State<OrderDeliveredScreen> {
  String _fontFamily = 'PTMono';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => StatusBarService.changeStatusBarColor(StatusBarType.Light, context));
  }

  @override
  Widget build(BuildContext context) {
//    StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    return BaseView<OrderDeliveryViewModel>(
      onModelReady: (model) => model.getPurchaseDetails(widget.argument.orderOrPurchases),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            if (model.showReceipt) {
              model.onChangeReceiptVisibility(false, context);
              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            appBar: CustomAppBar(
              leading: BackButton(
                color: Theme.of(context).iconTheme.color,
                onPressed: () {
                  if (model.showReceipt) {
                    model.onChangeReceiptVisibility(false, context);
                  } else {
                    model.navigatorPop();
                  }
                },
              ),
              backgroundColor: model.showReceipt ? Theme.of(context).disabledColor : Theme.of(context).cardColor,
              title: Text(
                widget.argument.orderOrPurchases.purchaseDetails.listName,
                style: AppStyles.BlackStyleWithBold800Font_20(context),
              ),
              actions: [
                IconButton(
                        icon: Icon(
                          StoreangelIcons.share_with_three_dots_icon,
                          color: Theme.of(context).focusColor,
                        ),
                        onPressed: () => null,
                      )
              ],
            ),
            body: model.state == ViewState.Busy
                ? AppConstants.circulerProgressIndicator()
                : Stack(
                    children: [
                      Container(
                        height: SizeConfig.screenHeight,
                        width: SizeConfig.screenWidth,
                        padding: SizeConfig.sidepadding,
                        color: Theme.of(context).cardColor,
                        child: CustomScrollView(
                          shrinkWrap: true,
                          slivers: [
                            SliverToBoxAdapter(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizeConfig.verticalSpaceSmall(),
                                  OrderDeliveredInfoRowWidget(
                                      firstText: AppStrings.COURIER.tr(),
                                      secondText: model.purchaseDetails.customer.name),
                                  OrderDeliveredInfoRowWidget(
                                      firstText: AppStrings.TAX_ID.tr(), secondText: '234002342343'),
                                  OrderDeliveredInfoRowWidget(
                                      firstText: AppStrings.ADDRESS.tr(),
                                      secondText: model.purchaseDetails.customer.city),
                                  SizeConfig.CVerticalSpacevEMedium(),
                                  Center(
                                      child: Text(
                                    model.purchaseDetails.storeDetails.name,
                                    style: AppStyles.BlackStyleWithBold700_Font40(context),
                                  )),
                                  SizeConfig.CVerticalSpaceMedium(),
                                  Center(
                                    child: Text(
                                      '${model.purchaseDetails.storeDetails.street}',
                                      style: AppStyles.BlackStyleFont_20(context).copyWith(fontFamily: _fontFamily),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      model.purchaseDetails.storeDetails.zipCity,
                                      style: AppStyles.BlackStyleFont_20(context).copyWith(fontFamily: _fontFamily),
                                    ),
                                  ),
                                  SizeConfig.CVerticalSpacevEMedium(),
                                  Center(
                                      child: Text(
                                    AppStrings.RECEIPT_COPY.tr(),
                                    style:
                                        AppStyles.BlackStyleWithBold_Font36(context).copyWith(fontFamily: _fontFamily),
                                  )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [Text(AppStrings.EURO.tr())],
                                  ),
                                  SizeConfig.verticalSpaceSmall(),
                                ],
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate((context, index) {
                                return orderPriceAndQuantityWidget(
                                    firstText: model.purchaseDetails.products[index].name,
                                    secondText:
                                        '${NumberService.priceAfterConvert(model.purchaseDetails.products[index].quantity * model.purchaseDetails.products[index].price,context)} A',
                                    thirdText:
                                        '${model.purchaseDetails.products[index].quantity} x ${NumberService.priceAfterConvert(model.purchaseDetails.products[index].price,context)}');
                              }, childCount: model.purchaseDetails.products.length),
                            ),
                            SliverToBoxAdapter(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizeConfig.verticalSpaceMedium(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      DotWidget(
                                        dashColor: AppColors.darkGrayColor,
                                        dashHeight: 1,
                                        dashWidth: AppConstants.dash_width,
                                        emptyWidth: AppConstants.empty_width,
                                        totalWidth: SizeConfig.screenWidth * .3,
                                      ),
                                    ],
                                  ),
                                  SizeConfig.verticalSpaceSmall(),
                                  OrderDeliveredInfoRowWidget(
                                    firstText: AppStrings.PURCHASE_TOTAL.tr(),
                                    secondText: '40,97',
                                    firstTextStyle:
                                        AppStyles.BlackStyleWithBold_Font36(context).copyWith(fontFamily: _fontFamily),
                                    secondTextStyle:
                                        AppStyles.BlackStyleWithBold_Font36(context).copyWith(fontFamily: _fontFamily),
                                  ),
                                  SizeConfig.verticalSpaceSmall(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      DotWidget(
                                        dashColor: AppColors.darkGrayColor,
                                        dashHeight: 1,
                                        dashWidth: AppConstants.dash_width,
                                        emptyWidth: AppConstants.empty_width,
                                        totalWidth: SizeConfig.screenWidth * .3,
                                      ),
                                    ],
                                  ),
                                  SizeConfig.verticalSpaceSmall(),
                                  Text('${model.purchaseDetails.quantity} ' + AppStrings.ARTICLES.tr()),
                                  SizeConfig.verticalSpaceMedium(),
                                  OrderDeliveredInfoRowWidget(
                                    firstText: AppStrings.BUDGET.tr(),
                                    secondText: '70,00',
                                  ),
                                  SizeConfig.verticalSpaceVerySmall(),
                                  OrderDeliveredInfoRowWidget(
                                    firstText: AppStrings.CREDIT_CARD.tr(),
                                    secondText: '40,97',
                                  ),
                                  SizeConfig.verticalSpaceVerySmall(),
                                  OrderDeliveredInfoRowWidget(
                                    firstText: AppStrings.FEE.tr(),
                                    secondText: '9,99',
                                  ),
                                  SizeConfig.verticalSpaceSmall(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      DotWidget(
                                        dashColor: AppColors.darkGrayColor,
                                        dashHeight: 1,
                                        dashWidth: AppConstants.dash_width,
                                        emptyWidth: AppConstants.empty_width,
                                        totalWidth: SizeConfig.screenWidth * .3,
                                      ),
                                    ],
                                  ),
                                  SizeConfig.verticalSpaceSmall(),
                                  widget.argument.isPrePaid
                                      ? OrderDeliveredInfoRowWidget(
                                          firstText: AppStrings.PAY_BACK_AMOUNT.tr(),
                                          secondText: '19,96',
                                          firstTextStyle: AppStyles.BlackStyleWithBold_Font36(context)
                                              .copyWith(fontFamily: _fontFamily),
                                          secondTextStyle: AppStyles.BlackStyleWithBold_Font36(context)
                                              .copyWith(fontFamily: _fontFamily),
                                        )
                                      : OrderDeliveredInfoRowWidget(
                                          firstText: AppStrings.TOTAL_PAYMENT.tr(),
                                          secondText: '50,96',
                                          firstTextStyle: AppStyles.BlackStyleWithBold_Font36(context)
                                              .copyWith(fontFamily: _fontFamily),
                                          secondTextStyle: AppStyles.BlackStyleWithBold_Font36(context)
                                              .copyWith(fontFamily: _fontFamily),
                                        ),
                                  SizeConfig.verticalSpaceSmall(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      DotWidget(
                                        dashColor: AppColors.darkGrayColor,
                                        dashHeight: 1,
                                        dashWidth: AppConstants.dash_width,
                                        emptyWidth: AppConstants.empty_width,
                                        totalWidth: SizeConfig.screenWidth * .3,
                                      ),
                                    ],
                                  ),
                                  SizeConfig.verticalSpaceVerySmall(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      DotWidget(
                                        dashColor: AppColors.darkGrayColor,
                                        dashHeight: 1,
                                        dashWidth: AppConstants.dash_width,
                                        emptyWidth: AppConstants.empty_width,
                                        totalWidth: SizeConfig.screenWidth * .3,
                                      ),
                                    ],
                                  ),
                                  SizeConfig.verticalSpaceMedium(),
                                  OrderDeliveredInfoRowWidget(
                                    firstText: AppStrings.DELIVERY_DATE.tr(),
                                    secondText: DateService.getDateWithHourFormat(DateTime.now().toIso8601String(),context),
                                  ),
                                  OrderDeliveredInfoRowWidget(
                                    firstText: AppStrings.DELIVERY_CITY.tr(),
                                    secondText: model.purchaseDetails.customer.city,
                                  ),
                                  OrderDeliveredInfoRowWidget(
                                    firstText: AppStrings.DELIVERY_STREET.tr(),
                                    secondText: model.purchaseDetails.customer.street,
                                  ),
                                  OrderDeliveredInfoRowWidget(
                                    firstText: AppStrings.POSTED.tr(),
                                    secondText: DateService.getDateWithHourFormat(DateTime.now().toIso8601String(),context),
                                  ),
                                  OrderDeliveredInfoRowWidget(
                                    firstText: AppStrings.ORDER_ID.tr(),
                                    secondText: '542342123',
                                  ),
                                  SizeConfig.verticalSpaceMedium(),
                                  SizedBox(
                                    width: SizeConfig.screenWidth,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppStrings.THANK_YOU.tr(),
                                          style: AppStyles.BlackStyleFont_16(context),
                                        ),
                                        Text(AppStrings.FOR_YOUR_PURCHASE.tr(),
                                            style: AppStyles.BlackStyleFont_16(context)),
                                        Text(AppStrings.WITH_STOREANGEL.tr(),
                                            style: AppStyles.BlackStyleFont_16(context))
                                      ],
                                    ),
                                  ),
                                  SizeConfig.verticalSpace(SizeConfig.screenHeight * .15),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
            floatingActionButtonAnimator: NoScalingAnimation(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: !model.showReceipt
                ? Padding(
              padding: SizeConfig.sidepadding.copyWith(bottom: SizeConfig.screenHeight * .005),
              child: SizedBox(
                height: 70,
                child: Row(
                  children: [
                    model.order.receipts != null
                        ? Expanded(
                        child: CircularButtonWidget(
                            radius: 15,
                            fontSize: AppStyles.WhiteStyle_WithBold700_Font20.fontSize,
                            fontWeight: FontWeight.w700,
                            buttonColor: Theme.of(context).primaryColor,
                            buttonText: AppStrings.SCANNED_RECEIPT.tr(),
                            onPressed: () {
                              model.navigateToScreen(ReceiptViewScreen.routeName,arguments: model.order.receipts);

                            }))
                        : Container(),
                    model.order.receipts != null ? SizeConfig.horizontalSpaceSmall() : Container(),
                    model.order.status==OrderPurchaseStatus.OrderDelivered||model.order.status==OrderPurchaseStatus.OrderDelivered?Container():Expanded(
                        child: CircularButtonWidget(
                            radius: 15,
                            fontSize: AppStyles.WhiteStyle_WithBold700_Font20.fontSize,
                            fontWeight: FontWeight.w700,
                            buttonColor: Theme.of(context).primaryColor,
                            buttonText: widget.argument.isPrePaid
                                ? AppStrings.RATE_COURIER.tr()
                                : AppStrings.CONTINUE_PAYMENT.tr(),
                            onPressed: () {
                              if (widget.argument.isPrePaid) {
                                MyUtils.showAppDialog(
                                    context: context,
                                    child: RatingDialogWidget(
                                      header: AppStrings.RATE_COURIER.tr(),
                                      rateObjectName: model.order.candidates.first.name,
                                      onRatingUpdate: (val){},
                                      onPressOK: () {
                                        model.navigateToScreen(LandingScreen.routeName);
                                      },
                                    ));
                              } else {
                                model.navigatorPop();
                              }
                            }))
                  ],
                ),
              ),
            )
                : Container(),
          ),
        );
      },
    );
  }

  Widget orderPriceAndQuantityWidget({String firstText, String secondText, String thirdText}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 3),
          child: OrderDeliveredInfoRowWidget(
            firstText: firstText,
            secondText: secondText,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.largeSidepadding.left, top: 3),
          child: Row(
            children: [
              Text(
                thirdText,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderDeliveredScreenArgument {
  final OrderOrPurchases orderOrPurchases;
  final bool isPrePaid;

  OrderDeliveredScreenArgument({this.orderOrPurchases, this.isPrePaid});
}
