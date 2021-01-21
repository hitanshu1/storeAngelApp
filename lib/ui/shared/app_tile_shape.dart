import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class AppTileShape extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isReverse;
  AppTileShape({this.child,this.color,this.isReverse:false});
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: isReverse?SizeConfig.appReverseItemShapeRadius:SizeConfig.appItemShapeRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 10.0), // shadow direction: bottom right
          )
        ],
      ),
      child: ClipRRect(
          borderRadius: isReverse?SizeConfig.appReverseItemShapeRadius:SizeConfig.appItemShapeRadius,
          child: child),
    );
  }
}
