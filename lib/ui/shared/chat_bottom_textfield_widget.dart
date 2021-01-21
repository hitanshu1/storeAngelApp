import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

import 'clipper/chat_clipper.dart';

class ChatBottomTextFieldWidget extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final Function onSubmit;

  ChatBottomTextFieldWidget({this.controller, this.focusNode, this.onSubmit});

  @override
  _ChatBottomTextFieldWidgetState createState() => _ChatBottomTextFieldWidgetState();
}

class _ChatBottomTextFieldWidgetState extends State<ChatBottomTextFieldWidget> {
  InputBorder get _border => OutlineInputBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)), borderSide: BorderSide(color: Theme.of(context).cardColor));

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: SizeConfig.padding,
        child: Row(
          children: [
            Expanded(
              child: ClipPath(
              clipper:  ChatTextFieldClipper(),
                child: TextFormField(
                  focusNode: widget.focusNode,
                  minLines: 1,
                  maxLines: 3,
                  enabled: true,
                  controller: widget.controller,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.multiline,
                  style: AppStyles.BlackStyleFont_20(context),
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    hoverColor: Theme.of(context).cardColor,
                    fillColor: Theme.of(context).cardColor,
                    focusColor: Theme.of(context).cardColor,
                    filled: true,
                    hintText: AppStrings.YOUR_TEXT.tr(),
                    hintStyle: AppStyles.BlackStyleFont_20(context)
                        .copyWith(color: AppStyles.BlackStyleFont_20(context).color.withOpacity(.8)),
                    border: _border,
                    disabledBorder: _border,
                    enabledBorder: _border,
                    errorBorder: _border,
                    focusedBorder: _border,
                    isDense: true,
                    focusedErrorBorder: _border,
                    contentPadding: null,
                    prefixIcon: Icon(StoreangelIcons.smiley,color: Theme.of(context).focusColor,)
                  ),
                ),
              ),
            ),
            IntrinsicHeight(
              child: GestureDetector(
                child: Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 28,top: 15,bottom: 15,
                      left: 15
                    ),
                    child: Center(
                      child: Icon(
                        StoreangelIcons.send_message,
                        color: AppColors.whiteColor,
                        size: 16,

                      ),
                    ),
                  ),
                ),
                onTap: () => null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
