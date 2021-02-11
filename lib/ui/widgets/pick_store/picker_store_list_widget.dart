import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/pickStore_viewmodel.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:easy_localization/easy_localization.dart';

class PickerStoreListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PickStoreViewModel>(
        builder: (context,model,child){
          return SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, int index) {
                      StoreDataModel store=model.searchList[index];
                  return Padding(
                    padding: SizeConfig.sidebottompadding,
                    child: Opacity(
                      opacity: model.opacityValue(store),
                      child: CustomFiveWidgetsTile(
                        trailingOneBackGroundColor:model.selectedStoreList.contains(store)?AppColors.primaryGradient:AppColors.blackGradient ,
                          trailingTwoBackGroundColor: model.selectedStoreList.contains(store)?AppColors.primaryGradient:AppColors.blackGradient,

                          trailingOne: InkWell(
                            child: Center(
                              child: Icon(model.selectedStoreList.contains(store)?Icons.check:Icons.add,color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
                            ),
                              onTap: (){
                                model.storeItemTapped(store);

                              }
                          ),
                          trailingTwo: FittedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               Icon(StoreangelIcons.users,color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
                                SizeConfig.verticalSpaceSmall(),
                                FittedBox(child: Text('279',style: AppStyles.WhiteStyle_Font16,))
                              ],
                            ),
                          ),
                          imageUrl: store.image,
                          middleWidget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizeConfig.verticalSpaceSmall(),
                              Row(
                                children: [
                                  Expanded(child: Text(AppStrings.STORE.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                                  Text(TimeAgoService.timeAgoSinceDate(DateTime.now().subtract(Duration(minutes: 5)), context),
                                    style: AppStyles.GrayStyleItalicFont16(context),),

                                ],
                              ),
                              SizeConfig.verticalSpaceSmall(),
                              Text(store.name,
                                style: AppStyles.BlackStyleWithBold800Font_24(context),),
                              SizeConfig.verticalSpaceSmall(),
                              CustomRatingWidget(reviewCount: 6, initialRating: 3, stars: 6),
                              SizeConfig.verticalSpaceSmall(),

                              Text(store.twoLineAddress,
                                style: AppStyles.BlackStyleFont16Light(context),),
                              SizeConfig.verticalSpaceSmall(),
                            ],
                          )),
                    ),
                  );
                },
                childCount: model.searchList.length,
              ));
        });
  }
}
