import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/mobileSize.dart';
import 'package:storeangelApp/core/models/chat_message.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_status.dart';
import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/chat_bottom_textfield_widget.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/custom_flexible_space_widget.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/courier_status/chat_message_list_widget.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/courier_status/courier_statusbox_widget.dart';

class CourierStatusScreen extends StatefulWidget {
  static const String routeName = 'courierStatusScreen';
  final CourierStatusScreenArgument argument;

  CourierStatusScreen({this.argument});

  @override
  _CourierStatusScreenState createState() => _CourierStatusScreenState();
}

class _CourierStatusScreenState extends State<CourierStatusScreen>  {

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
      body: BaseView<CourierStatusViewModel>(
        onModelReady: (courierStatusProvider) {
          courierStatusProvider.status = widget.argument.orderOrPurchases.status;
        },
        builder: (context, courierStatusViewModel, child) {
            return Stack(
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
                                floating: false,
                                pinned: true,
                                title: Text(
                                  widget.argument.orderOrPurchases.purchaseDetails.listName,
                                  style: AppStyles.BlackStyleWithBold800Font_24(context),
                                ),
                                leading: BackButton(
                                  color: Theme.of(context).iconTheme.color,
                                  onPressed: () {
                                    courierStatusViewModel.pushNamedAndRemoveUntil(LandingScreen.routeName);
                                  },
                                ),
                                centerTitle: true,
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(radius),
                                        bottomRight: Radius.circular(radius),),),
                                expandedHeight: SizeConfig.screenHeight * .16+ AppBar().preferredSize.height + 120+(SizeConfig.mobileSize==MobileSize.small?30:0),
                                flexibleSpace: FlexibleSpaceBar(
                                  stretchModes: [
                                    StretchMode.blurBackground,
                                    StretchMode.fadeTitle
                                  ],
                                  background: Padding(
                                    padding: EdgeInsets.only(top: AppBar().preferredSize.height),
                                    child: CustomFlexibleSpaceWidget(
                                     scrollController: _scrollController,
                                      child: CourierStatusBoxWidget(
                                        orderOrPurchases: widget.argument.orderOrPurchases,
                                        status: courierStatusViewModel.status,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              StreamBuilder<List<ChatMessage>>(
                                  stream: courierStatusViewModel.getMessages(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return SliverPadding(
                                        padding: EdgeInsets.only(top: SizeConfig.screenHeight * .01),
                                        sliver: ChatMessageListWidget(
                                          chatList: snapshot.data,
                                          prePaid: true,
                                          status: courierStatusViewModel.status,
                                          order: widget.argument.orderOrPurchases,
                                        ),
                                      );
                                    } else {
                                      return SliverToBoxAdapter(
                                        child: AppConstants.circulerProgressIndicator(),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                        ChatBottomTextFieldWidget(
                          focusNode: _textFieldNode,
                          controller: courierStatusViewModel.messageController,
                          onSubmit: () {
                            courierStatusViewModel.onSubmitMessage(UserModel(id: 'a'));
                            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
      ),
    );
  }
}

class CourierStatusScreenArgument {
  OrderOrPurchases orderOrPurchases;

  CourierStatusScreenArgument({
    this.orderOrPurchases,
  });
}
