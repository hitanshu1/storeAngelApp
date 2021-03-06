
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/core/consts/appString.dart';

class DateService{

  static String getFullDateFormat(String dateString,BuildContext context){

    var dateTime = DateTime.parse(dateString);
    String languageCode = Localizations.localeOf(context).languageCode;
    String date;
    if(languageCode=='de'){
      date='${DateFormat('dd. MMMM',languageCode).format(dateTime)} ${dateTime.year}';
    }else{
      date='${DateFormat('MMMM dd.',languageCode).format(dateTime)} ${dateTime.year}';
    }

    return date;
  }


  static String getDateFormat(String dateString,BuildContext context){

    var dateTime = DateTime.parse(dateString);
    String languageCode = Localizations.localeOf(context).languageCode;
    String date;
    if(languageCode=='de'){
      date='${DateFormat('dd. MMM',languageCode).format(dateTime)}';
    }else{
      date='${DateFormat('MMM dd.',languageCode).format(dateTime)}';
    }

    return date;
  }
  static String pickDate(DateTime picked,BuildContext context) {
    if (picked != null) {
      String formatted = DateFormat.yMMMMd(context.locale.toString()).format(picked);
      return formatted;
    }
    return '';
  }


  static String getDateFormatWithYear(String dateString,BuildContext context){

    var dateTime = DateTime.parse(dateString);
    String languageCode = Localizations.localeOf(context).languageCode;
    String date;
    if(languageCode=='de'){
      date='${DateFormat('dd. MMM yyyy',languageCode).format(dateTime)}';
    }else{
      date='${DateFormat('MMM dd. yyyy',languageCode).format(dateTime)}';
    }

    return date;
  }
  static String getDateFormatWithDay(String dateString,BuildContext context){

    var dateTime = DateTime.parse(dateString);
    String languageCode = Localizations.localeOf(context).languageCode;
    String date;
    if(languageCode=='de'){
      date='${DateFormat('EEEE, dd.MM.yyyy',languageCode).format(dateTime)}';
    }else{
      date='${DateFormat('EEEE, dd.MM.yyyy',languageCode).format(dateTime)}';
    }

    return date;
  }
  static String getDateFormatddMMyyyy(String dateString,BuildContext context){

    var dateTime = DateTime.parse(dateString);
    String languageCode = Localizations.localeOf(context).languageCode;
    String date;
    if(languageCode=='de'){
      date='${DateFormat('dd.MM.yyyy',languageCode).format(dateTime)}';
    }else{
      date='${DateFormat('dd.MM.yyyy',languageCode).format(dateTime)}';
    }

    return date;
  }
  static String getDateFormatDdMMYyyyWithTime(String dateString,BuildContext context){

    var dateTime = DateTime.parse(dateString);
    String languageCode = Localizations.localeOf(context).languageCode;
    String date;
    if(languageCode=='de'){
      date='${DateFormat('dd.MM.yyyy - kk:mm aa',languageCode).format(dateTime)}';
    }else{
      date='${DateFormat('dd.MM.yyyy - kk:mm aa',languageCode).format(dateTime)}';
    }

    return date;
  }
  static String getDateFormatDdMMYyyyWithTimeWord(String dateString,BuildContext context){

    var dateTime = DateTime.parse(dateString);
    String languageCode = Localizations.localeOf(context).languageCode;
    String date;
    if(languageCode=='de'){
      date='${DateFormat('dd.MMM.yyyy - kk:mm',languageCode).format(dateTime)}';
    }else{
      date='${DateFormat('dd.MMM.yyyy - kk:mm',languageCode).format(dateTime)}';
    }

    return date;
  }

  static String getDateWithHourFormat(String dateString, BuildContext context) {

    var dateTime = DateTime.parse(dateString);
    String languageCode = Localizations.localeOf(context).languageCode;

    String date;
    if(languageCode=='de'){
      date='${DateFormat('dd. MMM yyyy - kk:mm aa',languageCode).format(dateTime)}';
    }else{
      date='${DateFormat('MMM dd. yyyy - kk:mm aa',languageCode).format(dateTime)}';
    }
    return date;
  }
  static String getMinutesString(BuildContext context,int min){
    if(context.locale==Locale('de')){
      return 'var $min min';

    }

    return '$min '+AppStrings.MIN_AGO.tr();

  }

}