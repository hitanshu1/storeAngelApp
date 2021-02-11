import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'date_service.dart';

class TimeAgoService{
  static String timeAgoSinceDate(DateTime date, BuildContext context, {bool numericDates = true}) {

    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if (difference.inDays > 8) {
      return DateService.getDateWithHourFormat(date.toIso8601String(), context);
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 ${AppStrings.WEEK_AGO.tr()}' : '${AppStrings.LAST_WEEK.tr()}';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} ${AppStrings.DAYS_AGO.tr()}';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 ${AppStrings.DAY_AGO.tr()}' : 'Today -${AppStrings.YESTERDAY.tr()}';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} ${AppStrings.HOURS_AGO.tr()}';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '${AppStrings.TODAY.tr()} -1 ${AppStrings.HOUR_AGO.tr()}' : '${AppStrings.TODAY.tr()} -${AppStrings.AN_HOUR_AGO.tr()}';
    } else if (difference.inMinutes >= 2) {
      return '${AppStrings.TODAY.tr()} - ${DateService.getMinutesString(context, difference.inMinutes)}';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '${AppStrings.TODAY.tr()} -1 ${AppStrings.MIN_AGO.tr()}' : '${AppStrings.TODAY.tr()} -${AppStrings.A_MIN_AGO.tr()}';
    } else if (difference.inSeconds >= 3) {
      return '${AppStrings.TODAY.tr()} -${difference.inSeconds} ${AppStrings.SECONDS_AGO.tr()}';
    }
      return '${AppStrings.TODAY.tr()} -${AppStrings.JUST_NOW.tr()}';

  }

  static String timeAgoFromPlugin(DateTime dateTime,BuildContext context){
    return timeago.format(dateTime,locale: context.locale.languageCode);
  }

}