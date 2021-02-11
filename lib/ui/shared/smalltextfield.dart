import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/numberService.dart';

class SmallTextField extends StatefulWidget {
  final TextEditingController controller;
  final String suffix;
  final bool enable;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final bool outerLineBorder;
  final String hintText;
  final String labelText;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextInputAction textInputAction;
  final bool enableSuffixIfTextIsNotEmpty;
  final bool hasBorderSideColor;
  final TextAlign textAlign;
  final TextStyle style;
  final TextStyle hintStyle;
  final Function onTap;
  final Function(String) onSubmit;
  final Function(String) onChange;
  final FormFieldValidator validator;
  final double height;
  final Color color;

  const SmallTextField(
      {this.labelText,
        this.onChange,
      this.enable: true,
      this.hintText,
      this.controller,
      this.suffix,
      this.textInputType,
      this.inputFormatters,
      this.outerLineBorder: true,
      this.floatingLabelBehavior,
      this.enableSuffixIfTextIsNotEmpty: false,
      this.textInputAction,
      this.hasBorderSideColor: true,
      this.textAlign,
      this.style,
      this.hintStyle,
      this.onTap,
        this.color,
      this.onSubmit,this.validator,this.height});

  @override
  _SmallTextFieldState createState() => _SmallTextFieldState();
}

class _SmallTextFieldState extends State<SmallTextField> {
  TextEditingController _defaultController;
  double _number = 0.0;

  OutlineInputBorder outlineInputBorder(bool borderSide) => OutlineInputBorder(
      borderSide: BorderSide(color: borderSide ? AppColors.lightGreyColor : Colors.transparent),
      borderRadius: BorderRadius.circular(10));

  String _initialValue;

  @override
  void initState() {
    _initialValue=widget.controller.text;
    setState(() {

    });
    if (widget.controller == null)
      _defaultController = TextEditingController();
    else
      _defaultController = widget.controller;

    if (_defaultController != null && widget.enableSuffixIfTextIsNotEmpty) {
      _defaultController.addListener(() {
        if(mounted)setState(() {});
      });
    }
    try {
      if(widget.hintText!=null)_number = double.parse(widget.hintText.replaceAll(',', '.'));
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.controller == null) _defaultController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_initialValue!=widget.controller.text&&widget.controller.text!=''){
      setState(() {
        _defaultController=widget.controller;
        _initialValue=widget.controller.text;
      });
    }
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: widget.color
      ),


      child: TextFormField(
        enabled: widget.enable,
        controller: _defaultController,
        keyboardType: widget.textInputType,
        inputFormatters: widget.inputFormatters,
        textAlignVertical: TextAlignVertical.center,
        textAlign: widget.textAlign ?? TextAlign.right,
        textInputAction: widget.textInputAction,
        style: widget.style ?? (_number==0?AppStyles.GrayStyle_FontMedium(context):AppStyles.BlackStyleFont_20(context)),
        onTap: widget.onTap,
        showCursor: true,
        validator: widget.validator,
        onChanged: (val){
          setState(() {

            try {
              _number = double.parse(val.replaceAll(',', '.'));
              print('number $_number is not equal ${_number==0}');
              widget.onChange('$_number');
            } catch (e) {
              print(e);
            }
          });
        },
        onFieldSubmitted: (txt) {
          if (widget.textInputAction == TextInputAction.done||widget.textInputAction == TextInputAction.next) {
            final editedValue = NumberService.addAfterCommaTwoZeros(txt,context);
            if (editedValue.isNotEmpty) {
              _defaultController.text = editedValue;
            }
            FocusScope.of(context).unfocus();
          }
          if(widget.onSubmit!=null)widget.onSubmit(txt);
        },
        decoration: widget.outerLineBorder
            ? InputDecoration(
                hintText: widget.hintText,
                hintStyle: widget.hintStyle??AppStyles.GrayStyle_FontMedium(context),
                labelStyle: AppStyles.GrayStyle_Font16(context),
                labelText: widget.labelText,
                floatingLabelBehavior: widget.floatingLabelBehavior,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                disabledBorder: outlineInputBorder(widget.hasBorderSideColor),
                focusedBorder: outlineInputBorder(widget.hasBorderSideColor),
                enabledBorder: outlineInputBorder(widget.hasBorderSideColor),
                errorBorder: outlineInputBorder(widget.hasBorderSideColor),
                focusedErrorBorder: outlineInputBorder(widget.hasBorderSideColor),
                contentPadding: SizeConfig.sidepadding,
                suffix: widget.suffix != null && (widget.controller?.text?.isNotEmpty ?? true)
                    ? Text(
                        widget.suffix,
                        style: AppStyles.BlackStyleFont_20(context),
                      )
                    : null,
              )
            : InputDecoration(
                border: InputBorder.none,
                suffix: widget.suffix != null
                    ? Text(
                        widget.suffix,
                        style: AppStyles.BlackStyleFont_20(context),
                      )
                    : null),
      ),
    );
  }
}
