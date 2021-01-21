import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/home_viewmodel.dart';
import 'package:storeangelApp/ui/screens/courier_status_screen.dart';
import 'package:storeangelApp/ui/screens/order/order_page.dart';
import 'package:storeangelApp/ui/screens/order_delivered_screen.dart';
import 'package:storeangelApp/ui/shared/circleIcon.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrderItemListWidget extends StatelessWidget {
  final OrderOrPurchases order;
  final bool running;
  final HomeViewModel model;

  OrderItemListWidget({this.order, this.running, this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.bottomPadding.bottom * .5),
      child: InkWell(
        onTap: () {
          if (order.status == OrderPurchaseStatus.Finished || order.status == OrderPurchaseStatus.OrderDelivered) {
            model.navigateToScreen(OrderDeliveredScreen.routeName, context,
                arguments: OrderDeliveredScreenArgument(orderOrPurchases: order, isPrePaid: false));
          }else if(order.status==OrderPurchaseStatus.Proposal){
            model.navigateToScreen(OrderPageScreen.routeName, context,
                arguments: order.purchaseDetails);
          } else {
            model.navigateToScreen(CourierStatusScreen.routeName, context,
                arguments: CourierStatusScreenArgument(orderOrPurchases: order));
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.red, AppColors.primaryColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(AppConstants.ContainerRoundCorner_Radius * 2),
          ),
          child: Slidable(
            actionPane: SlidableBehindActionPane(),
            actionExtentRatio: 0.27,
            actions: [
              IconSlideAction(
                foregroundColor: Colors.transparent,
                color: Colors.transparent,
                iconWidget: Icon(
                  Icons.delete, color: Colors.white, size: SizeConfig.mediumIcon,
                ),
                onTap: () {},
              ),
            ],
            secondaryActions: order.status == OrderPurchaseStatus.Finished
                ? <Widget>[
                    IconSlideAction(
                      foregroundColor: Colors.transparent,
                      color: Colors.transparent,
                      iconWidget: Icon(
                        Icons.open_with, color: Colors.white, size: SizeConfig.mediumIcon,
                      ),
                      onTap: () {},
                    ),
                  ]
                : [],
            child: CustomCard(
              margin: EdgeInsets.only(),
              child: Padding(
                padding: SizeConfig.verticalC13Padding,
                child: Column(
                  children: <Widget>[
                    SizeConfig.CVerticalSpaceVarySmall(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: order.type == OrderAndPurchaseType.Order
                                    ? AppStrings.STATUS.tr()
                                    : AppStrings.PURCHASE_STATUS.tr(),
                                style: order.status != OrderPurchaseStatus.OrderDelivered &&
                                        order.status != OrderPurchaseStatus.Finished
                                    ? AppStyles.GreenStyleWithBold300_Font20(context)
                                    : AppStyles.GrayStyle_FontMedium(context),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: _getOrderStatus,
                                      style: order.status != OrderPurchaseStatus.OrderDelivered &&
                                              order.status != OrderPurchaseStatus.Finished
                                          ? AppStyles.GreenStyleWithBold800_Font20(context)
                                          : AppStyles.GrayStyle_FontMedium(context).copyWith(fontWeight: FontWeight.w800)),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            DateService.getDateWithHourFormat(DateTime.now().toIso8601String(), context),
                            style: order.status != OrderPurchaseStatus.OrderDelivered &&
                                    order.status != OrderPurchaseStatus.Finished
                                ? AppStyles.GreenStyleWithBold300_Font20(context)
                                : AppStyles.GrayStyle_FontMedium(context),
                          ),
                        ],
                      ),
                    ),
                    SizeConfig.verticalSpaceSmall(),
                    Divider(
                      height: 1,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    SizeConfig.verticalSpaceSmall(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  order.shopName,
                                  style: order.status != OrderPurchaseStatus.OrderDelivered &&
                                          order.status != OrderPurchaseStatus.Finished
                                      ? AppStyles.BlackStyleWithBold800Font_24(context)
                                      : AppStyles.GrayStyle_Font24(context).copyWith(fontWeight: FontWeight.w800),
                                ),
                                Container(
                                  padding: EdgeInsets.all(AppConstants.marginVerySmall),
                                ),
                                Text(
                                  order.purchaseDetails.storeDetails.street,
                                  style: AppStyles.GrayStyle_Font16(context),
                                ),
                                Container(
                                  padding: EdgeInsets.all(AppConstants.marginVerySmall),
                                ),
                                Text(
                                  order.purchaseDetails.storeDetails.zipCity,
                                  style: AppStyles.GrayStyle_Font16(context),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "${AppStrings.euro} ${NumberService.priceAfterConvert(order.orderAmount,context)}",
                                  style: order.status != OrderPurchaseStatus.OrderDelivered &&
                                          order.status != OrderPurchaseStatus.Finished
                                      ? AppStyles.BlackStyleWithBold800Font_24(context)
                                      : AppStyles.GrayStyle_Font24(context).copyWith(fontWeight: FontWeight.w800),
                                ),
                                Container(
                                  padding: EdgeInsets.all(AppConstants.marginVerySmall),
                                ),
                                Text(
                                  "${order.quantity} ${AppStrings.ITEMS.tr()}",
                                  style: AppStyles.GrayStyle_Font16(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizeConfig.verticalSpace(
                      SizeConfig.screenHeight * .02,
                    ),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: Container(
                        decoration: BoxDecoration(
                          color: order.status != OrderPurchaseStatus.OrderDelivered &&
                                  order.status != OrderPurchaseStatus.Finished
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).toggleableActiveColor,
                          borderRadius: BorderRadius.circular(AppConstants.ContainerRoundCorner_Radius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: order.type == OrderAndPurchaseType.Order ? showporposal(order, context) : purchaseView(),
                        ),
                      ),
                    ),
                    SizeConfig.CVerticalSpaceVarySmall(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showporposal(OrderOrPurchases order, BuildContext context) {
    if (order.status != OrderPurchaseStatus.OrderDelivered && order.status != OrderPurchaseStatus.Finished) {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: AppConstants.ContainerHeight_width*1.3,
                      height: AppConstants.ContainerHeight_width*1.3,
                      child: CircleIcon(
                        icon: get_order_icon(),
                        backgroundColor: Theme.of(context).cardColor,
                        iconColor: Theme.of(context).primaryColor,
                        iconSize: AppConstants.ContainerHeight_width*.9,
                        size: Size(AppConstants.ContainerHeight_width*1.3, AppConstants.ContainerHeight_width*1.3),
                      ),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).cardColor),
                    ),
                    Container(
                      padding: EdgeInsets.all(AppConstants.marginVerySmall1),
                    ),
                    Flexible(
                      child: Text(statusString,
                        style: AppStyles.WhiteStyleWithBold800_Font16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Visibility(
            child: Expanded(
              flex: 3,
              child: order.status==OrderPurchaseStatus.Pending||order.status==OrderPurchaseStatus.Proposal?Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${order.proposalDetails.totalProposals} ${AppStrings.OFFERS.tr()}',
                    style: AppStyles.WhiteStyleWithBold600_Font16,
                  ),
                  Container(
                    padding: EdgeInsets.all(AppConstants.marginVerySmall),
                  ),
                  Text(TimeAgoService.timeAgoSinceDate(order.proposalDetails.time, context),
                    style: AppStyles.WhiteStyle_Font16,
                  ),
                ],
              ):Text(
                '$statusSubtitle',
                style: AppStyles.WhiteStyleWithBold600_Font16,textAlign: TextAlign.end,
              ),
            ),
            visible: true,
          ),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: AppConstants.ContainerHeight_width*1.3,
                      height: AppConstants.ContainerHeight_width*1.3,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(order.candidates.first.imageUrl),
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.all(AppConstants.marginVerySmall1),
                    ),
                    Text(
                      order.candidates.first.name,
                      style: AppStyles.GrayStyle_Font16(context).copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                )
              ],
            ),
          ),
          Visibility(
            child: Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(AppConstants.marginVerySmall),
                  ),
                  Text(
                    "${order.candidates.first.time}",
                    style: AppStyles.GrayStyle_Font16(context),
                  ),
                ],
              ),
            ),
            visible: false,
          ),
          Visibility(
            child: Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FlutterRatingBar(
                    initialRating: order.candidates.first.stars.toDouble(),
                    itemCount: AppConstants.Ratingbar_item_count,
                    ignoreGestures: true,
                    itemSize: AppConstants.Ratingbar_itemSize,
                    fillColor: AppColors.primaryColor,
                    borderColor: Theme.of(context).textTheme.headline4.color,
                    allowHalfRating: true,
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(AppConstants.marginVerySmall),
                  ),
                  IntrinsicWidth(
                    child: FittedBox(
                      child: Text(
                        timeago.format(order.purchaseDetails.time, locale: context.locale.languageCode),
                        maxLines: 1,
                        style: AppStyles.GrayStyle_Font16(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            visible: true,
          ),
        ],
      );
    }
  }

  Widget purchaseView() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ViewAppImage(
                    imageUrl: order.candidates.first.imageUrl,
                    width: AppConstants.ContainerHeight_width,
                    height: AppConstants.ContainerHeight_width,
                    radius: AppConstants.ContainerHeight_width,
                  ),
                  Container(
                    padding: EdgeInsets.all(AppConstants.marginVerySmall1),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppStrings.CURRENTLY.tr(),
                        style: AppStyles.WhiteStyleWithBold800_Font16,
                      ),
                      Container(
                        padding: EdgeInsets.all(AppConstants.marginVerySmall),
                      ),
                      Text(
                        AppStrings.SHOPPING.tr(),
                        style: AppStyles.WhiteStyle_Font16,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        Visibility(
          child: Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(AppConstants.marginVerySmall),
                ),
                Text(
                  timeago.format(order.proposalDetails.time),
                  style: AppStyles.WhiteStyle_Font16,
                ),
              ],
            ),
          ),
          visible: true,
        ),
      ],
    );
  }

  String get _getOrderStatus {
    if (order.status == OrderPurchaseStatus.OrderDelivered) {
      return AppStrings.DELIVERED.tr();
    } else if (order.status == OrderPurchaseStatus.Finished) {
      return AppStrings.FINISHED.tr();
    } else if (order.status == OrderPurchaseStatus.Pending) {
      return AppStrings.PENDING.tr();
    } else {
      return AppStrings.ACTIVE.tr();
    }
  }
  String get statusString{

    if (order.status == OrderPurchaseStatus.Proposal) {
      return AppStrings.WAITING_FOR_OFFERS.tr();
    } else if (order.status == OrderPurchaseStatus.MoneyTransfer) {
      return AppStrings.PAYMENT_TRANSFER.tr();
    } else if (order.status == OrderPurchaseStatus.OrderAccepted) {
      return AppStrings.PURCHASE_IN_PROGRESS.tr();
    } else if (order.status == OrderPurchaseStatus.OrderRunning) {
      return AppStrings.DELIVERING_PURCHASE.tr();
    }else if (order.status == OrderPurchaseStatus.Pending) {
      return AppStrings.WAITING_FOR_OFFERS.tr();
    }else if (order.status == OrderPurchaseStatus.PriceCheck) {
      return AppStrings.PAYMENT_TRANSFER.tr();
    }else if (order.status == OrderPurchaseStatus.Finished) {
      return AppStrings.DELIVERING_PURCHASE.tr();
    }else if (order.status == OrderPurchaseStatus.OrderDelivered) {
      return AppStrings.DELIVERING_PURCHASE.tr();
    } else {
      return  AppStrings.WAITING_FOR_OFFERS.tr();
    }
  }

  String get statusSubtitle {
     if (order.status == OrderPurchaseStatus.MoneyTransfer) {
      return AppStrings.INITIATED_PENDING.tr();
    } else if (order.status == OrderPurchaseStatus.OrderAccepted) {
      return AppStrings.STARTED.tr()+': 12:55';
    } else if (order.status == OrderPurchaseStatus.OrderRunning) {
      return AppStrings.EXPECTED_DELIVERY.tr()+": 17:30";
    }else if (order.status == OrderPurchaseStatus.PriceCheck) {
      return AppStrings.CONFIRMED.tr();
    } else {
      return  '';
    }
  }


  IconData get_order_icon() {
    if (order.status == OrderPurchaseStatus.Proposal) {
      return StoreangelIcons.hourglass_full;
    } else if (order.status == OrderPurchaseStatus.MoneyTransfer) {
      return StoreangelIcons.credit_card_order_flow_icon_full;
    } else if (order.status == OrderPurchaseStatus.OrderAccepted) {
      return StoreangelIcons.shopping_cart_order_full;
    } else if (order.status == OrderPurchaseStatus.OrderRunning) {
      return StoreangelIcons.change_to_courier_profile_full;
    } else {
      return StoreangelIcons.hourglass_full;
    }
  }
}
