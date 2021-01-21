import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class OrderTradingWidgetShape extends StatelessWidget {
  final Widget child;
  final double width;
  final LinearGradient color;
  OrderTradingWidgetShape({this.width,this.color,@required this.child});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: width??SizeConfig.screenWidth*.16,
        decoration: BoxDecoration(
            gradient: color??AppColors.blackGradient
        ),
        child: child
      ),
    );
  }
}
