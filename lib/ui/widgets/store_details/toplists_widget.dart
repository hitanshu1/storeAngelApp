import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_store_details.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:easy_localization/easy_localization.dart';

class TopListsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreDetailsViewModel>(
        builder: (context,storeDetailsModel,child){
          return SliverPadding(
            padding: SizeConfig.sidepadding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {

                  return Padding(
                    padding: SizeConfig.tilesBottomPadding,
                    child: CustomFiveWidgetsTile(
                        trailingOne: FittedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            
                            children: [
                              Text('5',style: AppStyles.WhiteStyle_WithBold900_Font36,),
                              Text(AppStrings.ARTICLES.tr(),
                                style: AppStyles.WhiteStyle_FontSmall,)
                            ],
                          ),
                        ),
                        enableTrailingTwoPadding: false,
                        trailingTwo: FittedBox(
                          fit: BoxFit.cover,
                          child: ViewAppImage(
                            imageUrl: storeDetailsModel.currentStore.image,

                          ),
                        ),
                        imageUrl: storeDetailsModel.currentStore.topList[index].imageUrl,
                        middleWidget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizeConfig.verticalSpaceSmall(),
                            Row(
                              children: [
                                Expanded(child: Text(AppStrings.TOPLIST.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                                Text(DateService.getDateFormatddMMyyyy(DateTime.now().toIso8601String(), context),
                                style:  AppStyles.GrayStyleItalicFont16(context),),

                              ],
                            ),
                            SizeConfig.verticalSpaceSmall(),
                            Text(storeDetailsModel.currentStore.name,style: AppStyles.BlackStyleWithBold800Font_24(context),),
                            SizeConfig.verticalSpaceSmall(),
                            Text(AppStrings.euroSymbol+NumberService.priceAfterConvert(20, context),
                            style: AppStyles.BlackStyleFont20W300(context),),
                            SizeConfig.verticalSpaceSmall(),
                            CustomRatingWidget(reviewCount: 6, initialRating: 3, stars: 13),
                            SizeConfig.verticalSpaceSmall(),

                            Text(storeDetailsModel.currentStore.twoLineAddress,style: AppStyles.BlackStyleFont16Light(context),),
                            SizeConfig.verticalSpaceSmall(),
                          ],
                        )),
                  );
                },
                childCount: storeDetailsModel.currentStore.topList.length,
              ),
            ),);
        });
  }
}
