
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/mobileSize.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/chat_message.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_payment_afterwards.dart';
import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/chat_bottom_textfield_widget.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/custom_flexible_space_widget.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/courier_status/chat_message_list_widget.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/courier_status/courier_statusbox_widget.dart';

import '../../order_delivered_screen.dart';

class OrderPaymentAfterWardsScreen extends StatefulWidget {
  static const String routeName = 'orderPaymentAfterWardsScreen';
  final OrderOrPurchases order;

  OrderPaymentAfterWardsScreen({this.order});

  @override
  _OrderPaymentAfterWardsScreenState createState() => _OrderPaymentAfterWardsScreenState();
}

class _OrderPaymentAfterWardsScreenState extends State<OrderPaymentAfterWardsScreen> {
  var radius = SizeConfig.radiusOfSliverAppbar;

  ScrollController _scrollController = ScrollController();
  FocusNode _textFieldNode = FocusNode();

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

    _textFieldNode.addListener(() {
      if (!_textFieldNode.hasPrimaryFocus) {
        _textFieldNode.unfocus();
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
    return Scaffold(
      body: BaseView<OrderPaymentAfterWardViewModel>(
        onModelReady: (model) => model.initializeData(widget.order),
        builder: (context, orderPaymentAfterWardsViewModel, child) {
          return WillPopScope(
            onWillPop: ()async{
              orderPaymentAfterWardsViewModel.pushNamedAndRemoveUntil(LandingScreen.routeName);
              return true;
            },
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: SizeConfig.screenHeight*.05,
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
                Positioned.fill(
                  child: SafeArea(
                    top: true,
                    bottom: true,
                    right: false,
                    left: false,
                    child: Column(
                      children: [
                        Expanded(
                          child: CustomScrollView(
                            controller: _scrollController,
                            slivers: [
                              CustomSliverAppBar(
                                backgroundColor: Theme.of(context).cardColor,
                                pinned: true,
                                floating: false,
                                title: Text(
                                  widget.order.purchaseDetails.listName,
                                  style: AppStyles.BlackStyleWithBold800Font_24(context),
                                ),
                                leading: BackButton(
                                  color: Theme.of(context).iconTheme.color,
                                  onPressed: () {
                                    orderPaymentAfterWardsViewModel.pushNamedAndRemoveUntil(LandingScreen.routeName);
                                  },
                                ),
                                centerTitle: true,
                                actions: [
                                  orderPaymentAfterWardsViewModel.status == OrderPurchaseStatus.OrderPlaced ||
                                          orderPaymentAfterWardsViewModel.status == OrderPurchaseStatus.MoneyTransfer
                                      ? InkWell(
                                          child: Padding(
                                            padding: SizeConfig.sidepadding,
                                            child: SizedBox(
                                                height: SizeConfig.iconSize,
                                                child: Image.asset(
                                                  AssetsPath.bill,
                                                  color: Theme.of(context).primaryColor,
                                                )),
                                          ),
                                          onTap: () {
                                            orderPaymentAfterWardsViewModel.navigateToScreen(
                                                OrderDeliveredScreen.routeName, context,
                                                arguments: OrderDeliveredScreenArgument(
                                                    orderOrPurchases: widget.order, isPrePaid: false));
                                          })
                                      : Container()
                                ],
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))),
                                expandedHeight: SizeConfig.screenHeight * .16 +
                                    AppBar().preferredSize.height +
                                    120 +
                                    (SizeConfig.mobileSize == MobileSize.small ? 30 : 0),
                                flexibleSpace: FlexibleSpaceBar(
                                  background: Padding(
                                    padding: EdgeInsets.only(top: AppBar().preferredSize.height),
                                    child: CustomFlexibleSpaceWidget(
                                      scrollController: _scrollController,
                                      child: CourierStatusBoxWidget(
                                        orderOrPurchases: widget.order,
                                        status: orderPaymentAfterWardsViewModel.status,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              StreamBuilder<List<ChatMessage>>(
                                  stream: orderPaymentAfterWardsViewModel.getMessages(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return SliverPadding(
                                        padding: EdgeInsets.only(top: SizeConfig.screenHeight * .01),
                                        sliver: ChatMessageListWidget(
                                          chatList: snapshot.data,
                                          status: orderPaymentAfterWardsViewModel.status,
                                          prePaid: false,
                                          order: orderPaymentAfterWardsViewModel.order,
                                          onPaymentPop: () {
                                            orderPaymentAfterWardsViewModel.onUpdateStatus(OrderPurchaseStatus.OrderPlaced);
                                          },
                                        ),
                                      );
                                    } else {
                                      return SliverToBoxAdapter(
                                        child: AppConstants.circulerProgressIndicator(),
                                      );
                                    }
                                  })
                            ],
                          ),
                        ),
                        ChatBottomTextFieldWidget(
                          focusNode: _textFieldNode,
                          controller: orderPaymentAfterWardsViewModel.messageController,
                          onSubmit: () {
                            orderPaymentAfterWardsViewModel.onSubmitMessage(UserModel(id: 'a'));
                            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
