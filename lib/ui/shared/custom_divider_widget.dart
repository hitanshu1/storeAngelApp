import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';

class CustomDividerWidget extends StatelessWidget {
  final double height;
  final Color color;

  CustomDividerWidget({this.height: 5, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: color ??(Provider.of<AppThemeViewModel>(context).themeData == AppTheme.dark
          ? AppColors.backgroundColor
          : Theme.of(context).primaryColorLight),
    );
  }
}
