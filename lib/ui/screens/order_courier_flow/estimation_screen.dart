import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/regexService.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/services/string_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_estimation.dart';
import 'package:storeangelApp/ui/screens/consumer/mainApp_Screen.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/smalltextfield.dart';
import 'package:storeangelApp/ui/widgets/order_courier_flow/order_courier_flow.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';

class EstimationScreen extends StatefulWidget {
  static const String routeName = 'estimationScreen';
  final PurchaseDetails purchaseDetails;

  EstimationScreen({this.purchaseDetails});

  @override
  _EstimationScreenState createState() => _EstimationScreenState();
}

class _EstimationScreenState extends State<EstimationScreen> {
  var _radius = SizeConfig.radiusOfSliverAppbar;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => StatusBarService.changeStatusBarColor(StatusBarType.Light, context));

    _scrollController.addListener(() {
      if (_isAppBarExpanded) {
        setState(() {
          _radius = 0.0;
        });
      } else {
        setState(() {
          _radius = SizeConfig.radiusOfSliverAppbar;
        });
      }
    });
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients && _scrollController.offset > (200 - kToolbarHeight);
  }

  String _priceAndAmountString(int quantity, double price) =>
      (quantity?.toString() ?? '1') + ' x ' + (NumberService.addAfterCommaTwoZeros(price.toString(), context) ?? '1,00');

  String _getCalculatedSum(int quantity, double price) =>
      NumberService.addAfterCommaTwoZeros(((quantity ?? 1) * (price ?? 1.00)).toString(), context);

  String _getTotalSum(PurchaseDetails purchaseDetails) {
    double sum = 0;
    final productList = purchaseDetails.products;
    for (int i = 0; i < productList.length; i++) {
      sum += (productList[i].price ?? 1) * (productList[i].quantity ?? 1);
    }
    return NumberService.addAfterCommaTwoZeros(sum.toString(), context);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    Provider.of<EstimationViewModel>(context, listen: false).totalSumTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    Future.delayed(Duration.zero, () => StatusBarService.changeStatusBarColor(StatusBarType.Light, context));
    return BaseView<EstimationViewModel>(
      onModelReady: (estimationViewModel) => estimationViewModel.init(widget.purchaseDetails),
      builder: (context, estimationViewModel, child) {
        return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              CustomSliverAppBar(
                  backgroundColor: Theme.of(context).cardColor,
                  pinned: true,
                  floating: false,
                  leading: BackButton(
                    color: Theme.of(context).iconTheme.color,
                    onPressed: () {
                      estimationViewModel.navigatorPop();
                    },
                  ),
                  title: Text(
                    StringService.getEstimationPageTitle(widget.purchaseDetails),
                    style: AppStyles.BlackStyleWithBold800Font_24(context),
                  ),
                  centerTitle: true,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(_radius), bottomRight: Radius.circular(_radius))),
                  bottom: PreferredSize(
                    child: OrderCourierStatusWidget(
                      status: OrderCourierStatus.Calculate,
                    ),
                    preferredSize: Size.fromHeight(SizeConfig.expandedHeight * .5),
                  )),
              SliverPadding(
                padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .2),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index == 0)
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizeConfig.CVerticalSpaceMedium(),
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: Row(
                              children: [
                                Text(
                                  AppStrings.YOUR_PRICING_INFORMATION.tr() + ':',
                                  textAlign: TextAlign.center,
                                  style: AppStyles.BlackStyleWithBold800Font_20(context),
                                ),
                              ],
                            ),
                          ),
                          SizeConfig.CVerticalSpaceSmallMediumC12(),
                        ],
                      );
                    if (index > 0 && index < (widget.purchaseDetails.products.length + 1)) {
                      int productIndex = index - 1;
                      return Container(
                        padding: SizeConfig.padding.copyWith(left: 0, right: 0),
                        margin: SizeConfig.padding.copyWith(top: 0, bottom: 0),
                        decoration: BoxDecoration(border: AppConstants.bottomBorder(context)),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizeConfig.verticalSpaceSmall(),
                                Text(
                                  widget.purchaseDetails.products[productIndex].name,
                                  style: AppStyles.BlackStyleWithBold800Font_20(context),
                                ),
                                SizeConfig.verticalSpaceSmall(),
                                Text(
                                    _priceAndAmountString(
                                        estimationViewModel.purchaseDetails.products[productIndex].quantity,
                                        estimationViewModel.purchaseDetails.products[productIndex].price),
                                    style: AppStyles.BlackStyleFont_20(context)),
                                SizeConfig.verticalSpaceSmall(),
                              ],
                            )),
                            SizeConfig.horizontalSpaceSmall(),
                            Container(
                              width: SizeConfig.screenWidth * .23,
                              height: SizeConfig.textFieldAdaptiveHeight(SizeConfig.screenHeight * .05),
                              child: SmallTextField(
                                textInputType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegexService.doubleRegexWithCommaOrDotAndTwoDigit)
                                ],
                                onTap: () {
                                  Future.delayed(Duration(milliseconds: 300),
                                      () => StatusBarService.changeStatusBarColor(StatusBarType.Light, context));
                                },
                                onSubmit: (txt) {
                                  estimationViewModel.changeTotalAndSingleAmount(txt, productIndex);
                                  estimationViewModel.getBudgetName();
                                  Future.delayed(Duration(milliseconds: 500),
                                      () => StatusBarService.changeStatusBarColor(StatusBarType.Light, context));
                                  Future.delayed(Duration(milliseconds: 300), () {
                                    _scrollController.jumpTo(_scrollController.offset + 1);
                                  });
                                },
                                hintText: _getCalculatedSum(
                                    estimationViewModel.purchaseDetails.products[productIndex].quantity,
                                    estimationViewModel.purchaseDetails.products[productIndex].price),
                                hasBorderSideColor: false,
                                textInputAction: TextInputAction.done,
                              ),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
                            ),
                          ],
                        ),
                      );
                    } else
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizeConfig.CVerticalSpacevEMedium(),
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      estimationViewModel.budgetName + ':',
                                      style: AppStyles.BlackStyleWithBold800Font_20(context),
                                    ),
                                    SizeConfig.verticalSpaceSmall(),
                                    Text(
                                      estimationViewModel.budgetDescription,
                                      style: AppStyles.GrayStyle_Font16(context),
                                    )
                                  ],
                                )),
                                SizeConfig.horizontalSpaceSmall(),
                                Container(
                                  width: SizeConfig.screenWidth * .23,
                                  height: SizeConfig.textFieldAdaptiveHeight(SizeConfig.screenHeight * .05),
                                  child: SmallTextField(
                                    controller: estimationViewModel.totalSumTextEditingController,
                                    textInputType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegexService.doubleRegexWithCommaOrDotAndTwoDigit)
                                    ],
                                    onTap: () {
                                      Future.delayed(Duration(milliseconds: 300),
                                          () => StatusBarService.changeStatusBarColor(StatusBarType.Light, context));
                                    },
                                    onSubmit: (txt) {
                                      estimationViewModel.setTotalSumValue(txt, context);
                                      Future.delayed(Duration(milliseconds: 500),
                                          () => StatusBarService.changeStatusBarColor(StatusBarType.Light, context));
                                      Future.delayed(Duration(milliseconds: 300), () {
                                        _scrollController.jumpTo(_scrollController.offset + 1);
                                      });
                                    },
                                    hintText: _getTotalSum(estimationViewModel.purchaseDetails),
                                    hasBorderSideColor: false,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                  }, childCount: widget.purchaseDetails.products.length + 2),
                ),
              ),
            ],
          ),
          floatingActionButtonAnimator: NoScalingAnimation(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: keyboardIsOpened
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * .1,
                      right: SizeConfig.screenWidth * .1,
                      bottom: SizeConfig.screenHeight * .04),
                  child: ButtonWidget(
                      radius: AppConstants.button_Radius,
                      fontSize: AppConstants.fontSizeSmall,
                      buttonColor: Theme.of(context).primaryColor,
                      buttonText: AppStrings.PUBLISH_ORDER.tr(),
                      onPressed: () {
                        estimationViewModel.navigateToScreen(MainAppScreen.routeName, context);
                      }),
                ),
        );
      },
    );
  }
}
