import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/chat_message.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_chat_viewmodel.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/chat_bottom_textfield_widget.dart';
import 'package:storeangelApp/ui/shared/chat_messge_item_widget.dart';

class CourierOrderChatWidget extends StatelessWidget {
  final FocusNode _textFieldNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BaseView<CourierOrderChatViewModel>(
      builder: (context,courierOrderChatViewModel,child){
        return Padding(
          padding: SizeConfig.sidepadding,
          child: AppShapeItem(
            child: Container(
              color: Theme.of(context).toggleableActiveColor,
              child: Stack(
                children: [
                  StreamBuilder<List<ChatMessage>>(
                    stream: courierOrderChatViewModel.getMessages(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(itemCount: snapshot.data.length,itemBuilder: (context,int index){
                          return Padding(
                            padding: SizeConfig.sidepadding.copyWith(

                                top: SizeConfig.smallerVerticalPadding.top,
                                bottom:
                                SizeConfig.smallerVerticalPadding.bottom + (index == snapshot.data.length - 1 ? 5 : 0)),
                            child: ChatMessageItemWidget(message: snapshot.data[index],),
                          );

                        });

                      }
                      return AppConstants.circulerProgressIndicator();

                    },
                  ),
                  Positioned.fill(child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ChatBottomTextFieldWidget(
                      focusNode: _textFieldNode,
                      controller: TextEditingController(),
                      onSubmit: () {

                      },
                    ),
                  ))
                ],
              ),
            ),

          ),
        );
      },
    );
  }
}
