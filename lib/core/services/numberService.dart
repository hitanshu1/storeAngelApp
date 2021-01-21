import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/rating_model.dart';

class NumberService {
  static String priceAfterConvert(double price, BuildContext context) {
    return convertNumber(price.toString(), context);
  }

  static String ratingAfterConvert(double rating, BuildContext context) {
    return convertNumber(rating.toString(), context);
  }

  static String addAfterCommaTwoZeros(String num, BuildContext context) {
    if (num.contains(RegExp(r'(^[0-9]+,|.?[0-9]{0,2})'))) {
      return convertNumber(num, context);
    }
    return '';
  }

  static getDollarOrEuroHintText(BuildContext context){

    Locale locale = context.locale;
    if (locale == Locale.fromSubtags(languageCode: 'de')) {
      return AppStrings.EUROHINTTEXT.tr();
    } else {
      return AppStrings.DOLLAR_HINT_TEXT.tr();
    }
  }

  static String convertNumber(String num, BuildContext context) {
    String newNum;
    String _numberDecimalDivider;
    String _numberFullDivider;

    Locale locale = context.locale;
    if (locale.languageCode.toString()=='en') {
      _numberDecimalDivider = ',';
      _numberFullDivider = ',';
    } else {
      _numberDecimalDivider = ',';
      _numberFullDivider = ',';
    }

    final List<String> stringCommaList = num.split(RegExp(r'[,|.]'));
    final String afterCommaString = stringCommaList.length == 2 ? stringCommaList.last : '';

    newNum = stringCommaList.first;
    if ((newNum?.isEmpty ?? true)) newNum = '0';
    newNum = _convertNewNum(newNum, _numberFullDivider);

    switch (afterCommaString.length) {
      case 0:
        return newNum += '${_numberDecimalDivider}00';
      case 1:
        return newNum += _numberDecimalDivider + stringCommaList.last[0] + '0';
      case 2:
        return newNum += _numberDecimalDivider + stringCommaList.last;
      default:
        return newNum += _numberDecimalDivider + stringCommaList.last.substring(0, 2);
    }
  }

  static String _convertNewNum(String newNum, String _numberFullDivider){
    switch (newNum.length) {
      case 4:
        return newNum[0] + _numberFullDivider + newNum.substring(1, newNum.length);
        break;
      case 5:
        return newNum.substring(0, 1) + _numberFullDivider + newNum.substring(2, newNum.length);
        break;
      case 6:
        return newNum.substring(0, 2) + _numberFullDivider + newNum.substring(3, newNum.length);
        break;
      case 7:
        return newNum.substring(0, 3) + _numberFullDivider + newNum.substring(4, newNum.length);
        break;
      case 8:
        return newNum[0] +
            _numberFullDivider +
            newNum.substring(1, 4) +
            _numberFullDivider +
            newNum.substring(5, newNum.length);
        break;
      default: return newNum;
    }
  }

  static double averageRating(List<RatingModel> ratings) {
    if (ratings != null) {
      return ratings.map((m) => m.rating).reduce((a, b) => a + b) / ratings.length;
    } else {
      return 0;
    }
  }

  static String totalPrice(List<Product> products, BuildContext context) {
    double _totalPrice = 0;
    products.forEach((element) {
      _totalPrice = _totalPrice + (element.price * element.quantity);
    });

    var f = new NumberFormat("###.##", "en_US");
    final String _result = f.format(_totalPrice);
    return convertNumber(_result, context);
  }
  static int getAvailableProduct(List<Product>products,AvailableStatus availableStatus){
    int _number=0;
    products.forEach((element) {
      if(element.availableStatus==availableStatus){
        _number++;
      }
    });
    return _number;
  }
}
