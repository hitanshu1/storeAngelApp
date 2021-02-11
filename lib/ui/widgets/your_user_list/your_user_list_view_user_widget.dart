import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:easy_localization/easy_localization.dart';

class YourUserListViewUserWidget extends StatefulWidget {
  final UserModel user;
  YourUserListViewUserWidget({this.user});

  @override
  _YourUserListViewUserWidgetState createState() => _YourUserListViewUserWidgetState();
}

class _YourUserListViewUserWidgetState extends State<YourUserListViewUserWidget> {
   SlidableController slidableController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Slidable(
        key: Key(''),
        controller: slidableController,
        direction: Axis.horizontal,

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
            onTap: () {

            },
          )
        ],
        child: CustomFiveWidgetsTile(
            trailingTwoBackGroundColor: AppColors.primaryGradient,
            trailingOneBackGroundColor:AppColors.primaryGradient,

            trailingOne: InkWell(
              child: Center(
                child: Icon(Icons.check,color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
              ),
              onTap: (){
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
            imageUrl: widget.user.imageUrl,
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
                Text(widget.user.name,
                  style: AppStyles.BlackStyleWithBold800Font_24(context),),
                SizeConfig.verticalSpaceSmall(),
                RichText(
                  text: TextSpan(
                    text: widget.user.premium?AppStrings.PREMIUM.tr()+' ':AppStrings.STANDARD.tr()+' ',
                    style:widget.user.premium? AppStyles.GreenStyleWithBold800_Font20(context).copyWith(
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

                Text(widget.user.addressLinen,
                  style: AppStyles.BlackStyleFont16Light(context),),
                SizeConfig.verticalSpaceSmall(),
              ],
            )),
      ),
    );
  }
}
