import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/address.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
class ViewAddress extends StatelessWidget {
  final AddressModel address;
  ViewAddress({this.address});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  SizeConfig.padding.copyWith(bottom: SizeConfig.bottomPadding.bottom, top: 0),
      child: CustomCard(
        child:Padding(
          padding: SizeConfig.smallpadding,
          child: Column(
            children: [
              SizeConfig.verticalSpaceSmall(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, size: SizeConfig.fontSizeLarge,),
                  SizeConfig.horizontalSpaceSmall(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${address.name}',style: AppStyles.BlackStyleWithBold800Font_20(context),),
                        SizeConfig.verticalSpaceSmall(),
                        Text('${address.state} ${address.country}',
                        style: AppStyles.GrayStyleWithBold500_Font16(context),),
                        Container(
                          height: 12,
                          child: Divider(color: AppColors.lightGreyColor,
                          thickness: 1,),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(AppStrings.APARTMENT.tr(),style: AppStyles.BlackStyleFont_16(context),),
                                SizeConfig.verticalSpaceSmall(),
                                Text('${address.apartment}',style: AppStyles.BlackStyleFont_16(context)),

                              ],
                            ),
                            SizeConfig.horizontalSpaceMedium(),
                            Column(
                              children: [
                                Text(AppStrings.ENTRANCE.tr(),style: AppStyles.BlackStyleFont_16(context)),
                                SizeConfig.verticalSpaceSmall(),
                                Text('${address.entrance}',style: AppStyles.BlackStyleFont_16(context)),

                              ],
                            ),
                            SizeConfig.horizontalSpaceMedium(),
                            Column(
                              children: [
                                Text(AppStrings.FLOOR.tr(),style: AppStyles.BlackStyleFont_16(context)),
                                SizeConfig.verticalSpaceSmall(),
                                Text('${address.floor}',style: AppStyles.BlackStyleFont_16(context)),

                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizeConfig.verticalSpaceSmall()
            ],
          ),
        ),
      ),
    );
  }
}
