//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:storeangelApp/core/consts/appConstants.dart';
//import 'package:storeangelApp/core/consts/appString.dart';
//import 'package:storeangelApp/core/consts/assetsPath.dart';
//import 'package:storeangelApp/core/consts/sizeConfig.dart';
//import 'package:storeangelApp/core/consts/text_styles.dart';
//import 'package:easy_localization/easy_localization.dart';
//import 'package:storeangelApp/core/enums/courier_order_status.dart';
//import 'package:storeangelApp/core/models/order.dart';
//import 'package:storeangelApp/core/services/statusbar_service.dart';
//import 'package:storeangelApp/core/viewmodel/viewmodel_current_order_screen.dart';
//import 'package:storeangelApp/ui/shared/base_model.dart';
//import 'package:storeangelApp/ui/shared/base_view.dart';
//import 'package:storeangelApp/ui/shared/view_app_Image.dart';
//import 'package:storeangelApp/ui/widgets/courier/courier_order_status_card.dart';
//import 'package:storeangelApp/ui/widgets/courier/current_order_bottom_widget.dart';
//
//class CurrentOrderScreen extends StatefulWidget {
//  final OrderOrPurchases order;
//  static const String routeName = 'currentOrderScreen';
//
//  CurrentOrderScreen({this.order});
//
//  @override
//  _CurrentOrderScreenState createState() => _CurrentOrderScreenState();
//}
//
//class _CurrentOrderScreenState extends State<CurrentOrderScreen> {
//  var radius = 35.0;
//  ScrollController _scrollController = ScrollController();
//
//  @override
//  void initState() {
//    super.initState();
//
//    _scrollController.addListener(() {
//      if (_isAppBarExpanded) {
//        setState(() {
//          radius = 0.0;
//        });
//      } else {
//        setState(() {
//          radius = 35.0;
//        });
//      }
//    });
//  }
//
//  bool get _isAppBarExpanded {
//    return _scrollController.hasClients && _scrollController.offset > (200 - kToolbarHeight);
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _scrollController.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    StatusBarService.changeStatusBarColor(StatusBarType.Light, context);
//
//    return BaseView<CurrentOrderViewModel>(
//      builder: (context, model, child) {
//        return Scaffold(
//          body: model.state == ViewState.Busy ? AppConstants.circulerProgressIndicator() : _body(context, model),
//          bottomNavigationBar: _bottomNavigationBar(context, model),
//        );
//      },
//    );
//  }
//
//  Widget _body(BuildContext context, CurrentOrderViewModel model) => CustomScrollView(
//        controller: _scrollController,
//        slivers: [
//          SliverAppBar(
//            backgroundColor: Theme.of(context).cardColor,
//            pinned: true,
//            floating: false,
//            leading: Container(),
//            centerTitle: true,
//            actions: [
//              _isAppBarExpanded
//                  ? Container()
//                  : IconButton(
//                      icon: SizedBox(
//                          height: SizeConfig.iconSize,
//                          width: SizeConfig.iconSize,
//                          child: Image.asset(
//                            AssetsPath.closeIcon,
//                            color: Theme.of(context).focusColor,
//                          )),
//                      onPressed: () {
//                       model.navigatorPop();
//                      },
//                    ),
//            ],
//            shape: ContinuousRectangleBorder(
//                borderRadius:
//                    BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))),
//            flexibleSpace: FlexibleSpaceBar(
//              title: Container(
//                height: 42,
//                width: SizeConfig.screenWidth,
//                padding: EdgeInsets.only(top: 12, right: 36),
//                child: Center(
//                  child: ListView.builder(
//                      shrinkWrap: true,
//                      scrollDirection: Axis.horizontal,
//                      itemCount: 3,
//                      itemBuilder: (context, int index) {
//                        return Padding(
//                          padding: SizeConfig.innersidepadding,
//                          child: CircleAvatar(
//                            radius: 15,
//                            backgroundImage: NetworkImage(widget.order.clientDetails.imageUrl),
//                          ),
//                        );
//                      }),
//                ),
//              ),
//              background: Column(
//                children: [
//                  SizeConfig.verticalSpace(SizeConfig.screenHeight * .07),
//                  Text(
//                    AppStrings.CURRENT_ORDERS.tr(),
//                    style: AppStyles.BlackStyleWithBold800Font_24(context),
//                  ),
//                ],
//              ),
//            ),
//            expandedHeight: 127,
//          ),
//          SliverPadding(
//            padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .02),
//            sliver: SliverList(
//              delegate: SliverChildListDelegate([
//                SizeConfig.CVerticalSpaceSmallMediumC12(),
//                _statusWidget(model.courierOrderStatus),
//                CurrentOrderBottomWidget(
//                  model: model,
//                  order: widget.order,
//                ),
//              ]),
//            ),
//          ),
//        ],
//      );
//
//  Widget _bottomNavigationBar(BuildContext context, CurrentOrderViewModel model) => Container(
//        color: Theme.of(context).cardColor,
//        child: Row(
//          children: [
//            statusTabIconWidget(model.courierOrderStatus, model),
//            Expanded(
//              child: Container(
//                height: 70,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    Image.asset(AssetsPath.call),
//                    SizeConfig.verticalSpaceSmall(),
//                    Text(
//                      AppStrings.CALL.tr(),
//                      style: AppStyles.BlackStyleFont_16(context),
//                    )
//                  ],
//                ),
//              ),
//            ),
//            Expanded(
//              child: Container(
//                height: 70,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    ViewAppImage(
//                      height: 30,
//                      width: 30,
//                      radius: 30,
//                      imageUrl: widget.order.candidate.imageUrl,
//                    ),
//                    SizeConfig.verticalSpaceSmall(),
//                    Text(
//                      AppStrings.DETAILS.tr(),
//                      style: AppStyles.BlackStyleFont_16(context),
//                    )
//                  ],
//                ),
//              ),
//            )
//          ],
//        ),
//      );
//
//  Widget statusTabIconWidget(CourierOrderStatus status, CurrentOrderViewModel model) {
//    if (status == CourierOrderStatus.GOTOSTORE) {
//      return InkWell(
//        child: Container(
//          height: 70,
//          color: Theme.of(context).primaryColor,
//          width: SizeConfig.screenWidth * .5,
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              Image.asset(AssetsPath.home),
//              SizeConfig.verticalSpaceSmall(),
//              Text(
//                AppStrings.I_AM_IN_THE_STORE.tr(),
//                style: AppStyles.WhiteStyle_Font16,
//              )
//            ],
//          ),
//        ),
//        onTap: () {
//          model.updateStatus(CourierOrderStatus.STARTSHOPPING);
//        },
//      );
//    } else if (status == CourierOrderStatus.STARTSHOPPING) {
//      return InkWell(
//        child: Container(
//          height: 70,
//          color: Theme.of(context).buttonColor,
//          width: SizeConfig.screenWidth * .5,
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              Image.asset(AssetsPath.green_tick),
//              SizeConfig.verticalSpaceSmall(),
//              Text(
//                AppStrings.I_AM_DONE.tr(),
//                style: AppStyles.BlackStyleFont_20(context),
//              )
//            ],
//          ),
//        ),
//        onTap: () {
//          model.updateStatus(CourierOrderStatus.SHOPPINGDONE);
//        },
//      );
//    } else if (status == CourierOrderStatus.SHOPPINGDONE) {
//      return InkWell(
//        child: Container(
//          height: 70,
//          color: Theme.of(context).primaryColor,
//          width: SizeConfig.screenWidth * .5,
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              Image.asset(AssetsPath.white_tick),
//              SizeConfig.verticalSpaceSmall(),
//              Text(
//                AppStrings.I_AM_DONE.tr(),
//                style: AppStyles.WhiteStyle_Font16,
//              )
//            ],
//          ),
//        ),
//        onTap: () {
//          model.updateStatus(CourierOrderStatus.BRING_ITEMS);
//        },
//      );
//    } else if (status == CourierOrderStatus.BRING_ITEMS) {
//      return InkWell(
//        child: Container(
//          height: 70,
//          color: Theme.of(context).buttonColor,
//          width: SizeConfig.screenWidth * .5,
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              Image.asset(AssetsPath.shopingGreenTabbaricon),
//              SizeConfig.verticalSpaceSmall(),
//              Text(
//                AppStrings.I_DELIVERED_THE_ITEMS.tr(),
//                style: AppStyles.BlackStyleFont_20(context),
//              )
//            ],
//          ),
//        ),
//        onTap: () {
//          model.updateStatus(CourierOrderStatus.DELIVERED);
//        },
//      );
//    } else if (status == CourierOrderStatus.DELIVERED) {
//      return InkWell(
//        child: Container(
//          height: 70,
//          color: Theme.of(context).primaryColor,
//          width: SizeConfig.screenWidth * .5,
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              Image.asset(AssetsPath.white_shopping_tabicon),
//              SizeConfig.verticalSpaceSmall(),
//              Text(
//                AppStrings.I_DELIVERED_THE_ITEMS.tr(),
//                style: AppStyles.WhiteStyle_Font20,
//              )
//            ],
//          ),
//        ),
//        onTap: () {
//          model.navigateReplaceToScreen(CourierOrderDeliveredScreen.routeName,arguments: widget.order);
//        },
//      );
//    }else{
//      return Container();
//    }
//  }
//
//  Widget _statusWidget(CourierOrderStatus courierOrderStatus) {
//    if (courierOrderStatus == CourierOrderStatus.GOTOSTORE) {
//      return CourierOrderStatusCard(
//        statusImage: AssetsPath.ongoing,
//        title: AppStrings.PLEASE_GO_TO_THE_STORE.tr(),
//        subtitle: AppStrings.ONCE_YOU_ARE_THERE_PLEASE_CHANGE_STATUS_SO_THE_CLIENT_IS_AWARE.tr(),
//      );
//    } else if (courierOrderStatus == CourierOrderStatus.STARTSHOPPING ||
//        courierOrderStatus == CourierOrderStatus.SHOPPINGDONE) {
//      return CourierOrderStatusCard(
//        statusImage: AssetsPath.shopping,
//        title: AppStrings.START_SHOPPING.tr(),
//        subtitle: AppStrings.DONT_HESITATE_TO_CALL_CUSTOMER_IN_CASE_YOU_HAVE_ANY_ISSUES.tr(),
//      );
//    } else if (courierOrderStatus == CourierOrderStatus.BRING_ITEMS ||
//        courierOrderStatus == CourierOrderStatus.DELIVERED) {
//      return CourierOrderStatusCard(
//        statusImage: AssetsPath.medium_angel_store,
//        title: AppStrings.BRING_ITEMS_AND_RECEIPT_TO_THE_CUSTOMER.tr(),
//        subtitle: AppStrings.TO_FINISH_THE_ORDER_PLEASE_TAKE_TWO_PROOF_PHOTOS_OF_THE_RECEIPT_AND_DELIVERED_ITEMS.tr(),
//      );
//    } else {
//      return Container();
//    }
//  }
//}
