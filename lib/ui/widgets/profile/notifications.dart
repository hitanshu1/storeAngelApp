import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_notifications.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/search_appbar_widget.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
    final _profileModel = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        leading: BackButton(
          color: Theme.of(context).iconTheme.color,
          onPressed: () {
            _profileModel.changeView(ProfilePageView.home);
          },
        ),
        title: Text(
          AppStrings.NOTIFICATIONS.tr(),
          style: AppStyles.BlackStyleWithBold800Font_24(context),
          textAlign: TextAlign.center,
        ),
      ),
      body: BaseView<NotificationViewModel>(
        builder: (context, model, child) {
          if (model.state == ViewState.Busy) {
            return AppConstants.circulerProgressIndicator();
          } else {
            return ListView(
              children: [
                SizeConfig.verticalSpace(SizeConfig.bottomPadding.bottom*.5),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(AppStrings.ALLOW_NOTIFICATION.tr(), style: AppStyles.BlackStyleFont_20(context))),
                      SizeConfig.horizontalSpaceSmall(),
                      CupertinoSwitch(
                          value: model.notification,
                          onChanged: (value) {
                            model.changeNotification(value);
                          },
                          activeColor: AppColors.primaryColor,
                          trackColor: Theme.of(context).primaryColorLight)
                    ],
                  ),
                ),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Divider(
                    color: AppColors.lightGrayDotColor,
                  ),
                ),
                SizeConfig.CVerticalSpaceSmallMedium(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Row(
                    children: [
                      Expanded(
                          child:
                              Text(AppStrings.PRODUCT_FROM_MY_LIST.tr(), style: AppStyles.BlackStyleFont_20(context))),
                      SizeConfig.horizontalSpaceSmall(),
                      CupertinoSwitch(
                          value: model.outOfStock,
                          onChanged: (value) {
                            model.changeOutOfStock(value);
                          },
                          activeColor: AppColors.primaryColor,
                          trackColor: Theme.of(context).primaryColorLight)
                    ],
                  ),
                ),
                SizeConfig.CVerticalSpaceSmallMedium(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(AppStrings.NEW_MESSAGE.tr(), style: AppStyles.BlackStyleFont_20(context))),
                      SizeConfig.horizontalSpaceSmall(),
                      CupertinoSwitch(
                          value: model.newMessage,
                          onChanged: (value) {
                            model.changeNewMessage(value);
                          },
                          activeColor: AppColors.primaryColor,
                          trackColor: Theme.of(context).primaryColorLight)
                    ],
                  ),
                ),
                SizeConfig.CVerticalSpaceSmallMedium(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(AppStrings.DELIVERY_STATUS_CHANGED.tr(),
                              style: AppStyles.BlackStyleFont_20(context))),
                      SizeConfig.horizontalSpaceSmall(),
                      CupertinoSwitch(
                          value: model.deliveryStatus,
                          onChanged: (value) {
                            model.changeDeliveryStatus(value);
                          },
                          activeColor: AppColors.primaryColor,
                          trackColor: Theme.of(context).primaryColorLight)
                    ],
                  ),
                ),
                SizeConfig.CVerticalSpaceSmallMedium(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(AppStrings.COURIER_CANCELLED_AND_ORDER.tr(),
                              style: AppStyles.BlackStyleFont_20(context))),
                      SizeConfig.horizontalSpaceSmall(),
                      CupertinoSwitch(
                          value: model.cancelledOrder,
                          onChanged: (value) {
                            model.changeCancelledOrder(value);
                          },
                          activeColor: AppColors.primaryColor,
                          trackColor: Theme.of(context).primaryColorLight)
                    ],
                  ),
                ),
                SizeConfig.verticalSpaceSmall(),
              ],
            );
          }
        },
      ),
    );
  }
}
