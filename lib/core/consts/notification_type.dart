
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/core/consts/appString.dart';

class NotificationType{
  static NotificationModel shareNotification=NotificationModel(
    notificationValue: 'share_notification',
    notificationText: AppStrings.SHARED_SMALL.tr()
  );
  static NotificationModel shoppingNotification=NotificationModel(
    notificationValue: 'shopping_notification',
    notificationText: AppStrings.SHOPPED_AT.tr(),
  );
}
class NotificationModel{
  String notificationValue;
  String notificationText;
  NotificationModel({this.notificationText,this.notificationValue});
}