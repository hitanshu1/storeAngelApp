import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class TextTextfieldWidget extends StatelessWidget {
  final String hint;
  final Color buttonColor;
  final double height;
  final double radius;
  final Color textColor;
  final double fontSize;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final double paddingLeft;
  final bool enabled;
  final bool obscure;
  final int maxLines;
  final Widget suffixWidget;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final EdgeInsets padding;
  final String labelText;
  final TextStyle labelStyle;

  TextTextfieldWidget(
      {@required this.hint,
      this.inputFormatters,
      this.paddingLeft,
      this.buttonColor,
      this.radius,
      this.textColor,
      this.fontSize,
      this.controller,
      this.focusNode,
      this.nextFocusNode,
      this.obscure: false,
      this.textInputAction,
      this.suffixWidget,
      this.enabled: true,
      this.textInputType: TextInputType.text,
      this.height,
      this.maxLines,
      this.padding,
      this.labelText,
      this.labelStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height != null ? height : SizeConfig.textFieldHeight,
      decoration: BoxDecoration(
        color: buttonColor ?? Colors.black,
        borderRadius: BorderRadius.circular(radius ?? 0),
      ),
      child: TextFormField(
        textAlign: TextAlign.start,
        maxLines: maxLines,
        enabled: enabled,
        focusNode: focusNode,
        obscureText: obscure,
        controller: controller,
        textInputAction: textInputAction ?? TextInputAction.done,
        keyboardType: textInputType,
        style: AppStyles.BlackStyleFont_20(context),
        onFieldSubmitted: (term) {
          FocusScope.of(context).requestFocus(nextFocusNode ?? FocusNode());
        },
        inputFormatters: inputFormatters,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: hint,
          labelText: labelText,
          labelStyle: labelStyle??AppStyles.GrayStyle_FontMedium(context),
          isDense: true,
          hintStyle: AppStyles.GrayStyleItalicFont16(context),
          suffix: suffixWidget,
          border: InputBorder.none,
          contentPadding: padding != null
              ? padding
              : EdgeInsets.fromLTRB(
                  paddingLeft != null ? paddingLeft : AppConstants.TextField_Contentpading,
                  (SizeConfig.textFieldHeight - SizeConfig.fontSizeMedium) / 2,
                  0.0,
                  (SizeConfig.textFieldHeight - SizeConfig.fontSizeMedium) / 2 - 1),
        ),
      ),
    );
  }
}
