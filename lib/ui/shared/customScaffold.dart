import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget appBar;
  final bool resizeToAvoidBottomInset;
  final Color backgroundColor;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final FloatingActionButtonAnimator floatingActionButtonAnimator;
  final bool extendBodyBehindAppBar;
  final Widget bottomNavigationBar;
  final GlobalKey scaffoldKey;

  const CustomScaffold(
      {Key key,
      this.body,
        this.scaffoldKey,
      this.appBar,
      this.resizeToAvoidBottomInset,
      this.backgroundColor,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.floatingActionButtonAnimator,
      this.extendBodyBehindAppBar = false,
      this.bottomNavigationBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeViewModel>(builder: (context, appThemeViewModel, child) {
      return Scaffold(
        key: scaffoldKey,
        body: appThemeViewModel.initialThemeSettings.isBackgroundImageActive &&
                appThemeViewModel.initialThemeSettings.backGroundImagePath != null
            ? _getBackgroundImage(appThemeViewModel, body)
            : body,
        appBar: appBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: NoScalingAnimation(),
      );
    });
  }

  Widget _getBackgroundImage(AppThemeViewModel appThemeViewModel, Widget child) {
    assert(appThemeViewModel.initialThemeSettings.backGroundImagePath != null,
        'the backgroundImagePath must never be null');
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: appThemeViewModel.initialThemeSettings.opacity??1,
            child: Image.file(
              File(appThemeViewModel.initialThemeSettings.backGroundImagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: child,
        )
      ],
    );
  }
}
