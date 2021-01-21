import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/ui/screens/consumer/store_details_screen.dart';

import 'package:storeangelApp/ui/shared/view_app_Image.dart';

import 'customCard.dart';

class ViewStore extends StatelessWidget {
  final StoreDataModel store;
  final bool newOrder;
  final bool circularRadius;
  final Function onDelete;
  final int currentIndex;

  ViewStore({this.store, this.newOrder: false, this.circularRadius: true, this.onDelete,this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(StoreDetailsScreen.routeName,arguments: currentIndex);
        },
      child: CustomCard(
        child: Padding(
          padding: SizeConfig.smallerPadding,
          child: IntrinsicHeight(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*.004),
                  child: ViewAppImage(
                    imageUrl: store.image,
                    height: SizeConfig.smallerImageheight75*1.15,
                    width: SizeConfig.smallerImageheight75*1.15,
                    radius: 10,
                  ),
                ),
                SizeConfig.horizontalSpaceSmall(),
                Expanded(
                    child: Stack(
                  children: [
                    newOrder
                        ? Positioned(
                            right: 0,
                            top: 0,
                            child: Text(
                              AppStrings.MORE.tr(),
                              style: AppStyles.GreenStyleWithBold800_Font20(context),
                            ),
                          )
                        : Container(),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      top: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: SizeConfig.screenWidth*.5,
                            child: Text(
                              store.name,
                              maxLines: 1,
                              style: AppStyles.BlackStyleWithBold800Font_24(context).copyWith(
                                fontSize: SizeConfig.fontSizeLarger
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizeConfig.verticalSpace(2),
                          Text(
                            store.street,
                            style: AppStyles.GrayStyle_Font16(context),
                          ),
                          Text(
                            store.zipCity,
                            style: AppStyles.GrayStyle_Font16(context),
                          ),
                          SizeConfig.verticalSpaceSmall(),
                          FittedBox(
                            child: IntrinsicWidth(
                              child: Row(
                                children: [
                                  Text(
                                    '300 m',
                                    style: AppStyles.BlackStyleFont_14(context),
                                  ),
                                  Container(height: 16, child: VerticalDivider(color: AppColors.darkGrayColor)),
                                  Icon(StoreangelIcons.profile_consumer_tab, color: AppStyles.BlackStyleFont_14(context).color, size: AppStyles.BlackStyleFont_14(context).fontSize+1,),
                                  SizeConfig.horizontalSpace(5),
                                  Text(
                                    '1230',
                                    style: AppStyles.BlackStyleFont_14(context),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
