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
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/view_model_order_information.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/circuler_button_widget.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/custom_divider_widget.dart';
import 'package:storeangelApp/ui/shared/custom_flexible_space_widget.dart';
import 'package:storeangelApp/ui/shared/deliveryinfo_rowWidget.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

import 'courier_offers/courier_order_dialog.dart';

class SingleOfferScreen extends StatefulWidget {
  final OrderOrPurchases order;
  static const String routeName = 'singleOfferScreen';

  SingleOfferScreen({this.order});

  @override
  _SingleOfferScreenState createState() => _SingleOfferScreenState();
}

class _SingleOfferScreenState extends State<SingleOfferScreen> {
  var radius = SizeConfig.radiusOfSliverAppbar;
//  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

    return BaseView<OrderInformationViewModel>(
      builder: (context, orderInformationViewModel, child) {
        return Scaffold(
//          key: _scaffoldKey,
          backgroundColor: Theme.of(context).toggleableActiveColor,

          body:
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              CustomSliverAppBar(
                backgroundColor: Theme.of(context).canvasColor,
                pinned: true,
                floating: false,
                leading: BackButton(
                  color: Theme.of(context).iconTheme.color,
                  onPressed: () {
                     Navigator.of(context).pop();




                  },
                ),

                title: Text(
                  AppStrings.YOUR_OFFER.tr(),
                  style: AppStyles.BlackStyleWithBold800Font_24(context),
                ),
                centerTitle: true,
                shape: ContinuousRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))),
                expandedHeight: SizeConfig.adaptiveHeight(SizeConfig.screenHeight * .35),
                flexibleSpace: FlexibleSpaceBar(
                  background: CustomFlexibleSpaceWidget(
                    scrollController: _scrollController,
                    child: Column(
                      children: [
                        SizedBox(
                          height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
                        ),
                        Text(
                          '10 minutes ago',
                          style: AppStyles.BlackStyleFont_16(context),
                        ),
                        SizeConfig.verticalSpaceMedium(),
                        Padding(
                          padding: SizeConfig.sidepadding,
                          child: Container(
                            height: SizeConfig.screenHeight * .06,
                            decoration: BoxDecoration(
                                color:Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(AppConstants.ContainerRoundCorner_Radius)),
                            child: Padding(
                              padding: SizeConfig.sidepadding * 1.15,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      AppStrings.STATUS.tr(),
                                      style: AppStyles.GreenStyleWithBold800_Font30(context).copyWith(
                                        fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ),
                                  Icon(StoreangelIcons.arrow_forward_icon,color: AppColors.primaryColor,
                                  size: SizeConfig.smallerIconSize,),
                                  Expanded(
                                    child: Text(
                                      widget.order.status == OrderPurchaseStatus.PlaceAOrder
                                          ? AppStrings.PENDING.tr()
                                          : widget.order.status == OrderPurchaseStatus.Rejected
                                              ? AppStrings.REJECTED.tr()
                                              : '',
                                      style: widget.order.status == OrderPurchaseStatus.Rejected
                                          ? AppStyles.BlackStyleWithBold800Font_24(context)
                                              .copyWith(fontWeight: FontWeight.normal, color: AppColors.red)
                                          : AppStyles.BlackStyleWithBold800Font_24(context)
                                              .copyWith(fontWeight: FontWeight.normal, fontSize: SizeConfig.fontSizeLarge,
                                      ),textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
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

              SliverToBoxAdapter(
                child:   DeliveryInfoRowWidget(
                    firstText: AppStrings.PREFERRED_DELIVERY_DATE.tr() + ':',
                    secondText: AppStrings.AS_SOON_AS_POSSIBLE.tr()),
              ),
//              SliverList(
//                  delegate: SliverChildListDelegate([
//                SizeConfig.verticalSpaceSmall(),
//                DeliveryInfoRowWidget(
//                    firstText: AppStrings.PREFERRED_DELIVERY_DATE.tr() + ':',
//                    secondText: AppStrings.AS_SOON_AS_POSSIBLE.tr()),
//                DeliveryInfoRowWidget(
//                    firstText: AppStrings.YOUR_DELIVERY_PERIOD.tr() + ':', secondText: DateService.getDateFormatWithYear(widget.order.selectedDate.toIso8601String(),
//                    context)),
//                DeliveryInfoRowWidget(
//                    firstText: StringService.getCourierBudgetName(widget.order.purchaseDetails).name + ':',
//                    secondText: '${AppStrings.euro + ' '}${NumberService.priceAfterConvert(widget.order.orderAmount,context)}'),
//                DeliveryInfoRowWidget(
//                    firstText: AppStrings.ORDER_PAYMENT.tr() + ':', secondText: widget.order.orderPayment),
//                DeliveryInfoRowWidget(
//                  firstText: AppStrings.NUMBER_OF_OFFERS.tr() + ':',
//                  secondText: '7',
//                  hasBorderColor: true,
//                ),
//                DeliveryInfoRowWidget(
//                  firstText: AppStrings.PUBLISHED.tr() + ' / ' + AppStrings.COMPLETED.tr() + ':',
//                  secondText: '6 / 4',
//                ),
//                SizeConfig.CVerticalSpaceMedium(),
//                Padding(
//                  padding: SizeConfig.sidepadding,
//                  child: Text(AppStrings.COMMENT.tr() + ':', style: AppStyles.GrayStyle_Font16(context)),
//                ),
//                SizeConfig.CVerticalSpaceSmallMediumC12(),
//                Padding(
//                  padding: SizeConfig.sidepadding,
//                  child: Text(widget.order.comment),
//                ),
//                SizeConfig.CVerticalSpaceBig43(),
//                Padding(
//                  padding: SizeConfig.sidepadding,
//                  child: Text(
//                    '${widget.order.purchaseDetails.products.length} ${AppStrings.ITEMS.tr()}',
//                    style: AppStyles.BlackStyleFont300_16(context),
//                  ),
//                ),
//                SizeConfig.verticalSpaceSmall(),
//              ])),
//              SliverPadding(
//                padding: SizeConfig.sidepadding,
//                sliver: SliverList(
//                  delegate: SliverChildBuilderDelegate(
//                      (context, index) => Container(
//                            decoration:
//                                BoxDecoration(border: AppConstants.bottomBorder(context)),
//                            child: Padding(
//                              padding: SizeConfig.verticalC13Padding,
//                              child: Row(
//                                children: [
//                                  StatusDot(
//                                    availableStatus: widget.order.purchaseDetails.products[index].availableStatus,
//                                  ),
//                                  SizeConfig.horizontalSpaceSmall(),
//                                  Expanded(
//                                    child: RichText(
//                                      text: TextSpan(
//                                        text: '${widget.order.purchaseDetails.products[index].name} ',
//                                        style: AppStyles.BlackStyleWithBold600Font_20(context),
//                                      ),
//                                    ),
//                                  ),
//                                  widget.order.purchaseDetails.products[index].quantity != 0
//                                      ? Text('${widget.order.purchaseDetails.products[index].quantity}')
//                                      : Container()
//                                ],
//                              ),
//                            ),
//                          ),
//                      childCount: widget.order.purchaseDetails.products.length > 4 && !orderInformationViewModel.viewAll
//                          ? 4
//                          : widget.order.purchaseDetails.products.length),
//                ),
//              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .04),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: EdgeInsets.fromLTRB(SizeConfig.sidepadding.left, SizeConfig.screenHeight * .01,
                            SizeConfig.sidepadding.right, 0),
                        child: InkWell(
                          child: Text(
                            orderInformationViewModel.viewAll
                                ? AppStrings.CLOSE.tr()
                                : '${AppStrings.EXPAND.tr()}',
                            style: AppStyles.GreenStyle_Font20(context),
                          ),
                          onTap: () {
                            orderInformationViewModel.toggleView();
                          },
                        ),
                      ),
                      SizeConfig.verticalSpaceMedium(),
                      Padding(
                        padding: SizeConfig.sidepadding,
                        child: Column(
                          children: [
                            SizeConfig.verticalSpaceSmall(),
                            CustomDividerWidget(
                              height: 1,
                            ),
                            SizeConfig.verticalSpaceSmall(),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  AppStrings.PURCHASE_BUDGET.tr() + ':',
                                  style: AppStyles.BlackStyleFont_20(context),
                                )),
                                Text('${AppStrings.euro + ' '}${NumberService.priceAfterConvert(230,context)}',
                                    style: AppStyles.BlackStyleFont_20(context))
                              ],
                            ),
                            SizeConfig.verticalSpaceSmall(),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  AppStrings.MY_FEE.tr() + ':',
                                  style: AppStyles.BlackStyleFont_20(context),
                                )),
                                Text('${AppStrings.euro + ' '}${NumberService.priceAfterConvert(10,context)}',
                                    style: AppStyles.BlackStyleFont_20(context))
                              ],
                            ),
                            SizeConfig.verticalSpaceSmall(),
                            CustomDividerWidget(
                              height: 1,
                            ),
                            SizeConfig.verticalSpaceSmall(),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  AppStrings.TOTAL.tr() + ':',
                                  style: AppStyles.BlackStyleFontw300_20(context).copyWith(fontWeight: FontWeight.bold),
                                )),
                                Text('${AppStrings.euro + ' '}${NumberService.priceAfterConvert(240,context)}',
                                    style:
                                        AppStyles.BlackStyleFontw300_20(context).copyWith(fontWeight: FontWeight.bold))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizeConfig.verticalSpaceMedium(),
                      Column(
                        children: [
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: Center(
                              child: Text(
                                AppStrings.DECLINED_OFFERS_WILL_BE.tr(),
                                style: AppStyles.GrayStyle_Font12(context),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizeConfig.CVerticalSpacevEMedium(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * .1,
                                right: SizeConfig.screenWidth * .1,
                                bottom: SizeConfig.screenHeight * .04),
                            child: CircularButtonWidget(
                                radius: AppConstants.button_Radius,
                                fontSize: AppConstants.fontSizeSmall,
                                buttonColor: Theme.of(context).cardColor,
                                buttonText: AppStrings.REMOVE_OFFER_NOW.tr(),
                                textColor: Theme.of(context).textTheme.headline6.color,
                                onPressed: () {
                                  if (widget.order.status != OrderPurchaseStatus.Rejected)
                                    MyUtils.showAppDialog(
                                        context: context,
                                        child: CustomDialog(
                                          title: AppStrings.CANCEL_OFFER.tr(),
                                          subTitle: AppStrings.DO_YOU_REALLY_WANT_TO_CANCEL.tr(),
                                          onPressOk: () {
                                            orderInformationViewModel.onDeleteOffer(widget.order);
                                            orderInformationViewModel.navigatorPop();
                                          },
                                        ));
                                  else
                                    orderInformationViewModel.navigatorPop();
                                }),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
