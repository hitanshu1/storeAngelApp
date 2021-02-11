import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/mobileSize.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/services/string_service.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/view_model_order_information.dart';
import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/custom_divider_widget.dart';
import 'package:storeangelApp/ui/shared/custom_flexible_space_widget.dart';
import 'package:storeangelApp/ui/shared/deliveryinfo_rowWidget.dart';
import 'package:storeangelApp/ui/shared/showbottomSheet.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_list_product_info_widget.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/deliverylocation/singleline_selectable_option.dart';
import 'package:storeangelApp/ui/widgets/share/custom_date_picker.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';

class OrderInformationScreen extends StatefulWidget {
  final OrderOrPurchases order;
  static const String routeName = 'orderInformationScreen';

  OrderInformationScreen({this.order});

  @override
  _OrderInformationScreenState createState() => _OrderInformationScreenState();
}

class _OrderInformationScreenState extends State<OrderInformationScreen> {
  var radius = SizeConfig.radiusOfSliverAppbar;
  final double _tileWidth = SizeConfig.screenWidth * .7;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();

  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_isAppBarExpanded) {
        setState(() {
          radius = 0.0;
        });
      } else {
        setState(() {
          radius = SizeConfig.radiusOfSliverAppbar;
        });
      }
    });
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients && _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.OffGray, context);
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    final theme = Theme.of(context);
    return BaseView<OrderInformationViewModel>(
      builder: (context, orderInformationViewModel, child) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).canvasColor,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              CustomSliverAppBar(
                backgroundColor: theme.cardColor,
                pinned: true,
                floating: false,
                leading: BackButton(
                  color: Theme.of(context).iconTheme.color,
                  onPressed: () {
                    orderInformationViewModel.navigatorPop();
                  },
                ),
                title: Text(
                  AppStrings.REQUEST.tr(),
                  style: AppStyles.BlackStyleWithBold800Font_24(context),
                ),
                centerTitle: true,
                shape: ContinuousRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))),
                expandedHeight: SizeConfig.screenHeight * .27 * (SizeConfig.mobileSize == MobileSize.small ? 1.3 : 1.0),
                flexibleSpace: FlexibleSpaceBar(
                  background: CustomFlexibleSpaceWidget(
                    scrollController: _scrollController,
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight * .12,
                          ),
                          Text(
                            TimeAgoService.timeAgoFromPlugin(DateTime.now().subtract(Duration(minutes: 15)), context),
                            style: AppStyles.BlackStyleFont_16(context),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    ViewAppImage(
                                      imageUrl: widget.order.storeDetails.image,
                                      height: 40,
                                      width: 40,
                                      radius: 5,
                                    ),
                                    SizeConfig.verticalSpaceSmall(),
                                    Text(
                                      widget.order.storeDetails.name,
                                      style: AppStyles.BlackStyleWithBold700Font_18(context),
                                      textAlign: TextAlign.center,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            widget.order.storeDetails.street,
                                            style: AppStyles.GrayStyle_Font16(context),
                                            maxLines: 1,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            widget.order.storeDetails.zipCity,
                                            style: AppStyles.GrayStyle_Font16(context),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizeConfig.horizontalSpaceSmall(),
                              Column(
                                children: [
                                  SizeConfig.verticalSpaceSmall(),
                                  Text(
                                    '${widget.order.purchaseDetails.products.length} ${AppStrings.ITEMS.tr()}',
                                    textAlign: TextAlign.center,
                                    style: AppStyles.BlackStyleFont_16(context),
                                  ),
                                  SizeConfig.verticalSpaceSmall(),
                                  Text(
                                    '300 m',
                                    style: AppStyles.GreenStyleWith_Font16(context),
                                  )
                                ],
                              ),
                              SizeConfig.horizontalSpaceSmall(),
                              Expanded(
                                child: Column(
                                  children: [
                                    ViewAppImage(
                                      height: 40,
                                      width: 40,
                                      radius: 40,
                                      imageUrl: widget.order.clientDetails.imageUrl,
                                    ),
                                    SizeConfig.verticalSpaceSmall(),
                                    Text(
                                      '${widget.order.clientDetails.name}',
                                      style: AppStyles.BlackStyleWithBold700Font_18(context),
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: SizeConfig.sidepadding,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              widget.order.clientDetails.street,
                                              style: AppStyles.GrayStyle_Font16(context),
                                              maxLines: 1,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              widget.order.clientDetails.zipCity,
                                              style: AppStyles.GrayStyle_Font16(context),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizeConfig.verticalSpaceVerySmall(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizeConfig.verticalSpaceSmall(),
                  DeliveryInfoRowWidget(
                      firstText: AppStrings.DELIVERY_DATE.tr() + ':', secondText: AppStrings.AS_SOON_AS_POSSIBLE.tr()),
                  DeliveryInfoRowWidget(
                      firstText: StringService.getCourierBudgetName(widget.order.purchaseDetails).name + ':',
                      secondText:
                          '${AppStrings.euro + ' '}${NumberService.priceAfterConvert(widget.order.orderAmount, context)}'),
                  DeliveryInfoRowWidget(
                      firstText: AppStrings.ORDER_PAYMENT.tr() + ':', secondText: widget.order.orderPayment),
                  DeliveryInfoRowWidget(
                    firstText: AppStrings.NUMBER_OF_OFFERS.tr() + ':',
                    secondText: '7',
                  ),
                  DeliveryInfoRowWidget(
                    firstText: AppStrings.PUBLISHED.tr() + ' / ' + AppStrings.COMPLETED.tr() + ':',
                    secondText: '6 / 4',
                  ),
                  SizeConfig.CVerticalSpaceMedium(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: Text(AppStrings.COMMENT.tr() + ':', style: AppStyles.GrayStyle_Font16(context)),
                  ),
                  SizeConfig.CVerticalSpaceSmallMediumC12(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: Text(widget.order.comment),
                  ),
                  SizeConfig.CVerticalSpaceBig43(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: Text(
                      '${widget.order.purchaseDetails.products.length} ${AppStrings.ITEMS.tr()}',
                      style: AppStyles.BlackStyleFont_20(context).copyWith(fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizeConfig.verticalSpaceSmall()
                ]),
              ),
              SliverPadding(
                padding: SizeConfig.sidepadding,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => Container(
                            decoration: BoxDecoration(border: AppConstants.bottomBorder(context)),
                            child: Padding(
                              padding: SizeConfig.verticalC13Padding,
                              child: CourierListProductInfoWidget(
                                product: widget.order.purchaseDetails.products[index],
                              ),
                            ),
                          ),
                      childCount: widget.order.purchaseDetails.products.length > 4 && !orderInformationViewModel.viewAll
                          ? 4
                          : widget.order.purchaseDetails.products.length),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .15),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.fromLTRB(SizeConfig.sidepadding.left, SizeConfig.verticalC13Padding.top,
                        SizeConfig.sidepadding.right, 0),
                    child: InkWell(
                      onTap: () {
                        orderInformationViewModel.toggleView();
                      },
                      child: Text(
                        orderInformationViewModel.viewAll ? AppStrings.DECREASE.tr() : '${AppStrings.EXPAND.tr()}',
                        style: AppStyles.GreenStyle_Font20(context),
                      ),
                    ),
                  ),
                  SizeConfig.CVerticalSpaceBig(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: CustomDividerWidget(),
                  ),
                  SizeConfig.CVerticalSpaceSmallMediumC12(),
                  widget.order.storeDetails.paymentType == PaymentType.Both
                      ? Padding(
                          padding: SizeConfig.padding,
                          child: Text(
                            AppStrings.SELECT_YOUR_PREFERRED_ORDER_PAYMENT.tr() + ':',
                            style: AppStyles.BlackStyleWithBold800Font_16(context),
                          ),
                        )
                      : Container(),
                  widget.order.storeDetails.paymentType == PaymentType.Both
                      ? Padding(
                          padding: SizeConfig.sidepadding,
                          child: Row(
                            children: [
                              Container(
                                width: _tileWidth,
                                child: Container(
                                  child: ListView.builder(
                                      itemCount: orderInformationViewModel.orderPayments.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.all(0),
                                      itemBuilder: (context, int index) {
                                        return Padding(
                                            padding: SizeConfig.smallerVerticalPadding3,
                                            child: SingleLineSelectableOption(
                                              title: orderInformationViewModel.orderPayments[index],
                                              value: orderInformationViewModel.orderPayments[index] ==
                                                  orderInformationViewModel.selectedPaymentMethod,
                                              onTap: () {
                                                orderInformationViewModel.onSelectPaymentMethod(
                                                    orderInformationViewModel.orderPayments[index]);
                                              },
                                            ));
                                      }),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  widget.order.storeDetails.paymentType == PaymentType.Both
                      ? SizeConfig.verticalSpaceMedium()
                      : Container(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.SELECT_THE_DELIVERY_DATE_AND_TIMERANGE.tr() + ':',
                          style: AppStyles.BlackStyleWithBold800Font_16(context),
                        ),
                        SizeConfig.verticalSpaceSmall(),
                        InkWell(
                          child: Container(
                            width: _tileWidth,
                            height: SizeConfig.adaptiveHeight(SizeConfig.screenHeight * .045),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: SizeConfig.sidepadding,
                              child: orderInformationViewModel.selectDateAndTime != null
                                  ? Text(
                                      orderInformationViewModel.selectDateAndTime,
                                      textAlign: TextAlign.center,
                                      style: AppStyles.BlackStyleFontWeightSmall_12(context),
                                      maxLines: 1,
                                    )
                                  : Text(
                                      AppStrings.SELECT_DATETIME.tr(),
                                      textAlign: TextAlign.start,
                                      style: AppStyles.BlackStyleFontWeightSmall_12(context),
                                      maxLines: 1,
                                    ),
                            ),
                          ),
                          onTap: () => onTapDeliveryPeriod(orderInformationViewModel),
                        ),
                      ],
                    ),
                  ),
                  SizeConfig.verticalSpaceMedium(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.MY_FEE.tr() + ':',
                          style: AppStyles.BlackStyleWithBold800Font_16(context),
                        ),
                        SizeConfig.verticalSpaceSmall(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: AppColors.green,
                                size: SizeConfig.screenWidth * .1,
                              ),
                              onPressed: () {
                                orderInformationViewModel.onDecrementFee();
                              },
                              iconSize: SizeConfig.screenWidth * .1,
                            ),
                            SizedBox(
                                width: 80,
                                child: Center(
                                    child: Text(
                                  '€ '+NumberService.addAfterCommaTwoZeros(orderInformationViewModel.myFee.toString(), context),
                                  style: AppStyles.BlackStyleFont_20(context),
                                ))),
                            IconButton(
                              icon: Icon(Icons.add_circle,
                                  color: Theme.of(context).primaryColor, size: SizeConfig.screenWidth * .1),
                              onPressed: () {
                                orderInformationViewModel.onIncrementFee();
                              },
                              iconSize: SizeConfig.screenWidth * .1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizeConfig.CVerticalSpaceExtraBig(),
                  Center(
                    child: SizedBox(
                      width: SizeConfig.screenWidth * .8,
                      child: Text(
                        AppStrings.TRACK_AFTERWARDS.tr(),
                        style: AppStyles.BlackStyleFont_20(context),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizeConfig.CVerticalSpacevEMedium(),
                ])),
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
                      buttonColor: AppColors.green,
                      buttonText: AppStrings.SEND_OFFER.tr(),
                      onPressed: () {

                        orderInformationViewModel.navigateToScreen(LandingScreen.routeName,
                            arguments: LandingScreenArgument(index: 1));
                        StatusBarService.changeStatusBarColor(StatusBarType.White, context);
                      }),
                ),
        );
      },
    );
  }

  void onTapDeliveryPeriod(OrderInformationViewModel orderInformationViewModel) {
    ShowBottomSheet.showLarge(
        child: CustomDatePickerWidget(
          enableAllDate: true,
          minimumDate: DateTime(
              orderInformationViewModel.initialDateTime.year,
              orderInformationViewModel.initialDateTime.month,
              orderInformationViewModel.initialDateTime.day,
              orderInformationViewModel.initialDateTime.minute <= 30
                  ? orderInformationViewModel.initialDateTime.hour + 1
                  : orderInformationViewModel.initialDateTime.hour + 2,
              orderInformationViewModel.initialDateTime.minute <= 30 ? 30 : 0),
          initialDatetime: DateTime(
              orderInformationViewModel.initialDateTime.year,
              orderInformationViewModel.initialDateTime.month,
              orderInformationViewModel.initialDateTime.day,
              orderInformationViewModel.initialDateTime.minute <= 30
                  ? orderInformationViewModel.initialDateTime.hour + 1
                  : orderInformationViewModel.initialDateTime.hour + 2,
              orderInformationViewModel.initialDateTime.minute <= 30 ? 30 : 0),
          bottomText: AppStrings.NEXT_SELECT_END_TIME.tr(),
          onSelect: (dateTime) {
            orderInformationViewModel.onSelectStartDate(dateTime);
            if (dateTime != null) {
              Navigator.pop(context);
              ShowBottomSheet.showLarge(
                  child: CustomDatePickerWidget(
                    initialDatetime: DateTime(
                        orderInformationViewModel.startDate.year,
                        orderInformationViewModel.startDate.month,
                        orderInformationViewModel.startDate.day,
                        orderInformationViewModel.startDate.hour+1,
                        orderInformationViewModel.startDate.minute),
                    bottomText: AppStrings.DELIVERY_UNTIL.tr(),
                    minimumDate: DateTime(
                        orderInformationViewModel.startDate.year,
                        orderInformationViewModel.startDate.month,
                        orderInformationViewModel.startDate.day,
                        orderInformationViewModel.startDate.hour+1,
                        orderInformationViewModel.startDate.minute),
                    onSelect: (dateTime) {
                      orderInformationViewModel.onSelectEndDate(dateTime, context);

                      orderInformationViewModel.navigatorPop();
                    },
                  ),
                  context: context,
                  heightFactor: .4);
            }
          },
        ),
        context: context,
        heightFactor: .4);
  }
}
