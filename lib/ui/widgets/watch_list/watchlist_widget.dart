import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_watchlist.dart';
import 'package:storeangelApp/ui/screens/consumer/save_articles_screen.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/premium_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order/item_available_widget.dart';

class WatchListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WatchListViewModel>(builder: (context,model,child){
      return SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, int index) {

                  if(index==model.wishList.skip(2).length){
                    return  PremiumWidget();
                  }



              return Padding(
                padding: SizeConfig.sidebottompadding,
                child: GestureDetector(
                  onTap: (){
                    model.navigateToScreen(SaveArticlesScreen.routeName, context,
                    arguments: model.wishList[index]);
                  },
                  child: CustomFiveWidgetsTile(

                      trailingOne: Center(
                        child: Icon(StoreangelIcons.shopping_basket,color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
                      ),
                      trailingTwo: FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${model.wishList[index].products.length}',style: AppStyles.WhiteStyle_WithBold900_Font36,),
                            FittedBox(child: Text(AppStrings.ARTICLES.tr(),style: AppStyles.WhiteStyle_FontSmall,))
                          ],
                        ),
                      ),
                      imageUrl: model.wishList[index].storeDetails.image,
                      middleWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizeConfig.verticalSpaceSmall(),
                          Row(
                            children: [
                              Expanded(child: Text(AppStrings.GROCERY_LIST.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                              Text(DateService.getDateFormatddMMyyyy(model.wishList[index].time.toIso8601String(), context),
                                style: AppStyles.GrayStyleItalicFont16(context),),

                            ],
                          ),
                          SizeConfig.verticalSpaceSmall(),
                          Text(model.wishList[index].listName,
                            style: AppStyles.BlackStyleWithBold800Font_24(context),),
                          SizeConfig.verticalSpaceLarge(),

                          Text(model.wishList[index].storeDetails.twoLineAddress,
                            style: AppStyles.BlackStyleFont16Light(context),),
                          SizeConfig.verticalSpaceSmall(),
                        ],
                      )),
                ),
              );
            },
            childCount: model.wishList.skip(2).length+1,
          ));
    });
  }
}
