import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final Function onChange;
  final TextEditingController controller;
  final Function onSubmit;
  final Function onScan;
  final String hintText;
  final bool scan;
  SearchTextFieldWidget({this.scan:true,this.onChange,this.onScan,this.controller,this.onSubmit,this.hintText});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: SizeConfig.circularBorder,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor

        ),
        child: TextField(

          controller: controller,
          style: AppStyles.BlackStyleFont_20(context),
          onChanged: onChange,
          onSubmitted: onSubmit,
          textAlignVertical: TextAlignVertical.center,
          decoration:InputDecoration(
              border: InputBorder.none,
            hintText: hintText??'',
            hintStyle: TextStyle(fontStyle: FontStyle.italic,color:  Theme.of(context).focusColor),
            suffixIcon:scan?IconButton(icon:  Icon(StoreangelIcons.scan,color:  Theme.of(context).focusColor,size: SizeConfig.iconSize,),
            onPressed: onScan,):null,
            prefixIcon: IconButton(
              icon: Icon(StoreangelIcons.search,color: Theme.of(context).focusColor,size: SizeConfig.iconSize,),
              onPressed: (){

              },
            )
          ),
        ),
      ),
    );
  }
}
