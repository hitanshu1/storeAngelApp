import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_share_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:storeangelApp/ui/shared/premium_widget.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ShareSelectedUserListWidget extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return Consumer<ShareListViewModel>(
      builder: (context,model,child){
        return MultiSliver(
          children: [
            model.selectedUsers.length==0?SliverFillRemaining(
              child: Center(child:
              Padding(
                padding:SizeConfig.sidepadding,
                child: Text(AppStrings.ADD_FRIENDS_WITH_WHOM_YOU_SHARE_THIS_LIST_AND_COLLABORATIVELY_WANT_TO_USE.tr(),
                  style: AppStyles.BlackStyleFont_20(context),
                  textAlign: TextAlign.center,
                ),
              ),),
            ):SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, int index) {


                    if(index==0){
                      return  Container(
                        child: Padding(
                          padding:SizeConfig.paddingWithHighVerticalSpace,
                          child: TitleTextWidget(
                            title: AppStrings.ATTACHED_TO.tr(),
                          ),
                        ),
                      );
                    }
                    UserModel _user=model.selectedUsers[index-1];

                    return Padding(
                      padding: SizeConfig.sidebottompadding,
                      child: Slidable(
                        key:UniqueKey(),
//                        controller: slidableController,
                        dismissal: SlidableDismissal(
                          child: SlidableDrawerDismissal(),

                          onDismissed: (actionType) {
                            print('object');
                            if(actionType == SlideActionType.primary){
                              print('object');
                            }

                          },
                        ),

                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.4,
                        closeOnScroll: false,
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            foregroundColor: AppColors.primaryColor,
                            color: Colors.transparent,
                            iconWidget: IconButton(
                              icon: Icon(
                                StoreangelIcons.delete_icon,
                                color: Theme.of(context).focusColor,
                                size: SizeConfig.iconSize,
                              ),
                              onPressed: () {

                              },
                            ),
                            onTap: () {

                            },
                          )
                        ],
                        child: CustomFiveWidgetsTile(
                            trailingTwoBackGroundColor:  AppColors.primaryGradient,
                            trailingOneBackGroundColor:AppColors.primaryGradient,

                            trailingOne: Center(
                              child: Icon(Icons.check,color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
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
                                    text: _user.premium?AppStrings.PREMIUM.tr()+' ':AppStrings.STANDARD.tr()+' ',
                                    style:_user.premium? AppStyles.GreenStyleWithBold800_Font20(context).copyWith(
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
                      ),
                    );
                  },
                  childCount: model.selectedUsers.length>0?model.selectedUsers.length+1:0,
                )),
            model.selectedUsers.length>0&&!model.currentUserDetails.premium?SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, int index) {


                    if(index==0){
                      return  Container(
                        child: Padding(
                          padding:SizeConfig.paddingWithHighVerticalSpace,
                          child: TitleTextWidget(
                            title: AppStrings.MORE_FRIENDS.tr(),
                          ),
                        ),
                      );
                    }

                    UserModel _user=model.unSelectedUsers[index-1];

                    return Padding(
                      padding: SizeConfig.sidebottompadding,
                      child: Slidable(
                        key:UniqueKey(),
                        direction: Axis.horizontal,

                        dismissal: SlidableDismissal(
                          child: SlidableDrawerDismissal(),

                          onDismissed: (actionType) {
                            model.removeUnselected(_user);
                          },
                        ),

                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.4,
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            foregroundColor: AppColors.primaryColor,
                            color: Colors.transparent,
                            iconWidget: IconButton(
                              icon: Icon(
                                StoreangelIcons.delete_icon,
                                color: Theme.of(context).focusColor,
                                size: SizeConfig.iconSize,
                              ),
                              onPressed: () {},
                            ),

                          )
                        ],
                        child: CustomFiveWidgetsTile(
                            trailingTwoBackGroundColor:  AppColors.blackGradient,
                            trailingOneBackGroundColor:AppColors.blackGradient,

                            trailingOne: InkWell(
                              onTap: (){

                                model.onSelectUser(_user);


                              },
                              child: Center(
                                child: Icon(Icons.add,color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
                              ),
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
                                    text: _user.premium?AppStrings.PREMIUM.tr()+' ':AppStrings.STANDARD.tr()+' ',
                                    style:_user.premium? AppStyles.GreenStyleWithBold800_Font20(context).copyWith(
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
                      ),
                    );
                  },
                  childCount: model.unSelectedUsers.length+1,
                )):SliverToBoxAdapter(),
            SizeConfig.verticalSliverSmallSpace(),
            model.currentUserDetails.premium?SliverToBoxAdapter(
              child: PremiumWidget(),
            ):SliverToBoxAdapter(
              child: Padding(
                padding: SizeConfig.padding,
                child: ButtonWidget(
                  buttonText: AppStrings.DIVIDE.tr(),
                  onPressed: (){

                  },
                ),
              ),
            ),
            SizeConfig.verticalSliverSmallSpace(),
          ],
        );

      },
    );
  }
}
