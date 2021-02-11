import 'package:flutter/material.dart';
import 'package:flutter_group_sliver/flutter_group_sliver.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class SliverAppShapeWidget extends StatelessWidget {
  final Widget child;
  SliverAppShapeWidget({this.child});
  @override
  Widget build(BuildContext context) {
    return SliverGroupBuilder(
        decoration: BoxDecoration(
        color: Theme.of(context).toggleableActiveColor,
    borderRadius: SizeConfig.appItemShapeRadius,

    ),child: child,);
  }
}
