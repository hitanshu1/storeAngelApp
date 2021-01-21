import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:storeangelApp/ui/shared/customer_header_widget.dart';

class HomeHeader extends StatelessWidget {
  final UserModel user;

  const HomeHeader({Key key,this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          SizeConfig.verticalSpace(SizeConfig.customerHeaderHeight+SizeConfig.tileHeight*.5-SizeConfig.screenHeight*.0075),

          CustomerHeader(
            title:'',
            isAppImageOnly: true,

          ),
          Positioned.fill(child: Padding(
            padding:SizeConfig.sidepadding,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FittedBox(
                fit: BoxFit.cover,
                child: CustomFiveWidgetsTile(
                  isReverse: true,
                  trailingOneBackGroundColor: AppColors.primaryGradient,
                  trailingTwoBackGroundColor: AppColors.primaryGradient,
                  imageUrl: user?.imageUrl,
                    trailingOne: FittedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('2',style: AppStyles.WhiteStyle_WithBold900_Font36,),
                          Text(AppStrings.ACTIVE.tr(),style: AppStyles.WhiteStyle_FontSmall,)
                        ],
                      ),
                    ),
                    trailingTwo: FittedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('3',style: AppStyles.WhiteStyle_WithBold900_Font36),
                          Text(AppStrings.SHOPS.tr(),style: AppStyles.WhiteStyle_FontSmall)
                        ],
                      ),
                    ),
                    middleWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizeConfig.verticalSpaceMedium(),
                        Text('Hi ${user?.name}',style: AppStyles.BlackStyleWithW500Font36(context).copyWith(fontWeight: FontWeight.w500),),
                        SizeConfig.verticalSpaceVeryGap(),
                        Text(AppStrings.FIND_YOUR_ANGEL.tr(),style: AppStyles.BlackStyleFont16W300(context)),
                        SizeConfig.verticalSpaceLarge(),
                        FittedBox(
                          child: Text('${AppStrings.LAST_LOGIN.tr()} '+
                              DateService.getDateFormatDdMMYyyyWithTime(DateTime.now().subtract(Duration(minutes: 15)).toIso8601String(), context),
                            style: AppStyles.BlackStyleFont16Light(context),maxLines: 1,),
                        ),
                        SizeConfig.verticalSpaceSmall(),
                      ],
                    )

                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
