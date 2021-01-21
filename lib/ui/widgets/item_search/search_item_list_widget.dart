import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_item_search.dart';
import 'package:storeangelApp/ui/screens/consumer/item_details_screen.dart';
import 'package:storeangelApp/ui/shared/available_circle.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchItemListWidget extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Consumer<ItemSearchViewModel>(
        builder: (context,model,child){
          return  SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Padding(
                  padding: SizeConfig.bottomPadding,
                  child: GestureDetector(
                    onTap: (){
                      model.navigateToScreen(ItemDetailsScreen.routeName,
                      arguments: ItemDetailsArguments(
                        products: model.products,
                        initialIndex: index
                      ));
                    },
                    child: CustomFiveWidgetsTile(
                      imageUrl: model.products[index].imageUrl,
                      trailingOne: Center(
                        child: Icon(Icons.add,color: AppColors.whiteColor,),
                      ),
                      trailingTwo: Center(child:
                      AvailableCircleWidget(availableStatus:model.products[index].availableStatus,)),
                      middleWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizeConfig.verticalSpaceSmall(),
                          Row(
                            children: [
                              Expanded(child: Text(AppStrings.ARTICLES.tr(),style: AppStyles.BlackStyleFont16Light(context),)),

                              Text(TimeAgoService.timeAgoSinceDate(DateTime.now().subtract(Duration(
                                minutes: 15
                              )), context),
                                style: AppStyles.GrayStyleItalicFont16(context),),

                            ],
                          ),
                          SizeConfig.verticalSpaceSmall(),
                          Text(model.products[index].name,style: AppStyles.BlackStyleWithBold800Font_20(context),),
                          SizeConfig.verticalSpaceSmall(),
                          Text(' ${NumberService.priceAfterConvert(model.products[index].price, context)}'+AppStrings.euroSymbol,
                            style: AppStyles.BlackStyleFont20W300(context),),
                          SizeConfig.verticalSpaceSmall(),
                          CustomRatingWidget(reviewCount: 15, initialRating: 3.5, stars: 3.5),
                          SizeConfig.verticalSpaceSmall(),
                          Text(model.products[index].storeDetails.twoLineAddress,
                            style: AppStyles.BlackStyleFont16Light(context),),
                          SizeConfig.verticalSpaceSmall(),
                        ],
                      ),
                    ),
                  ),

                );
              },
              childCount: model.products.length,
            ),
          );
        });
  }
}
