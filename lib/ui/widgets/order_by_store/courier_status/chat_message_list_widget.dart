import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group_sliver/flutter_group_sliver.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/chat_message.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_chat_message_list_widget.dart';
import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:storeangelApp/ui/screens/order/afterwards/order_afterward_payment_method_screen.dart';
import 'package:storeangelApp/ui/screens/order_delivered_screen.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/clipper/chat_clipper.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_offers/courier_order_dialog.dart';
import 'package:storeangelApp/ui/widgets/orderDelivered/rating_dialog_widget.dart';

class ChatMessageListWidget extends StatefulWidget {
  final List<ChatMessage> chatList;
  final OrderPurchaseStatus status;
  final OrderOrPurchases order;
  final bool prePaid;
  final Function onPaymentPop;

  ChatMessageListWidget(
      {@required this.chatList,
      @required this.status,
      @required this.prePaid,
      @required this.order,
      this.onPaymentPop});

  @override
  _ChatMessageListWidgetState createState() => _ChatMessageListWidgetState();
}

class _ChatMessageListWidgetState extends State<ChatMessageListWidget> {
  Color chatBackgroundColor(int index) => widget.chatList[index].sendBy.id == 'a'
      ?  AppColors.ownTextMessageColor
      : AppColors.grayBackgroundColor;

  Color chatTextColor(int index) => widget.chatList[index].sendBy.id == 'a'
      ? AppColors.blackFontColor
      : AppColors.blackFontColor;

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatMessageListViewModel>(
      onModelReady: (chatMessageListViewModel)=>chatMessageListViewModel.initialized(),
      builder: (context, chatMessageListViewModel, child) {
        return SliverPadding(
          padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.04, right: SizeConfig.screenWidth * 0.04),
          sliver: SliverGroupBuilder(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppConstants.ContainerRoundCorner_Radius),
            ),
            child: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    if (widget.status == OrderPurchaseStatus.OrderRunning) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * .05, vertical: SizeConfig.screenWidth * .05),
                        child: ButtonWidget(
                          onPressed: () {
                            if (!widget.prePaid) {
                              chatMessageListViewModel.navigateToScreen(OrderAfterWardPaymentMethodScreen.routeName,
                                  arguments: widget.order, onPop: widget.onPaymentPop);
                            } else {
                              chatMessageListViewModel.navigateToScreen(OrderDeliveredScreen.routeName,
                                  arguments:
                                      OrderDeliveredScreenArgument(orderOrPurchases: widget.order, isPrePaid: true));
                            }
                          },
                          buttonText: widget.prePaid ? AppStrings.YOUR_RECEIPT.tr() : AppStrings.PAY_COURIER_NOW.tr(),
                          buttonColor: Theme.of(context).primaryColor,
                          textColor: AppColors.whiteColor,
                          fontSize: AppStyles.BlackStyleFontWeightSmall_24(context).fontSize,
                          radius: 10,
                        ),
                      );
                    } else if (widget.status == OrderPurchaseStatus.MoneyTransfer && !widget.prePaid) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * .05, vertical: SizeConfig.screenWidth * .05),
                        child: ButtonWidget(
                          onPressed: () {
                            MyUtils.showAppDialog(
                                context: context,
                                child: RatingDialogWidget(
                                  header: AppStrings.RATE_COURIER.tr(),
                                  rateObjectName: widget.order.candidates.first.name,
                                  onRatingUpdate: (val){},
                                  onPressOK: () {
                                    chatMessageListViewModel.navigateToScreen(LandingScreen.routeName);
                                  },
                                ));
                          },
                          buttonText: AppStrings.RATE_COURIER.tr(),

                          buttonColor: Theme.of(context).primaryColor,
                          textColor: AppColors.whiteColor,
                          radius: 10,
                          fontSize: AppStyles.BlackStyleFontWeightSmall_24(context).fontSize,
                        ),
                      );
                    } else if (widget.status == OrderPurchaseStatus.OrderPlaced && !widget.prePaid) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * .05, vertical: SizeConfig.screenWidth * .05),
                        child: ButtonWidget(
                          onPressed: () {
                            if(!chatMessageListViewModel.hasPayedBack)
                            MyUtils.showAppDialog(
                                context: context,
                                child: CustomDialog(
                                    title: AppStrings.PAY_BACK_MONEY_NEEDED.tr(),
                                    subTitle: AppStrings.PAY_BACK_MONEY_NEEDED_LONG.tr(),
                                    onPressOk: () async{
                                      await chatMessageListViewModel.navigateToScreen(OrderAfterWardPaymentMethodScreen.routeName,
                                          arguments: widget.order, onPop: widget.onPaymentPop);
                                      chatMessageListViewModel.navigatorPop();
                                      chatMessageListViewModel.setHasPayedBack = true;
                                    }));
                          },
                          buttonText: chatMessageListViewModel.hasPayedBack?AppStrings.COURIER_RECEIVED_PAYMENT.tr():AppStrings.PAY_BACK_MONEY_NEEDED.tr(),

                          buttonColor: Theme.of(context).primaryColor,
                          textColor: AppColors.whiteColor,
                          radius: 10,
                          fontSize: AppStyles.BlackStyleFontWeightSmall_24(context).fontSize,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }
                  if (widget.status == OrderPurchaseStatus.OrderRunning ||
                      (widget.status == OrderPurchaseStatus.MoneyTransfer && !widget.prePaid)) {
                    if (index >= 1) {
                      index = index - 1;
                    }
                  }
                  return Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.smallerVerticalPadding.top,
                        bottom:
                            SizeConfig.smallerVerticalPadding.bottom + (index == widget.chatList.length - 1 ? 5 : 0)),
                    child: Row(
                      mainAxisAlignment:
                          widget.chatList[index].sendBy.id == 'a' ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        ClipPath(
                          clipper: widget.chatList[index].sendBy.id == 'a' ? ChatRightClipper() : ChatLeftClipper(),
                          child: Container(
                            decoration: BoxDecoration(
                                color: chatBackgroundColor(index),
                                borderRadius: BorderRadius.only(
                                  topRight: widget.chatList[index].sendBy.id != 'a'
                                      ? Radius.circular(10)
                                      : Radius.circular(5),
                                  bottomRight: widget.chatList[index].sendBy.id != 'a'
                                      ? Radius.circular(10)
                                      : Radius.circular(0),
                                  topLeft: widget.chatList[index].sendBy.id == 'a'
                                      ? Radius.circular(10)
                                      : Radius.circular(5),
                                  bottomLeft: widget.chatList[index].sendBy.id == 'a'
                                      ? Radius.circular(10)
                                      : Radius.circular(0),
                                )),
                            width: SizeConfig.screenWidth * .75,
                            child: Padding(
                              padding: SizeConfig.innerpadding.copyWith(
                                  left: widget.chatList[index].sendBy.id != 'a'
                                      ? SizeConfig.innerpadding.left + 30
                                      : SizeConfig.innerpadding.left,
                                  right: widget.chatList[index].sendBy.id == 'a'
                                      ? SizeConfig.innerpadding.right + 30
                                      : SizeConfig.innerpadding.right),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.chatList[index].message,
                                    style: AppStyles.BlackStyleFontWeightSmall_24(context)
                                        .copyWith(color: chatTextColor(index)),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        AppConstants.messageTime(widget.chatList[index].createdAt),
                                        style:
                                            AppStyles.GrayStyle_Font10(context).copyWith(color: chatTextColor(index)),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: chatMessageListViewModel.chatListLength(widget.status, widget.chatList.length, widget.prePaid),
              ),
            ),
          ),
        );
      },
    );
  }
}
