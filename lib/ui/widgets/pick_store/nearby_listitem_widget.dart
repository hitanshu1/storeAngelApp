import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/pickStore_viewmodel.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:easy_localization/easy_localization.dart';

class NearbyListItem extends StatelessWidget {
  final PickStoreViewModel model;
  final List<StoreDataModel> searchStoreList;
  final int index;

  NearbyListItem({this.searchStoreList, this.model, this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        model.storeItemTapped(model.searchList[index]);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: SizeConfig.bottomPadding.bottom),
        child: CustomCard(
          child: Padding(
            padding: SizeConfig.paddingC13,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ViewAppImage(
                        imageUrl: model.searchList[index].image,
                        height: SizeConfig.screenHeight * .11,
                        width: SizeConfig.screenHeight * .11,
                        radius: AppConstants.ContainerRoundCorner_Radius,
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth * .04,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    child: Text(
                                      model.searchList[index].name,
                                      style: AppStyles.BlackStyleWithBold_Font30(context)
                                          .copyWith(fontSize: SizeConfig.fontSizeLarger + 2),
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: SizeConfig.screenWidth * .08,
                                    height: SizeConfig.screenWidth * .08,
                                    child: CircularCheckBox(
                                      inactiveColor: Theme.of(context).textTheme.bodyText2.color,
                                      activeColor: Theme.of(context).primaryColor,
                                      value: model.selectedStoreList.contains(model.searchList[index]),
                                      onChanged: (boolVal) => model.storeItemTapped(model.searchList[index]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizeConfig.verticalSpaceVerySmall(),
                            Flexible(
                              child: Text(
                                model.searchList[index].street,
                                style: AppStyles.BlackStyleFont_14(context).copyWith(color: AppColors.darkGrayColor),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            SizeConfig.verticalSpaceVerySmall(),
                            Flexible(
                              child: Text(
                                model.searchList[index].zipCity,
                                style: AppStyles.BlackStyleFont_14(context).copyWith(color: AppColors.darkGrayColor),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            SizeConfig.VerticalSpaceSmallMedium(),
                            Flexible(
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: SizeConfig.screenWidth * .02),
                                    child: Text(
                                      "300 m",
                                      style:
                                          AppStyles.BlackStyleFont_14(context).copyWith(color: AppColors.primaryColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: SizeConfig.screenWidth * .02),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(
                                          StoreangelIcons.profile_consumer_tab,
                                          size: AppConstants.TextField_Contentpading,
                                        ),
                                        Text(
                                          ' ' + model.searchList[index].txtZip,
                                          style: AppStyles.BlackStyleFont_14(context),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizeConfig.verticalSpaceVerySmall(),
                            Divider(
                              color: Provider.of<AppThemeViewModel>(context).themeData == AppTheme.dark
                                  ? AppColors.thirdDarkColor
                                  : Theme.of(context).primaryColorLight,
                            ),
                            SizeConfig.verticalSpaceVerySmall(),
                            Row(
                              children: [
                                Text(
                                  AppStrings.TOPLISTS.tr() + ': 8',
                                  style: AppStyles.BlackStyleFont_16(context),
                                ),
                                Spacer(),
                                Text(
                                  AppStrings.USAGE.tr() + ': 21',
                                  style: AppStyles.BlackStyleFont_16(context),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
