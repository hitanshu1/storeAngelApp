import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

import 'package:auto_size_text/auto_size_text.dart';

class AppHeader extends StatelessWidget {
  final bool isAppImageOnly;
  final double height;
  final Widget secondChild;
  final bool isBack;
  final String title;
  final String subtitle;
  final TextStyle style;
  final bool isSort;
  final List<Widget> actions;
  final Function onBackPress;
  final Function onReverse;

  const AppHeader({Key key,this.onReverse,this.onBackPress,this.height,this.style,this.isAppImageOnly:false,this.secondChild,this.title,this.subtitle,this.isBack:false,this.isSort:false,this.actions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height??SizeConfig.customerHeaderHeight,
      width: SizeConfig.screenWidth,

      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient
      ),
      padding: SizeConfig.smalltopPadding.copyWith(
        left: 0,right: 0,
      ),
      child: Padding(
        padding:SizeConfig.sidepadding,
        child: isBack?Padding(
          padding: EdgeInsets.only(
            bottom: actions!=null?0:SizeConfig.screenHeight * 0.01
          ),
          child: Stack(
            children: [
              Container(
                height:  height??SizeConfig.customerHeaderHeight,
                width: SizeConfig.screenWidth,
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: title!=null?AutoSizeText(
                            title??'',
                            style: style??AppStyles.WhiteStyleWithBold800_Font16.copyWith(
                                fontSize: SizeConfig.fontSizeLargest
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                          ):Container(),
                        ),
                        actions!=null?Wrap(children: actions,):Container()
                      ],
                    ),
                  ],
                ),
              ),
              Positioned.fill(child: Align(
                alignment: Alignment.topLeft,
                child:  BackButton(

                  color: AppColors.whiteColor,
                  onPressed: (){
                    if(onBackPress!=null){
                      onBackPress();
                    }else{
                      Navigator.pop(context);
                    }
                  },
                ),
              ))

            ],
          ),
        ):Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: title!=null?Text(
                          title??'',
                          style: style??AppStyles.WhiteStyleWithBold800_Font16.copyWith(
                              fontSize: SizeConfig.fontSizeLargest
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ):Container(),
                      ),
                      isSort?InkWell(child: Icon(StoreangelIcons.sortUp,color: AppColors.whiteColor,),
                      onTap: (){
                        onReverse();
                      },):Container(),
                      actions!=null?Wrap(children: actions,):Container(),

                    ],
                  ),

                 SizeConfig.verticalSpaceSmall(),

                ],
              ),
            ),
            secondChild!=null?secondChild:Container()
          ],
        ),
      ),
    );
  }
}
