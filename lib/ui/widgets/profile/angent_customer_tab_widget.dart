import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';

class AgentCustomerTabWidget extends StatelessWidget {
  final bool isCustomer;
  final Function onSelectTap;
  AgentCustomerTabWidget({@required this.isCustomer,this.onSelectTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(SizeConfig.radiusSmall),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: [
            tabButtonWidget(context,icon: StoreangelIcons.profile_consumer_tab,isSelected: isCustomer,
                subtitle: AppStrings.THE_USER_MODE.tr(),

                iconLeft: true),
            tabButtonWidget(context,icon: StoreangelIcons.profile_courier_tab,
                isSelected: !isCustomer,iconLeft: false,subtitle: AppStrings.THE_COURIER_MODE.tr()),

          ],
        ),
      ),
    );
  }

  Widget tabButtonWidget(BuildContext context,{@required IconData icon,@required bool isSelected,@required bool iconLeft,@required String subtitle}){
    return Expanded(
      child: InkWell(
        onTap: onSelectTap,
        child: Container(
          decoration: BoxDecoration(
              gradient: isSelected?AppColors.primarySecondGradient:null,
              borderRadius: BorderRadius.circular(SizeConfig.radiusSmall)
          ),
          child: Padding(
            padding: SizeConfig.paddingWithHighVerticalSpace,
            child: iconLeft?FittedBox(
              child: Row(
                children: [
                  Icon(icon,color: isSelected?AppColors.whiteColor:Theme.of(context).focusColor,),
                  SizeConfig.horizontalSpaceSmall(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(isSelected?AppStrings.YOU_ARE_IN.tr():AppStrings.SWITCH_TO_THE.tr(),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: isSelected?AppStyles.WhiteStyle_Font20:AppStyles.GrayStyle_Font16(context),),
                      Text(subtitle,
                        textAlign: TextAlign.center,
                        style: isSelected?AppStyles.WhiteStyle_WithBold900_Font20:AppStyles.GrayStyle_Font20W800(context),),


                    ],
                  ),
                ],
              ),
            ):FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [


                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(isSelected?AppStrings.YOU_ARE_IN.tr():AppStrings.SWITCH_TO_THE.tr(),
                        textAlign: TextAlign.center,
                        style: isSelected?AppStyles.WhiteStyle_Font20:AppStyles.GrayStyle_Font16(context),),
                      Text(subtitle,
                        textAlign: TextAlign.center,
                        style: isSelected?AppStyles.WhiteStyle_WithBold900_Font20:AppStyles.GrayStyle_Font20W800(context),),
                    ],
                  ),
                  SizeConfig.horizontalSpaceSmall(),
                  Icon(icon,color: isSelected?AppColors.whiteColor:Theme.of(context).focusColor,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
