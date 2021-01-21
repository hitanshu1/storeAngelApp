import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/chat_message.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/courier_chat_tab_viewmodel.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/chat_bottom_textfield_widget.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/courier_status/chat_message_list_widget.dart';

class CourierChatTabScreen extends StatefulWidget {
  final OrderOrPurchases order;

  CourierChatTabScreen({this.order});

  @override
  _CourierChatTabScreenState createState() => _CourierChatTabScreenState();
}

class _CourierChatTabScreenState extends State<CourierChatTabScreen> {
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
    return BaseView<CourierChatTabViewModel>(
      onModelReady: (model) => model.initializeData(widget.order),
      builder: (context, model, child) {
        if (model.state == ViewState.Busy) {
          return AppConstants.circulerProgressIndicator();
        } else {
          return Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  CustomSliverAppBar(
                    title: Text(
                      model.order.storeDetails.name,
                      style: AppStyles.BlackStyleWithBold800Font_24(context),
                    ),
                    elevation: 10,
                    backgroundColor: Theme.of(context).cardColor,
                    pinned: true,
                    floating: false,
                    leading: BackButton(
                      color: Theme.of(context).iconTheme.color,
                    ),
                    centerTitle: true,
                    actions: [
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
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))),
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
                                        model.selectedClient.id == model.order.clientlist[index].id
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
                          Spacer()
                        ],
                      ),
                    ),
                    expandedHeight: SizeConfig.adaptiveHeight(SizeConfig.screenHeight * .185),
                  ),
                  StreamBuilder<List<ChatMessage>>(
                      stream: model.getMessages(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SliverPadding(
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.screenHeight * .09, top: SizeConfig.VerticalSpaceMedium),
                            sliver: ChatMessageListWidget(
                              chatList: snapshot.data,
                              order: model.order,
                              prePaid: true,
                              status: model.order.status,
                            ),
                          );
                        } else {
                          return SliverList(
                              delegate: SliverChildListDelegate([AppConstants.circulerProgressIndicator()]));
                        }
                      }),
                ],
              ),
              Positioned.fill(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: ChatBottomTextFieldWidget(
                  focusNode: _textFieldNode,
                  controller: model.messageController,
                  onSubmit: () {
                    model.onSubmitMessage(UserModel(id: 'a'));
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  },
                ),
              )),
            ],
          );
        }
      },
    );
  }
}
