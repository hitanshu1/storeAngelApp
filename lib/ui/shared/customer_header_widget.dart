
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class CustomerHeader extends StatelessWidget {
  final bool isAppImageOnly;
  final Widget secondChild;
  final bool isBack;
  final String title;
  final String subtitle;
  final bool isSort;
  final List<Widget> actions;
  final double height;

  const CustomerHeader({Key key,this.height,this.isAppImageOnly:false,this.secondChild,this.title,this.subtitle,this.isBack:false,this.isSort:false,this.actions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height??SizeConfig.customerHeaderHeight,
      width: SizeConfig.screenWidth,

      decoration: BoxDecoration(
          gradient: AppColors.primaryGradient
      ),
      padding: SizeConfig.smalltopPadding.copyWith(
          left: 0,right: 0
      ),
      child: isAppImageOnly?Column(
        children: [
          ViewAppImage(
            height: SizeConfig.headerHeight*.3,
            width: SizeConfig.screenWidth*.4,
            boxFit: BoxFit.contain,
            assetUrl: AssetsPath.storeAngelLogoWithTitle,
          ),
        ],
      ):Padding(
        padding:SizeConfig.sidepadding,
        child: isBack?Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back,
                color: AppColors.whiteColor,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: SizeConfig.verticalC13Padding,
                    child: Text(
                      title??'',
                      style: AppStyles.WhiteStyleWithBold800_Font16.copyWith(
                          fontSize: SizeConfig.fontSizeLargest
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                actions!=null?Wrap(children: actions,):Container()
              ],
            ),

          ],
        ):Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizeConfig.CVerticalSpaceExtra110(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: SizeConfig.verticalC13Padding,
                          child: Text(
                            title,
                            style: AppStyles.WhiteStyleWithBold800_Font16.copyWith(
                                fontSize: SizeConfig.fontSizeLargest
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      isSort?Icon(StoreangelIcons.sortUp,color: AppColors.whiteColor,):Container()

                    ],
                  ),
                  SizeConfig.CVerticalSpaceSmallMediumC11(),

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
