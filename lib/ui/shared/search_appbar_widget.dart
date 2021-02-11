import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool extraPadding;
  final String appbarHero = 'appBarHero';

  ///Here you have the freedom to give the appBar your own widget design
  final Widget child;

  ///Some more costumization options
  final double opacity;

  final double height;

  ///If true the appBar will show an backButton
  final bool hasBackButton;

  ///Icon before the text widget
  final IconData iconData;

  ///Text next to the back button
  final String title;

  ///Widgets after text widgets
  final Widget childrenNextToText;

  ///Should the title be centered;
  final bool centerTitle;

  final GestureTapCallback onpressed;

  ///Shows an icon on the right side of the appbar
  final Widget iconButtonRight;

  final Function onTapBackButton;

  //double _getTopMargin()=>AppConstant.isDeviceLarge?4+SizeConfig.screenHeight*.017:4+SizeConfig.screenHeight*.01;

  SearchAppBar(
      {this.child,
      this.onpressed,
      this.opacity: 0.83,
      this.height,
      this.hasBackButton: false,
      this.title,
      this.childrenNextToText,
      this.onTapBackButton,
      this.iconData,
      this.centerTitle: false,
      this.iconButtonRight,
      this.extraPadding: false});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 100),
      child: Hero(
        tag: appbarHero,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: SizeConfig.screenWidth,
            height: height ?? SizeConfig.appBarHeight,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Material(
                  color: Colors.transparent,
                  child: child == null
                      ? Padding(
                          padding: extraPadding ? SizeConfig.innerSidepadding : EdgeInsets.zero,
                          child: _getAppBarContent(context),
                        )
                      : child),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getAppBarContent(BuildContext context) => Padding(
        padding: EdgeInsets.only(
            bottom: SizeConfig.screenHeight * .0,
            top: SizeConfig.screenHeight * .03,
            left: SizeConfig.screenWidth * .03,
            right: SizeConfig.screenWidth * .03),
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(
            left: SizeConfig.screenWidth * 0.04,
            right: SizeConfig.screenWidth * 0.04,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppConstants.ContainerRoundCorner_Radius),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(AppConstants.ShadowBox_WithOpacity),
                spreadRadius: AppConstants.ShadowBox_SpreadRadius,
                blurRadius: AppConstants.ShadowBox_BlurRadius,
                offset: Offset(0, AppConstants.ShadowBox_Offset), // changes position of shadow
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: onpressed,
              child: AutoSizeText(
                title,
                style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: AppConstants.fontSizeSmall, fontWeight: FontWeight.bold),
                maxLines: 2,
                minFontSize: 8,
                maxFontSize: AppConstants.fontSizeSmall,
              ),
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => Size(double.infinity, SizeConfig.serachAppbarheight);
}
