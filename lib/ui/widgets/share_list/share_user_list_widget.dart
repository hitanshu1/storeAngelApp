import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_share_list.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:easy_localization/easy_localization.dart';

class ShareUserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShareListViewModel>(
      builder: (context,model,child){
        return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, int index) {

                if(index==0){
                  return  Container(
                    child: Padding(
                      padding:SizeConfig.paddingWithHighVerticalSpace,
                      child: Text(AppStrings.HERE_YOU_HAVE_THE_POSSIBILITY_TO_BOOK.tr(),
                      style: AppStyles.BlackStyleFont_20(context),),
                    ),
                  );
                }

                UserModel _user=model.users[index-1];

                return Padding(
                  padding: SizeConfig.sidebottompadding,
                  child: CustomFiveWidgetsTile(
                    trailingTwoBackGroundColor: model.selectedUsers.contains(_user)?AppColors.primaryGradient:AppColors.blackGradient,
                      trailingOneBackGroundColor:model.selectedUsers.contains(_user)?AppColors.primaryGradient:AppColors.blackGradient,

                      trailingOne: InkWell(
                        child: Center(
                          child: Icon(model.selectedUsers.contains(_user)?Icons.check:Icons.add,color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
                        ),
                  onTap: (){
                          model.onSelectUser(_user);
                  },
                      ),
                      trailingTwo: FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Text('5',style: AppStyles.WhiteStyle_WithBold900_Font36,),
                        FittedBox(child: Text(AppStrings.TAB_LABLE_LISTS.tr(),style: AppStyles.WhiteStyle_FontSmall,))
                          ],
                        ),
                      ),
                  imageUrl: _user.imageUrl,
                      middleWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizeConfig.verticalSpaceSmall(),
                          Row(
                            children: [
                          Expanded(child: Text(AppStrings.PROFILE.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                          Text(TimeAgoService.timeAgoSinceDate(DateTime.now().subtract(Duration(minutes: 3)), context),
                            style: AppStyles.GrayStyleItalicFont16(context),),

                            ],
                          ),
                          SizeConfig.verticalSpaceSmall(),
                      Text(_user.name,
                        style: AppStyles.BlackStyleWithBold800Font_24(context),),
                          SizeConfig.verticalSpaceSmall(),
                          RichText(
                            text: TextSpan(
                              text: _user.isPremium?AppStrings.PREMIUM.tr()+' ':AppStrings.STANDARD.tr()+' ',
                              style:_user.isPremium? AppStyles.GreenStyleWithBold800_Font20(context).copyWith(
                                fontStyle: FontStyle.italic
                              ):AppStyles.BlackStyleWithBold800Font_20(context).copyWith(
                                fontStyle: FontStyle.italic
                              ),
                              children: <TextSpan>[
                                TextSpan(text: AppStrings.ACCOUNT.tr(), style: AppStyles.BlackStyleFont_16(context)),

                              ],
                            ),
                          ),

                          SizeConfig.verticalSpaceSmall(),
                          CustomRatingWidget(reviewCount: 12, initialRating: 4, stars: 4),
                      SizeConfig.verticalSpaceMedium(),

                      Text(_user.addressLinen,
                        style: AppStyles.BlackStyleFont16Light(context),),
                      SizeConfig.verticalSpaceSmall(),
                        ],
                      )),
                );
              },
              childCount: model.users.length+1,
            ));
      },
    );
  }
}
