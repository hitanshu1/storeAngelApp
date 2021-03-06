import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class AppShapeItem extends StatelessWidget {
  final Widget child;
  final Color color;
  final BorderRadius borderRadius;
  AppShapeItem({this.child,this.color,this.borderRadius});
  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: borderRadius!=null?borderRadius:SizeConfig.appItemShapeRadius,
      child: Container(
        child: Material(
        type: MaterialType.card,

        shadowColor: Colors.black.withOpacity(.8),
        color: color??Theme.of(context).scaffoldBackgroundColor,
        elevation: AppConstants.cardElevation,
          child: child,
        ),
      ),
    );
  }
}
