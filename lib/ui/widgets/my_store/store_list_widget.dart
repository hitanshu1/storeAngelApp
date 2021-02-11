import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_mystore.dart';
import 'package:storeangelApp/ui/screens/consumer/store_details_screen.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:easy_localization/easy_localization.dart';

class StoreListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyStoreViewModel>(builder: (context,model,child){
      return SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, int index) {


              return Padding(
                padding: SizeConfig.sidebottompadding,
                child: GestureDetector(
                  onTap: (){
                    model.navigateToScreen(StoreDetailsScreen.routeName,arguments:index);
                  },
                  child: CustomFiveWidgetsTile(
                    trailingOneBackGroundColor: AppColors.primaryGradient,
                      trailingTwoBackGroundColor: AppColors.primaryGradient,
                      trailingOne: Center(
                        child: Icon(Icons.check,color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
                      ),
                      trailingTwo: FittedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(StoreangelIcons.users,color: AppColors.whiteColor,),
                            SizeConfig.verticalSpaceVeryGap(),
                            Text('279',style: AppStyles.WhiteStyle_Font20,)
                          ],
                        ),
                      ),
                      imageUrl: model.selectedStores[index].image,
                      middleWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizeConfig.verticalSpaceSmall(),
                          Row(
                            children: [
                              Expanded(child: Text(AppStrings.STORE.tr(),style: AppStyles.BlackStyleFont16Light(context),)),

                              Text(AppStrings.UPDATED.tr()+'-'+'',style: AppStyles.GrayStyleItalicFont16(context),),

                            ],
                          ),
                          SizeConfig.verticalSpaceSmall(),
                          Text(model.selectedStores[index].name,
                            style: AppStyles.BlackStyleWithBold800Font_24(context),),
                          SizeConfig.verticalSpaceSmall(),
                          Text('in 300 m',style: AppStyles.BlackStyleFont20W300(context),),

                          SizeConfig.verticalSpaceSmall(),
                          CustomRatingWidget(reviewCount: 6, initialRating: 3, stars: 14),
                          SizeConfig.verticalSpaceMedium(),


                          Text(model.selectedStores[index].twoLineAddressWithoutName,
                            style: AppStyles.BlackStyleFont16Light(context),),
                          SizeConfig.verticalSpaceSmall(),
                        ],
                      )),
                ),
              );
            },
            childCount: model.selectedStores.length,
          ));
    });
  }
}
