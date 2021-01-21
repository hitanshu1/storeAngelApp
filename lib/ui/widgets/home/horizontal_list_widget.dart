import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/notification_type.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/enums/mobileSize.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/screens/consumer/share_notification_screen.dart';
import 'package:storeangelApp/ui/screens/purchase_screen.dart';
import 'package:storeangelApp/ui/shared/availability_bar.dart';
import 'package:storeangelApp/ui/shared/circleWidget.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:timeago/timeago.dart' as timeago;

class HorizontalListItemWidget extends StatelessWidget {
  final PurchaseDetails purchaseDetails;

  HorizontalListItemWidget({this.purchaseDetails});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: EdgeInsets.only(bottom: 3, left: 2, right: 2),
      child: InkWell(
        onTap: () async {
          if (purchaseDetails.notificationType == NotificationType.shareNotification.notificationValue) {
            await Navigator.of(context)
                .pushNamed(ShareNotificationScreen.routeName, arguments: purchaseDetails)
                .then((value) {});
          } else {
            StatusBarService.changeStatusBarColor(StatusBarType.DoubleGray, context);
            await Navigator.of(context).pushNamed(PurchaseScreen.routeName, arguments: purchaseDetails);
            StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizeConfig.horizontalSpaceSmall(),
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: ViewAppImage(
                imageUrl: purchaseDetails.customer.imageUrl,
                height: SizeConfig.smallImageHeight55,
                width: SizeConfig.smallImageHeight55,
                radius: SizeConfig.smallImageHeight55,
              ),
            ),
            SizeConfig.horizontalSpaceSmall(),
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.only(right: AppConstants.marginSmallLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            '${purchaseDetails.customer.name} ',
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.BlackStyleWithBold800Font_20(context),
                          ),
                        ),
                        Text(
                          purchaseDetails.notificationType == NotificationType.shoppingNotification.notificationValue
                              ? AppStrings.SHOPPED_AT.tr()
                              : AppStrings.SHARED_SMALL.tr(),
                          style: AppStyles.GrayStyle_Font16(context),
                        ),
                      ],
                    ),
                    SizeConfig.verticalSpace(5),
                    Text(
                      '${purchaseDetails.storeDetails.name}',
                      style: AppStyles.GreenStyleWithBold800_Font20(context),
                    ),
                    SizeConfig.verticalSpaceSmall(),
                    Text(
                      '${purchaseDetails.storeDetails.street}',
                      style: AppStyles.GrayStyle_Font16(context),
                    ),
                    SizeConfig.verticalSpace(5),
                    Text(
                      '${purchaseDetails.storeDetails.zipCity}',
                      style: AppStyles.GrayStyle_Font16(context),
                    ),
                    SizeConfig.verticalSpace(10),
                    SizeConfig.verticalSpaceSmall(),
                    SizeConfig.mobileSize==MobileSize.small?FittedBox(
                      child: IntrinsicWidth(
                        child: _indicatorRow(context),
                      ),
                    ):_indicatorRow(context),
                    SizeConfig.verticalSpace(10),
                    AvailabilityBar(products: purchaseDetails.products),
                  ],
                ),
              ),
            ),
          ],
        ),
        // ),
      ),
    );
  }

  Widget _indicatorRow(BuildContext context){
    return Row(
      children: <Widget>[
        Text(
          "${purchaseDetails.quantity}/10 items",
          style: AppStyles.BlackStyleFontWeightSmall_20(context),
        ),
        SizeConfig.horizontalSpaceSmall(),
        Padding(
          padding: const EdgeInsets.only(right:3.0),
          child: Text(
            timeago.format(purchaseDetails.time, locale: context.locale.languageCode),
            style: AppStyles.GrayStyle_Font16(context),
          ),
        ),
        Spacer(),
        CircleWidget(
          height: 17.5,
          width: 17.5,
          products: purchaseDetails.products,
          color: AppColors.green,
          style: AppStyles.WhiteStyle_Font16.copyWith(fontSize: 10),
          availableStatus: AvailableStatus.plenty,
        ),
        SizeConfig.horizontalSpace(5),
        CircleWidget(
          height: 17.5,
          width: 17.5,
          products: purchaseDetails.products,
          color: AppColors.amber.withOpacity(1),
          style: AppStyles.WhiteStyle_Font16.copyWith(fontSize: 10, color: AppColors.black),
          availableStatus: AvailableStatus.few,
        ),
        SizeConfig.horizontalSpace(5),
        CircleWidget(
          height: 17.5,
          width: 17.5,
          products: purchaseDetails.products,
          color: AppColors.red.withOpacity(1),
          style: AppStyles.WhiteStyle_Font16.copyWith(fontSize: 10),
          availableStatus: AvailableStatus.runOut,
        ),
      ],
    );
  }
}
