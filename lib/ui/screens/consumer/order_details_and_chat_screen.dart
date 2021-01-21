import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_order_details_and_chat.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/widgets/order_details_and_chat/consumer_chat_widget.dart';
import 'package:storeangelApp/ui/widgets/order_details_and_chat/consumer_order_details_widget.dart';
import 'package:storeangelApp/ui/widgets/order_details_and_chat/order_chat_order_details_widget.dart';
import 'package:storeangelApp/ui/widgets/order_details_and_chat/order_details_and_chat_tab_widget.dart';

class OrderDetailsAndChatScreenArguments{
  OrderOrPurchases orPurchases;
  CourierCandidate candidate;
  OrderDetailsAndChatScreenArguments({this.candidate,this.orPurchases});
}


class  OrderDetailsAndChatScreen extends StatelessWidget {
  static const String routeName = 'orderDetailsAndChatScreen';
  final  OrderDetailsAndChatScreenArguments arguments;
  OrderDetailsAndChatScreen({this.arguments});


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BaseView<OrderDetailsAndChatViewModel>(
        builder: (context,orderDetailsAndChatViewModel,child){
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppHeader(
                  height: SizeConfig.smallHeaderSize,
                  isBack: true,
                  title: AppStrings.YOUR_MISSION.tr(),
                ),
              ),
              SizeConfig.verticalSliverMediumSpace(),

              OrderChatOrderDetailsWidget(
                candidate: arguments.candidate,
                orPurchases: arguments.orPurchases,
                additionChange: 0,

              ),
              SizeConfig.verticalSliverMediumSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: OrderDetailsAndChatTabWidget( value: orderDetailsAndChatViewModel.isChatTab,
                      onChanged: (bool value) {
                        orderDetailsAndChatViewModel.onChangeTab(value);
                      },),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              orderDetailsAndChatViewModel.isChatTab?ConsumerOrderChatWidget():ConsumerOrderDetailsWidget(orPurchases: arguments.orPurchases,
              candidate: arguments.candidate,additionalAmount: 0,),

            ],
          );
        },
      ),
    );
  }
}
