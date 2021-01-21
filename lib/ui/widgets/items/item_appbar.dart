import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/ui/shared/search_appbar_widget.dart';


class ItemAppbar extends SearchAppBar {
  final TextEditingController controller;
  final String title;
  final Function onSubmit;
  final Function onClear;
  final Function onChange;
  final FocusNode focusNode;
  final double elevation;

  ItemAppbar({this.elevation:0, this.controller,this.onSubmit,this.title,this.onClear,this.onChange,this.focusNode});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      elevation: elevation,
      child: SearchAppBar(
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BackButton(
                    color: Theme.of(context).iconTheme.color,
              onPressed: (){
               Navigator.pop(context);
              },
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: SizeConfig.sidepadding.right),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius:
                  BorderRadius.circular(SizeConfig.introGetStarted_button_Radius),
                ),
                child: TextField(
                  focusNode: focusNode,

                controller: controller,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (val){
                  onChange(val);
                },
                onSubmitted: (val)=>onSubmit(val),
                textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: SizeConfig.fontSizeMedium,
                      color: Theme.of(context).focusColor),

                  decoration:  InputDecoration(
                    prefixIcon:  Icon(
                        Icons.search,
                        color: Theme.of(context).focusColor),
                    suffixIcon: InkWell(child: Icon(Icons.cancel,color: AppColors.lightGreyColor,
                    ),onTap: (){
                      onClear();
                    },),
                    hintText: title,
                    hintStyle: new TextStyle(color: Theme.of(context).focusColor),
                    border: InputBorder.none,
                    isDense: true,

                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

}
