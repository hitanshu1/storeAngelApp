import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextStyle hintextStyle;
  final double height;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final double radius;
  final bool obscureText;
  final bool autoCorrect;
  final Function onSubmit;
  final Key key;


   AppTextField(
      {this.hintText,
      this.hintextStyle,
      this.height,
      this.controller,
      this.focusNode,
      this.nextFocusNode,
      this.radius,
      this.obscureText: false,
      this.inputFormatters,
      this.textInputAction,
      this.keyboardType,
        this.onSubmit,
        this.key,
      this.autoCorrect:true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(focusNode!=null){
          focusNode.requestFocus();
        }
      },
      child: Container(
        height: height ?? 50,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(radius??0),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: SizeConfig.innersidepadding,
          child: TextFormField(
            key: key,
            obscureText: obscureText,
            style: AppStyles.BlackStyleFont_20(context),
            controller: controller,
            focusNode: focusNode,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType ?? TextInputType.text,
            textInputAction: textInputAction ?? TextInputAction.done,
            autocorrect: autoCorrect,
            onFieldSubmitted: (term) {
              FocusScope.of(context).requestFocus(nextFocusNode ?? FocusNode());
              onSubmit();
            },
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            decoration: InputDecoration.collapsed(hintText: hintText, hintStyle: hintextStyle).copyWith(isDense: true),
          ),
        ),
      ),
    );
  }
}
