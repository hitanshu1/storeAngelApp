import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/services/string_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order_deleivered_summary.dart';
import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/custom_divider_widget.dart';
import 'package:storeangelApp/ui/shared/deliveryinfo_rowWidget.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_offers/courier_order_dialog.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_action_button.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_delivered_summery/delivered_summery_payment_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_delivered_summery/delivery_summery_transfer_option_widget.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/view_delivered_order_item.dart';

import '../../../shared/MyUtils.dart';

class CourierOrderDeliveredSummaryScreen extends StatefulWidget {
  static const String routeName = 'courierOrderDeliveredSummaryScreen';
  final OrderOrPurchases order;

  CourierOrderDeliveredSummaryScreen({this.order});

  @override
  _CourierOrderDeliveredSummaryScreenState createState() => _CourierOrderDeliveredSummaryScreenState();
}

class _CourierOrderDeliveredSummaryScreenState extends State<CourierOrderDeliveredSummaryScreen> {
  var radius = SizeConfig.radiusOfSliverAppbar;
  ScrollController _scrollController = ScrollController();

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_isAppBarExpanded) {
        setState(() {
          isExpanded = true;
          radius = 0.0;
        });
      } else {
        setState(() {
          isExpanded = false;
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
    StatusBarService.changeStatusBarColor(StatusBarType.Light, context);

    return BaseView<CourierOrderDeliveredSummaryViewModel>(
      onModelReady: (model) => model.initializeData(widget.order),
      builder: (context, model, child) {
        if (model.state == ViewState.Busy) {
          return CustomScaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: AppConstants.circulerProgressIndicator());
        }
        return CustomScaffold(
          backgroundColor: Theme.of(context).canvasColor,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              CustomSliverAppBar(
                title: Text(
                  model.order.storeDetails.name,
                  style: AppStyles.BlackStyleFont_c16(context),
                ),
                elevation: 8,
                backgroundColor: Theme.of(context).cardColor,
                pinned: true,
                floating: false,
                leading: BackButton(
                  color: Theme.of(context).iconTheme.color,
                  onPressed: () {
                    model.navigatorPop();
                  },
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(
                      StoreangelIcons.share_with_three_dots_icon,
                      color: Theme.of(context).focusColor,
                      size: SizeConfig.iconSize,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      StoreangelIcons.delete_icon,
                      color: Theme.of(context).focusColor,
                      size: SizeConfig.iconSize,
                    ),
                    onPressed: () {},
                  )
                ],
                shape: ContinuousRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Material(
                    color: Theme.of(context).cardColor,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))),
                    elevation: 0,
                    child: Column(
                      children: [
                        SizeConfig.verticalSpace(SizeConfig.screenHeight * .1),
                        Container(
                          height: SizeConfig.screenWidth * .15 + 18,
                          width: SizeConfig.screenWidth,
                          padding: EdgeInsets.only(top: 12),
                          child: Center(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: model.order.clientlist.length,
                                itemBuilder: (context, int index) {
                                  return Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: InkWell(
                                          child: CircleAvatar(
                                            radius: SizeConfig.screenWidth * .065,
                                            backgroundImage: NetworkImage(model.order.clientlist[index].imageUrl),
                                          ),
                                          onTap: () {
                                            model.onSelectClient(model.order.clientlist[index]);
                                          },
                                        ),
                                      ),
                                      model.selectedClient?.id == model.order.clientlist[index]?.id
                                          ? Positioned.fill(
                                              child: Align(
                                              alignment: Alignment.topRight,
                                              child:
                                                  SizedBox(height: 15, child: Image.asset(AssetsPath.check_checkbox)),
                                            ))
                                          : Container()
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                expandedHeight: SizeConfig.adaptiveHeight(SizeConfig.screenHeight * .165),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                SizeConfig.CVerticalSpacevMedium(),
                Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: SizeConfig.sidepadding,
                          child: CustomCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 55,
                                ),
                                Text(
                                  AppStrings.RATE.tr(),
                                  style: AppStyles.BlackStyleWithBold_FontC20(context)
                                      .copyWith(fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  model.selectedClient.name,
                                  style: AppStyles.BlackStyleWithBold_FontC20(context),
                                ),
                                SizeConfig.CVerticalSpaceMedium25(),
                                FlutterRatingBar(
                                  initialRating: 5.0,
                                  itemCount: 5,
                                  itemSize: 45,
                                  fillColor: AppColors.primaryColor,
                                  borderColor: Theme.of(context).textTheme.headline4.color,
                                  allowHalfRating: true,
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                SizeConfig.CVerticalSpaceMedium25()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: ViewAppImage(
                        imageUrl: model.selectedClient.imageUrl,
                        width: SizeConfig.screenWidth * .19,
                        height: SizeConfig.screenWidth * .19,
                        radius: SizeConfig.screenWidth * .1,
                      ),
                    ),
                  ],
                ),
                SizeConfig.verticalSpaceBigMedium(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ViewAppImage(
                                height: SizeConfig.screenWidth * .17,
                                width: SizeConfig.screenWidth * .17,
                                radius: 10,
                                imageUrl: widget.order.storeDetails.image,
                              ),
                            ),
                          ],
                        ),
                        SizeConfig.horizontalSpaceMedium(),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacer(),
                              Text(
                                model.order.storeDetails.name,
                                style: AppStyles.BlackStyleWithBold800Font_24(context),
                                textAlign: TextAlign.center,
                              ),
                              Spacer(),
                              Text(
                                model.order.storeDetails.street,
                                style: AppStyles.GrayStyle_Font16(context),
                                textAlign: TextAlign.left,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      model.order.storeDetails.zipCity,
                                      style: AppStyles.GrayStyle_Font16(context),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Text(DateService.getDateFormatWithYear(DateTime.now().toIso8601String(), context),
                                    style: AppStyles.BlackStyleFont_16(context),
                                  ),
                                ],
                              ),
                              Spacer()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizeConfig.verticalSpaceMedium(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: CustomCard(
                    child: Padding(
                      padding: SizeConfig.mediumpadding,
                      child: Row(
                        children: [
                          Image.asset(AssetsPath.small_angel_store),
                          SizeConfig.horizontalSpaceSmall(),
                          Expanded(
                              child: Text(
                            AppStrings.YOUR_FEE.tr()+':',
                            style: AppStyles.BlackStyleWithBold600Font_20(context),
                          )),
                          Text('${AppStrings.euro + ' '}${NumberService.addAfterCommaTwoZeros('10.00', context)}', style: AppStyles.BlackStyleWithBold600Font_20(context))
                        ],
                      ),
                    ),
                  ),
                ),
                SizeConfig.verticalSpaceBigMedium(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        AppStrings.SHOPPING_LIST.tr(),
                        style: AppStyles.BlackStyleFont_20(context),
                        textAlign: TextAlign.left,
                      )),
                      Text(AppStrings.EURO.tr(), style: AppStyles.BlackStyleFont_20(context))
                    ],
                  ),
                ),
              ])),
              SliverPadding(
                padding: SizeConfig.sidepadding,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == 4 && !model.viewAllProduct) {
                        return InkWell(
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SizeConfig.horizontalSpaceMedium(),
                                    Text(
                                      '${AppStrings.SHOW.tr()} ${model.products.length - 3} ${AppStrings.MORE_ITEMS.tr()}',
                                      style: AppStyles.GrayStyle_Font16(context),
                                    ),
                                    SizeConfig.horizontalSpaceSmall(),
                                    Image.asset(AssetsPath.threeDot),
                                  ],
                                ),
                              ),
                              Text('€ ${NumberService.addAfterCommaTwoZeros('140,66', context)}')
                            ],
                          ),
                          onTap: () {
                            model.onTapViewAll();
                          },
                        );
                      }
                      return ViewDeliveredOrderItem(
                        product: model.products[index],
                        enableBorderColor: index <
                            (model.products.length > 5 && !model.viewAllProduct ? 3 : model.products.length - 1),
                      );
                    },
                    childCount: model.products.length > 5 && !model.viewAllProduct ? 5 : model.products.length,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    SizeConfig.verticalSpaceMedium(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: CustomDividerWidget(
                        height: 5,
                      ),
                    ),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: CustomDividerWidget(
                        height: 5,
                      ),
                    ),
                    SizeConfig.CVerticalSpaceMedium(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: Row(
                        children: [
                          SizeConfig.horizontalSpaceMedium(),
                          Text(
                            StringService.getCourierBudgetName(widget.order.purchaseDetails).name+':',
                            style: AppStyles.BlackStyleWithw500_FontC18(context),
                          ),
                          Expanded(
                              child: Text(
                            '€ ${NumberService.addAfterCommaTwoZeros('213,59', context)}',
                            style: AppStyles.BlackStyleWithw500_FontC18(context),
                            textAlign: TextAlign.right,
                          ))
                        ],
                      ),
                    ),
                    SizeConfig.verticalSpaceBigMedium(),
                    DeliveredSummeryPaymentWidget(
                      model: model,
                    ),
                    SizeConfig.verticalSpaceBigMedium(),
                    DeliveryInfoRowWidget(
                        firstText: AppStrings.DELIVERY_DATE.tr()+':', secondText: DateService.getDateFormatWithYear(model.order.selectedDate.toIso8601String(), context)),
                    DeliveryInfoRowWidget(
                        firstText: AppStrings.DELIVERED_AT.tr()+':',
                        secondText: DateService.getDateWithHourFormat(model.order.deliveredAt.toIso8601String(),context)),
                    DeliveryInfoRowWidget(
                        firstText: AppStrings.DELIVERED_CITY.tr()+':', secondText: model.selectedClient.city),
                    DeliveryInfoRowWidget(
                        firstText: AppStrings.DELIVERY_STREET.tr()+':', secondText: model.selectedClient.street),
                    DeliveryInfoRowWidget(
                        firstText: AppStrings.PAYMENT_METHOD.tr()+':', secondText: model.order.paymentMethod ?? ''),
                    DeliveryInfoRowWidget(
                        firstText: AppStrings.ORDER_PAYMENT.tr()+':', secondText: model.order.orderPayment),
                    DeliveryInfoRowWidget(
                        firstText: AppStrings.POSTED.tr()+':',
                        secondText: DateService.getDateWithHourFormat(model.order.postedAt.toIso8601String(),context)),
                    DeliveryInfoRowWidget(firstText: AppStrings.ORDER_ID.tr()+':', secondText: model.order.orderID),
                    SizeConfig.CVerticalSpacevEMedium(),
                  ]),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .03),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: SizeConfig.sidepadding,
                    child: model.order.paid
                        ? ButtonWidget(
                            radius: AppConstants.button_Radius,
                            fontSize: AppConstants.fontSizeSmall,
                            buttonColor: Theme.of(context).primaryColor,
                            buttonText: AppStrings.GO_HOME.tr(),
                            onPressed: () {
                              model.navigateToScreen(LandingScreen.routeName,
                                  arguments: LandingScreenArgument(index: 2));
                            })
                        : CourierOrderActionButton(
                            firstButtonText: AppStrings.UNDO.tr(),
                            firstButtonTap: () {model.navigatorPop();},
                            secondButtonText: AppStrings.FINISH.tr(),
                            secondButtonTap: () {
                              if (!model.order.paid) {
                                MyUtils.showAppDialog(
                                    context: context,
                                    child: CustomDialog(
                                      title: AppStrings.PAY_BACK_PENDING.tr(),
                                      subTitle: AppStrings.YOU_NEED_TO_PAY_BACK_THE_MONEY_TO.tr(),
                                      onPressOk: () {
                                        model.navigatorPop();
                                        MyUtils.showAppDialog(
                                            context: context,
                                            child: DeliveryOptionTransferOptionsWidget(
                                              model: model,
                                            ),
                                        );
                                      },
                                    ),
                                );
                              }
                            },
                          ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
