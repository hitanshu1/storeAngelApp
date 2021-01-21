
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/regexService.dart';
import 'package:storeangelApp/ui/shared/smalltextfield.dart';

class TextFieldWithIncrementDecrement extends StatefulWidget {
  final String initialValue;
  final TextEditingController controller;
  final Color textFieldColor;
  final double height;
  TextFieldWithIncrementDecrement({this.controller,this.initialValue,this.height,this.textFieldColor});
  @override
  _TextFieldWithIncrementDecrementState createState() => _TextFieldWithIncrementDecrementState();
}

class _TextFieldWithIncrementDecrementState extends State<TextFieldWithIncrementDecrement> {





  Widget _buttonWidget(IconData icon){
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.radiusSmall),
          gradient: AppColors.primaryGradient
      ),
      child: Center(
        child: Icon(icon,color: AppColors.whiteColor,size: 15,),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.initialValue!=null){
      widget.controller.text=AppStrings.euroSymbol+widget.initialValue;
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(child: _buttonWidget(Icons.remove),
          onTap: (){
            String _val=widget.controller.text.replaceAll(',', '.');

            final n = num.tryParse(_val.replaceAll(AppStrings.euroSymbol, ''));
            if(n>1){

              widget.controller.text= AppStrings.euroSymbol+(double.tryParse(_val.replaceAll(AppStrings.euroSymbol, ''))-1.00).toStringAsFixed(2).replaceAll('.', ',');
              setState(() {

              });
            }
          },),
        SizedBox(width: 90,
            child: Padding(
              padding:SizeConfig.smallInnerSidePadding,
              child: SmallTextField(
                height: 30,
                color: widget.textFieldColor,
                hasBorderSideColor: false,
                controller: widget.controller,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                textInputAction: TextInputAction.done,
                enableSuffixIfTextIsNotEmpty: true,
                style: AppStyles.BlackStyleFont_20(context),
                onSubmit: (val) {
                  try {
                    if (double.parse(val.replaceAll(AppStrings.euroSymbol, '')) <= 0) {
                      widget.controller.text = AppStrings.euroSymbol+NumberService.addAfterCommaTwoZeros(val.replaceAll(AppStrings.euroSymbol, ''), context);
                    }
                  } catch (e) {
                    
                    widget.controller.text = AppStrings.euroSymbol+NumberService.addAfterCommaTwoZeros(val.replaceAll(AppStrings.euroSymbol, ''), context);
                  }
                },
                validator: (value) {final n = num.tryParse(value);

                if (n < 1) {
                  return 'Invalid charge';
                }
                return null;
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegexService.doubleRegexWithCommaOrDotAndTwoDigit)
                ],
                textInputType: TextInputType.numberWithOptions(signed: true, decimal: true),
              ),
            )),
        GestureDetector(child: _buttonWidget(Icons.add),
          onTap: (){
          String _val=NumberService.addAfterCommaTwoZeros(widget.controller.text.replaceAll(AppStrings.euroSymbol,''), context);
          print('www=$_val');
            widget.controller.text= AppStrings.euroSymbol+(double.tryParse(_val.replaceAll(',', '.'))+1.0).toStringAsFixed(2).replaceAll('.', ',');
            setState(() {

            });
          },),
      ],
    );
  }
}
