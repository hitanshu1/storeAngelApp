import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/chat_message.dart';
class ChatMessageItemWidget extends StatelessWidget {
  final ChatMessage message;
  ChatMessageItemWidget({this.message});
  Color get chatBackgroundColor => message.sendBy.id == 'a'
      ?  AppColors.ownTextMessageColor
      : AppColors.whiteColor;

  Color get chatTextColor=> message.sendBy.id == 'a'
      ? AppColors.whiteColor
      : AppColors.blackFontColor;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment:
      message.sendBy.id == 'a' ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: chatBackgroundColor,
              borderRadius: message.sendBy.id == 'a'?SizeConfig.appItemReverseShapeRadius:
              SizeConfig.appItemShapeRadius),
          width: SizeConfig.screenWidth * .75,
          child: Padding(
            padding: SizeConfig.innerpadding.copyWith(
                left: message.sendBy.id != 'a'
                    ? SizeConfig.innerpadding.left + 30
                    : SizeConfig.innerpadding.left,
                right: message.sendBy.id == 'a'
                    ? SizeConfig.innerpadding.right + 30
                    : SizeConfig.innerpadding.right),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.message,
                  style: AppStyles.BlackStyleFontWeightSmall_24(context)
                      .copyWith(color: chatTextColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      AppConstants.messageTime(message.createdAt),
                      style:
                      AppStyles.GrayStyle_Font10(context).copyWith(color: chatTextColor),
                      textAlign: TextAlign.right,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
