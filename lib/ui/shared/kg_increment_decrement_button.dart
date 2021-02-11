
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/shared/smalltextfield.dart';

class KgIncrementDecrementButton extends StatefulWidget {
  final String initialValue;
  final TextEditingController controller;
  final Color textFieldColor;
  final double height;
  KgIncrementDecrementButton({this.controller,this.initialValue,this.height,this.textFieldColor});
  @override
  _KgIncrementDecrementButtonState createState() => _KgIncrementDecrementButtonState();
}

class _KgIncrementDecrementButtonState extends State<KgIncrementDecrementButton> {





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
      widget.controller.text=widget.initialValue;
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(child: _buttonWidget(Icons.arrow_back_ios),
          onTap: (){
            widget.controller.text='GM';
            setState(() {

            });
          },),
        SizedBox(width: 80,
            child: Padding(
              padding:SizeConfig.smallInnerSidePadding,
              child: SmallTextField(
                height: 30,
                color: widget.textFieldColor,
                hasBorderSideColor: false,
                controller: widget.controller,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.center,
                enableSuffixIfTextIsNotEmpty: true,
                style: AppStyles.BlackStyleFont_20(context),
                onSubmit: (val) {
                  try {
                    if (val!='KG'||val!='GM') {
                      widget.controller.text = val;
                    }
                  } catch (e) {

                  }
                },
                validator: (value) {;

                if (value!='KG'||value!='GM') {
                  return 'Invalid charge';
                }
                return null;
                },
                textInputType: TextInputType.text,
              ),
            )),
        GestureDetector(child: _buttonWidget(Icons.arrow_forward_ios),
          onTap: (){
            widget.controller.text='KG';
            setState(() {

            });
          },),
      ],
    );
  }
}
