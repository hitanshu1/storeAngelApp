import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:storeangelApp/ui/screens/list_users_screen.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_offers/courier_order_dialog.dart';


class WatchListAppBar extends StatelessWidget {
  final PurchaseDetails purchaseDetails;
  final double radius;

  WatchListAppBar({this.purchaseDetails, @required this.radius});

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.OffGray, context);
    return CustomSliverAppBar(
      backgroundColor: Theme.of(context).cardColor,
      pinned: true,

      floating: false,
      leading: BackButton(
                  color: Theme.of(context).iconTheme.color,
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      title: AutoSizeText(
        purchaseDetails.listName,
        maxLines: 1,
        minFontSize: 8,
        maxFontSize: AppStyles.BlackStyleWithBold800Font_24(context).fontSize,
        style: AppStyles.BlackStyleWithBold800Font_24(context),
      ),
      centerTitle: false,
      actions: [
        SizeConfig.horizontalSpaceSmall(),
        IconButton(
          icon: Icon(
            Icons.edit,
            color: AppColors.primaryColor,
          ),
          iconSize: SizeConfig.iconSize,
          onPressed: (){
            Navigator.of(context).pushNamed(ListUsersScreen.routeName).then((value){
              StatusBarService.changeStatusBarColor(StatusBarType.OffGray,context);
            });

          },
        ),
        IconButton(
          icon: Icon(
            StoreangelIcons.share_icon,
            color: AppColors.primaryColor,
          ),
          iconSize: SizeConfig.iconSize,
          onPressed: (){
            Navigator.of(context).pushNamed(ListUsersScreen.routeName).then((value){
              StatusBarService.changeStatusBarColor(StatusBarType.OffGray,context);
            });

          },
        ),
        IconButton(
          onPressed: (){
            MyUtils.showAppDialog(
              context: context,
              child: CustomDialog(
                title: AppStrings.DO_YOU_REALLY_WANT_TO_DELETE_WATCHLIST.tr(),
                subTitle: AppStrings.DELETE_WATCHLIST_NOW.tr(),
                onPressOk: (){
                  Navigator.pushNamed(context, LandingScreen.routeName, arguments: LandingScreenArgument(index: 1));
                },
              )
            );
          },
          iconSize: SizeConfig.iconSize,
          icon: Icon(
            StoreangelIcons.delete_icon,
            color: AppColors.green,
          ),
        ),
      ],
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))),
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: AppBar().preferredSize.height,),
            Spacer(flex: 2,),
            Padding(
              padding: SizeConfig.sidepadding,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        ViewAppImage(
                          height: SizeConfig.screenWidth*.15,
                          width: SizeConfig.screenWidth*.15,
                          radius: 10,
                          imageUrl: purchaseDetails.storeDetails.image,
                        ),
                      ],
                    ),
                    SizeConfig.horizontalSpaceSmall(),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            purchaseDetails.storeDetails.name,
                            style: AppStyles.BlackStyleWithBold800Font_20(context),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            purchaseDetails.storeDetails.street,
                            style: AppStyles.GrayStyle_Font16(context),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            purchaseDetails.storeDetails.zipCity,
                            style: AppStyles.GrayStyle_Font16(context),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      expandedHeight: SizeConfig.adaptiveHeight(SizeConfig.screenHeight*.17),
    );
  }
}
