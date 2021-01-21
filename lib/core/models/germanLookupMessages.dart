import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:timeago/timeago.dart';

class GermanLookUpMessages with LookupMessages{
  @override
  String prefixAgo() => AppStrings.PREFIX_AGO.tr();
  @override
  String prefixFromNow() => AppStrings.PREFIX_FROM_NOW.tr();
  @override
  String suffixAgo() => AppStrings.SUFFIX_AGO.tr();
  @override
  String suffixFromNow() => AppStrings.SUFFIX_FROM_NOW.tr();
  @override
  String lessThanOneMinute(int seconds) => '$seconds ${seconds>1?AppStrings.LESS_THAN_ONE_MINUTES.tr():AppStrings.LESS_THAN_ONE_MINUTE.tr()}';
  @override
  String aboutAMinute(int minutes) => '${AppStrings.ABOUT_A_MINUTE.tr()} $minutes ${minutes>1?AppStrings.MINUTES.tr():AppStrings.MINUTE.tr()}';
  @override
  String minutes(int minutes) => '$minutes ${minutes>1?AppStrings.MINUTES.tr():AppStrings.MINUTE.tr()}';
  @override
  String aboutAnHour(int minutes) => AppStrings.ABOUT_AN_HOUR.tr();
  @override
  String hours(int hours) => '$hours ${hours>1?AppStrings.HOURS.tr():AppStrings.HOUR.tr()}';
  @override
  String aDay(int hours) => AppStrings.A_DAY.tr();
  @override
  String days(int days) => '$days ${days>1?AppStrings.DAYS.tr():AppStrings.DAY.tr()}';
  @override
  String aboutAMonth(int days) => AppStrings.ABOUT_A_MONTH.tr();
  @override
  String months(int months) => '${months>1?AppStrings.MONTHS.tr():AppStrings.MONTH.tr()}';
  @override
  String aboutAYear(int year) => AppStrings.ABOUT_A_YEAR.tr();
  @override
  String years(int years) => '${years>1?AppStrings.YEARS.tr():AppStrings.YEAR.tr()}';
  @override
  String wordSeparator() => ' ';

}