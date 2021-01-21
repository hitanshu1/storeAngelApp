import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_delivered_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_current_order_tab.dart';
import 'package:storeangelApp/ui/screens/items/common_item_details_screen.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/stepback_dialog.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_action_button.dart';
import 'package:storeangelApp/ui/widgets/courier/currentOrderDelivered/courier_current_status_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/currentOrderDelivered/courier_delivering_order_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/currentOrderDelivered/courier_price_check_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/currentOrderDelivered/current_Order_delivery_middle_widget.dart';
import 'package:storeangelApp/ui/widgets/items/list_item_view_widget.dart';
import 'package:storeangelApp/ui/widgets/watchlist/watchlist_last_list_item.dart';

class CourierCurrentOrderTabScreen extends StatefulWidget {
  final OrderOrPurchases order;
  final isExpanded;

  CourierCurrentOrderTabScreen({this.order, this.isExpanded});

  @override
  _CourierCurrentOrderTabScreenState createState() => _CourierCurrentOrderTabScreenState();
}

class _CourierCurrentOrderTabScreenState extends State<CourierCurrentOrderTabScreen> {
  ScrollController _scrollController = ScrollController();
  var radius = SizeConfig.radiusOfSliverAppbar;

  bool get _isAppBarExpanded {
    return _scrollController.hasClients && _scrollController.offset > (200 - kToolbarHeight);
  }

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

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Light, context);
    return BaseView<CourierCurrentOrderTabViewModel>(
      onModelReady: (courierCurrentOrderTabViewModel) => courierCurrentOrderTabViewModel.initializeData(widget.order),
      builder: (context, courierCurrentOrderTabViewModel, child) {
        return Consumer<CourierOrderDeliveredViewModel>(
          builder: (context, courierOrderDeliveredViewModel, child) {
            //for initializing the scrollController in the parent viewModel
            courierOrderDeliveredViewModel.scrollController = _scrollController;

            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                CustomSliverAppBar(
                  backgroundColor: Theme.of(context).cardColor,
                  pinned: true,
                  floating: false,
                  title: Text(
                    widget.order.storeDetails.name ?? '',
                    style: AppStyles.BlackStyleWithBold800Font_24(context),
                  ),
                  leading: BackButton(
                    color: Theme.of(context).iconTheme.color,
                    onPressed: () {
                      courierCurrentOrderTabViewModel.navigatorPop(widget.order);
                    },
                  ),
                  centerTitle: true,
                  actions: [
                    courierCurrentOrderTabViewModel.deleteVisible
                        ? IconButton(
                            icon: Icon(
                              StoreangelIcons.delete_icon,
                              color: Theme.of(context).focusColor,
                              size: SizeConfig.iconSize,
                            ),
                            onPressed: () {},
                          )
                        : Container(),
                    courierCurrentOrderTabViewModel.shareVisible
                        ? IconButton(
                            icon: SizedBox(
                                height: SizeConfig.iconSize,
                                width: SizeConfig.iconSize,
                                child: Image.asset(
                                  AssetsPath.shareIcon,
                                  color: Theme.of(context).focusColor,
                                )),
                            onPressed: () {},
                          )
                        : Container(),
                  ],
                  shape: ContinuousRectangleBorder(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Column(
                      children: [
                        SizeConfig.verticalSpace(AppBar().preferredSize.height),
                        Spacer(),
                        Container(
                          height: SizeConfig.screenWidth * .15 + 18,
                          width: SizeConfig.screenWidth,
                          padding: EdgeInsets.only(top: 12),
                          child: Center(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: courierCurrentOrderTabViewModel.clientList.length,
                                itemBuilder: (context, int index) {
                                  return Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: InkWell(
                                          child: CircleAvatar(
                                            radius: SizeConfig.screenWidth * .065,
                                            backgroundImage: NetworkImage(
                                                courierCurrentOrderTabViewModel.clientList[index].imageUrl),
                                          ),
                                          onTap: () {
                                            courierCurrentOrderTabViewModel.onSelectCandidate(index);
                                          },
                                        ),
                                      ),
                                      courierCurrentOrderTabViewModel.selectedClients
                                              .contains(courierCurrentOrderTabViewModel.clientList[index])
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
                        courierCurrentOrderTabViewModel.enableSelect
                            ? Container(
                                padding: EdgeInsets.only(top: SizeConfig.screenHeight * .007),
                                child: courierCurrentOrderTabViewModel.selectedValues
                                    ? InkWell(
                                        child: Text(
                                          AppStrings.UN_SELECT.tr(),
                                          style: AppStyles.GrayStyle_Font16(context)
                                              .copyWith(fontSize: AppConstants.fontSizeSmall),
                                        ),
                                        onTap: () {
                                          courierCurrentOrderTabViewModel.onUnSelectAll();
                                        },
                                      )
                                    : InkWell(
                                        child: Text(
                                          AppStrings.SELECT_ALL.tr(),
                                          style: AppStyles.GreenStyleWith_Font16(context)
                                              .copyWith(fontSize: AppConstants.fontSizeSmall),
                                        ),
                                        onTap: () {
                                          courierCurrentOrderTabViewModel.onSelectAll();
                                        },
                                      ),
                              )
                            : Container(),
                        Spacer()
                      ],
                    ),
                  ),
                  expandedHeight: SizeConfig.adaptiveHeight(SizeConfig.screenHeight * .185),
                ),
                _isProposalOrMoneyTransferViewWidget(courierCurrentOrderTabViewModel),
                _isOrderAcceptedWidget(courierCurrentOrderTabViewModel),
                _isPriceCheckViewWidget(courierCurrentOrderTabViewModel),
                _isOrderRunningViewWidget(courierCurrentOrderTabViewModel),
              ],
            );
          },
        );
      },
    );
  }

  Widget _isProposalOrMoneyTransferViewWidget(CourierCurrentOrderTabViewModel courierCurrentOrderTabViewModel) =>
      courierCurrentOrderTabViewModel.isProposalOrMoneyTransferView
          ? SliverPadding(
              padding: EdgeInsets.only(
                  bottom: widget.order.status == OrderPurchaseStatus.Proposal
                      ? SizeConfig.screenHeight * .15
                      : SizeConfig.screenHeight * .02),
              sliver: SliverToBoxAdapter(
                child: CurrentOrderDeliveryMiddleWidget(
                  order: widget.order,
                ),
              ),
            )
          : SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(SizeConfig.sidepadding.left, SizeConfig.screenHeight * .02,
                    SizeConfig.sidepadding.right, SizeConfig.screenHeight * .02),
                child: CourierCurrentStatusWidget(order: widget.order),
              ),
            );

  Widget _isOrderAcceptedWidget(CourierCurrentOrderTabViewModel courierCurrentOrderTabViewModel) =>
      courierCurrentOrderTabViewModel.isOrderAccepted
          ? SliverPadding(
              padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .02),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                if (index == courierCurrentOrderTabViewModel.products.length)
                  return WatchlistLastListItem(
                    onTap: () {
                      courierCurrentOrderTabViewModel.navigateToScreen(CommonItemsDetailsScreen.routeName, context,
                          arguments: CommonItemsDetailsArgument(
                              products: courierCurrentOrderTabViewModel.products,
                              onClickPush: () async{
                                courierCurrentOrderTabViewModel.navigatorPop(null);
                                courierCurrentOrderTabViewModel
                                        .updateOrderStatus(OrderPurchaseStatus.PriceCheck);
                                _scrollController.jumpTo(0);
                              },
                              currentIndex: index));
                    },
                  );
                if (index == courierCurrentOrderTabViewModel.products.length + 1)
                  return Consumer<CourierOrderDeliveredViewModel>(
                    builder: (context, courierOrderDeliveredViewModel, child) => Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.screenHeight * .02,
                          left: SizeConfig.sidepadding.left,
                          right: SizeConfig.sidepadding.right),
                      child: CourierOrderActionButton(
                          firstButtonText: AppStrings.UNDO.tr(),
                          firstButtonTap: () {
                            MyUtils.showAppDialog(
                                context: context,
                                child: Builder(
                                  builder: (context) => StepBackDialog(
                                    onPressOk: () {
                                      Navigator.of(context, rootNavigator: true).pop();
                                      courierCurrentOrderTabViewModel.isProposalOrMoneyTransferView
                                          ? courierOrderDeliveredViewModel
                                              .updateOrderStatus(OrderPurchaseStatus.Proposal)
                                          : courierOrderDeliveredViewModel
                                              .updateOrderStatus(OrderPurchaseStatus.MoneyTransfer);
                                    },
                                  ),
                                ));
                          },
                          secondButtonText: AppStrings.FINISHED_PURCHASE.tr(),
                          secondButtonTap: () {
                            courierOrderDeliveredViewModel.updateOrderStatus(OrderPurchaseStatus.PriceCheck);
                          }),
                    ),
                  );
                return Consumer<CourierOrderDeliveredViewModel>(
                  builder: (context, courierOrderDeliveredViewModel, child) => InkWell(
                    onTap: () {
                      courierCurrentOrderTabViewModel.navigateToScreen(CommonItemsDetailsScreen.routeName, context,
                          arguments: CommonItemsDetailsArgument(
                              products: courierCurrentOrderTabViewModel.order.purchaseDetails.products,
                              currentIndex: index,
                              courierView: true,
                              hasLastPage: true,
                              onClickPush: () {
                                courierCurrentOrderTabViewModel.navigatorPop(widget.order);
                                courierOrderDeliveredViewModel.updateOrderStatus(OrderPurchaseStatus.PriceCheck);
                              }));
                    },
                    child: ListItemViewWidget(
                      enableBorder: index != 0,
                      product: courierCurrentOrderTabViewModel.products[index],
                    ),
                  ),
                );
              }, childCount: courierCurrentOrderTabViewModel.products.length + 2)),
            )
          : SliverToBoxAdapter();

  Widget _isPriceCheckViewWidget(CourierCurrentOrderTabViewModel courierCurrentOrderTabViewModel) =>
      courierCurrentOrderTabViewModel.isPriceCheckView
          ? CourierPriceCheckWidget(
              model: courierCurrentOrderTabViewModel,
            )
          : SliverToBoxAdapter();

  Widget _isOrderRunningViewWidget(CourierCurrentOrderTabViewModel courierCurrentOrderTabViewModel) =>
      courierCurrentOrderTabViewModel.isOrderRunningView
          ? CourierDeliveringOrderWidget(
              model: courierCurrentOrderTabViewModel,
            )
          : SliverToBoxAdapter();
}
