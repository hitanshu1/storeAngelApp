import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class SmallTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String suffix;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final bool outerLineBorder;
  final FormFieldValidator validator;
  final String hintText;
  final String labelText;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextInputAction textInputAction;
  final bool enableSuffixIfTextIsNotEmpty;
  final TextStyle hintStyle;

  const SmallTextFormField(
      {this.labelText,
        this.hintText,
        this.controller,
        this.suffix,
        this.textInputType,
        this.inputFormatters,
        this.outerLineBorder: true,
        this.validator,
        this.floatingLabelBehavior,
        this.enableSuffixIfTextIsNotEmpty: false,
        this.textInputAction, this.hintStyle});

  @override
  _SmallTextFormFieldState createState() => _SmallTextFormFieldState();
}

class _SmallTextFormFieldState extends State<SmallTextFormField> {
  @override
  void initState() {
    if (widget.controller != null&&widget.enableSuffixIfTextIsNotEmpty) {
      widget.controller.addListener(() {
        if (widget.controller.text.length == 1) {
          setState(() {});
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.textInputType,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.right,
      textInputAction: widget.textInputAction,
      style: AppStyles.BlackStyleFont_20(context),
      decoration: widget.outerLineBorder
          ? InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppStyles.BlackStyleFont_16(context),
        labelStyle: widget.hintStyle??AppStyles.BlackStyleFont_16(context),
        labelText: widget.labelText,
        floatingLabelBehavior: widget.floatingLabelBehavior,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightGreyColor), borderRadius: BorderRadius.circular(10)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightGreyColor), borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightGreyColor), borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightGreyColor), borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightGreyColor), borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightGreyColor), borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.only(
          left: AppConstants.TextField_Contentpading,
          right: AppConstants.TextField_Contentpading,
        ),
        suffix: widget.suffix != null && (widget.controller?.text?.isNotEmpty ?? true) ? Text(widget.suffix, style: AppStyles.BlackStyleFont_20(context),) : null,
      )
          : InputDecoration(border: InputBorder.none, suffix: widget.suffix != null ? Text(widget.suffix, style: AppStyles.BlackStyleFont_20(context),) : null),
    );
  }
}
