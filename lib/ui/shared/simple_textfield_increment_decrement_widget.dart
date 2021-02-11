
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/shared/smalltextfield.dart';

class SimpleTextFieldWithIncrementDecrementWidget extends StatefulWidget {
  final String initialValue;
  final TextEditingController controller;
  final Color textFieldColor;
  final double height;
  final bool enable;
  SimpleTextFieldWithIncrementDecrementWidget({this.controller,this.initialValue,this.height,this.textFieldColor,this.enable:true});
  @override
  _SimpleTextFieldWithIncrementDecrementWidgetState createState() => _SimpleTextFieldWithIncrementDecrementWidgetState();
}

class _SimpleTextFieldWithIncrementDecrementWidgetState extends State<SimpleTextFieldWithIncrementDecrementWidget> {





  Widget _buttonWidget(IconData icon){
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.radiusSmall),
          gradient: AppColors.primaryGradient
      ),
      child: Center(
        child: Icon(icon,color: AppColors.whiteColor,size: 15,),
      ),
    );
  }
  String _initialVal='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.initialValue!=null){
      widget.controller.text=widget.initialValue;
      _initialVal=widget.initialValue;
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_initialVal!=widget.initialValue){


      setState(() {
        widget.controller.text=widget.initialValue;
        _initialVal=widget.initialValue;
      });
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(child: _buttonWidget(Icons.remove),
          onTap: (){
          if(widget.enable){
            String _val=widget.controller.text;

            final n = int.tryParse(_val);
            if(n>1){

              widget.controller.text= (int.tryParse(_val)-1).toString();
              setState(() {

              });
            }
          }

          },),
        SizedBox(width: 85,
            child: Padding(
              padding:SizeConfig.smallInnerSidePadding,
              child: SmallTextField(
                height: 35,
                enable: widget.enable,
                color: widget.textFieldColor,
                hasBorderSideColor: false,
                controller: widget.controller,
                textAlign: TextAlign.center,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                textInputAction: TextInputAction.done,
                enableSuffixIfTextIsNotEmpty: true,
                style: AppStyles.BlackStyleFont_20(context),
                onSubmit: (val) {
                  if(widget.enable){
                    try {
                      if (int.parse(val) <= 0) {
                        widget.controller.text = val;
                      }
                    } catch (e) {

//                    widget.controller.text =val;
                    }
                  }

                },
                validator: (value) {
                  final n = int.tryParse(value);

                if (n < 1) {
                  return 'Invalid charge';
                }
                return null;
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                textInputType: TextInputType.numberWithOptions(signed: false, decimal: false),
              ),
            )),
        GestureDetector(child: _buttonWidget(Icons.add),
          onTap: (){

          if(widget.enable){

            String _val=widget.controller.text;
            widget.controller.text= (int.tryParse(_val)+1).toString();
            setState(() {

            });
          }
          },),
      ],
    );
  }
}
