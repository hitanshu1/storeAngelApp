import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/customer_details/order_trading_widget_shape.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

import 'app_tile_shape.dart';


class  CustomFiveWidgetsTile extends StatelessWidget {
  final String imageUrl;
  final Widget middleWidget;
  final Widget trailingOne,trailingTwo;
  final LinearGradient trailingOneBackGroundColor,trailingTwoBackGroundColor;
  final bool enableFav;
  final bool isFav;
  final Function onToggleFav;
  final bool isReverse;
  final bool enableTrailingTwoPadding;
  CustomFiveWidgetsTile({this.enableTrailingTwoPadding:true,@required this.trailingOne,@required this.trailingTwo,
    this.trailingOneBackGroundColor,this.trailingTwoBackGroundColor,@required this.imageUrl,@required this.middleWidget,
  this.enableFav:false,this.isFav:false,this.onToggleFav,this.isReverse:false});


  @override
  Widget build(BuildContext context) {
    return AppTileShape(
      isReverse: isReverse,
      child: SizedBox(
        width: SizeConfig.screenWidth,
        child: FittedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.tileHeight,
                child: Stack(
                  children: [
                    ViewAppImage(
                      boxFit: BoxFit.cover,
                      height: SizeConfig.tileHeight,
                      width: SizeConfig.tileHeight,
                      imageUrl: imageUrl,
                    ),
                    enableFav?Positioned.fill(child: Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(icon: isFav?Icon(Icons.favorite,color: AppColors.red,):Icon(Icons.favorite_border,
                      color: AppColors.whiteColor,),
                      onPressed: (){
                        onToggleFav();
                      },),
                    )):Container()
                  ],
                ),
              ),
              SizeConfig.horizontalSpaceVeryGap(),
              Container(
                width: SizeConfig.screenWidth*.5,
                height: SizeConfig.tileHeight,
                color: Theme.of(context).cardColor,
                child:Padding(
                  padding: SizeConfig.innerSidepadding,
                  child: FittedBox(child: SizedBox(
                      width: SizeConfig.screenWidth*.55,
                      child: middleWidget)),
                ),
              ),
              SizeConfig.horizontalSpaceVeryGap(),
              SizedBox(
                  height: SizeConfig.tileHeight,
                  child:  Column(
                    children: [

                      OrderTradingWidgetShape(child:Padding(
                        padding: SizeConfig.innerpadding,
                        child: trailingOne,
                      ) ,
                        color: trailingOneBackGroundColor,),
                      SizeConfig.verticalSpaceVeryGap(),
                      OrderTradingWidgetShape(child: Padding(
                        padding: enableTrailingTwoPadding?SizeConfig.innerpadding:EdgeInsets.zero,
                        child: trailingTwo,
                      ),
                        color: trailingTwoBackGroundColor,)

                    ],
                  )),

            ],
          ),
        ),
      ),
    );
  }
}