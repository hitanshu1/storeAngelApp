import 'package:flutter/material.dart';
import 'package:flutter_group_sliver/flutter_group_sliver.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/chat_message.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_chat_viewmodel.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/chat_bottom_textfield_widget.dart';
import 'package:storeangelApp/ui/shared/chat_messge_item_widget.dart';

class   ConsumerOrderChatWidget extends StatelessWidget {
  final FocusNode _textFieldNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BaseView<CourierOrderChatViewModel>(
      builder: (context,courierOrderChatViewModel,child){

        return SliverPadding(padding:  SizeConfig.padding,
          sliver: SliverGroupBuilder(
            decoration: BoxDecoration(
              color: Theme.of(context).toggleableActiveColor,
              borderRadius: SizeConfig.appItemShapeRadius,
            ),
            child:
            MultiSliver(
              children: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: SizeConfig.screenHeight*.38,
                    child: StreamBuilder<List<ChatMessage>>(
                      stream: courierOrderChatViewModel.getMessages(),
                      builder: (context,snapshot){
                       if(snapshot.hasData){
                         return ListView.builder(
                             itemCount: snapshot.data.length,
                             itemBuilder: (context,int index){
                               return Padding(
                                 padding: SizeConfig.sidepadding.copyWith(

                                     top: SizeConfig.smallerVerticalPadding.top,
                                     bottom:
                                     SizeConfig.smallerVerticalPadding.bottom + (index == snapshot.data.length-1 ? 5 : 0)),
                                 child: ChatMessageItemWidget(message: snapshot.data[index],),
                               );
                             });
                       }else{
                         return AppConstants.circulerProgressIndicator();
                       }
                      },
                    ),
                  ),
                ),


                SliverToBoxAdapter(
                  child: ChatBottomTextFieldWidget(
                    focusNode: _textFieldNode,
                    controller: TextEditingController(),
                    onSubmit: () {

                    },
                  ),
                )
              ],
            ),

          ),
        );

      },
    );
  }
}