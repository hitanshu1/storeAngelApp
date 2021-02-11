import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/mobileSize.dart';
import 'package:storeangelApp/core/enums/premium_selected_tile.dart';
import 'package:storeangelApp/core/models/premium_tile.dart';
import 'package:storeangelApp/core/viewmodel/premiumViewModel.dart';

class SubscriptionWidgets extends StatefulWidget {
  @override
  _SubscriptionWidgetsState createState() => _SubscriptionWidgetsState();
}

class _SubscriptionWidgetsState extends State<SubscriptionWidgets> with TickerProviderStateMixin {
  final double _scale = 1.15;

  AnimationController _firstTileController;
  Animation<double> _firstTileAnimation;

  AnimationController _secondTileController;
  Animation<double> _secondTileAnimation;

  AnimationController _thirdTileController;
  Animation<double> _thirdTileAnimation;

  @override
  void initState() {
    super.initState();
    _firstTileController = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _firstTileAnimation = Tween<double>(begin: 1, end: 1.15).animate(_firstTileController);

    _secondTileController = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _secondTileAnimation = Tween<double>(begin: 1, end: 1.15).animate(_secondTileController);

    _thirdTileController = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _thirdTileAnimation = Tween<double>(begin: 1, end: 1.15).animate(_thirdTileController);

    Future.delayed(Duration.zero,(){
      _secondTileController.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _firstTileController.dispose();
    _secondTileController.dispose();
    _thirdTileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _height = SizeConfig.screenHeight * .27*(SizeConfig.mobileSize==MobileSize.small?1.2:1.0);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .04),
      child: SizedBox(
        height: _height,
        child: Consumer<PremiumViewModel>(builder: (context, premiumViewModel, child) {
          premiumViewModel.getSortedList(context, _buildPremiumTile);
          final List<Widget> _tileList = premiumViewModel.premiumTileList;
          return Stack(
          overflow: Overflow.visible,
          children: _tileList);
        }),
      ),
    );
  }

  Widget _buildPremiumTile(BuildContext context, PremiumTile premiumTile) {
    //Values for calculating the x position and width for the widget within the stack
    final double _relativeAreaMinusMargin = 1 - 0.04 * 2;
    final int _tileCount = 3;

    //If the left or right widget is selected than due to its increased size it has to be pushed slightly closer to the middle
    //which this value takes care of
    double _pushOuterSelectedTileToTheMiddleNumber = 0;
    if (premiumTile.tileName == PremiumSelectedTile.left && premiumTile.isSelected) {
      _pushOuterSelectedTileToTheMiddleNumber = (_scale - 1) / 2;
    } else if (premiumTile.tileName == PremiumSelectedTile.right && premiumTile.isSelected) {
      _pushOuterSelectedTileToTheMiddleNumber = -(_scale - 1) / 2;
    }

    final double _width = ((SizeConfig.screenWidth * _relativeAreaMinusMargin) / _tileCount);

    final double _xCoordinate = _width * premiumTile.stackPosition + _width * _pushOuterSelectedTileToTheMiddleNumber;

    return Positioned(
      top: 0,
      left: _xCoordinate,
      width: _width,
      child: GestureDetector(
        onTap: ()=>onTap(premiumTile),
        child: AnimatedBuilder(
          animation: _getAnimation(premiumTile.tileName),
          builder: (context, child) => Transform.scale(
            scale: _getScaleValue(premiumTile),
            child: child,
          ),
          child: _buildTileBody(premiumTile),
        ),
      ),
    );
  }

  Widget _buildTileBody(PremiumTile premiumTile) {
    return Align(
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: SizeConfig.appItemShapeRadius,
            boxShadow: premiumTile.isSelected?[BoxShadow(blurRadius: 3, offset: Offset(0,2), color: Colors.black.withOpacity(.25))]:[BoxShadow()],
            color: Theme.of(context).primaryColor,
            gradient: premiumTile.isSelected?AppColors.primaryGradient:AppColors.grayGradient,
            border: premiumTile.isSelected ? Border.all(color: Theme.of(context).cardColor,
            width: 5) : null,),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          SizeConfig.verticalSpaceMedium(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: AutoSizeText(
               AppStrings.STOREANGEL_PREMIUM.tr(),
                style: AppStyles.WhiteStyle_Font16.copyWith(fontSize: SizeConfig.fontSizeLarger,
                    color: premiumTile.isSelected?AppColors.whiteColor:AppColors.primaryColor),
                textAlign: TextAlign.center,
                maxFontSize: SizeConfig.fontSizeMedium,
                minFontSize: 10,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            AutoSizeText(
              premiumTile.header,
              style: AppStyles.WhiteStyle_WithBold900_Font20.copyWith(
                color: premiumTile.isSelected?AppColors.whiteColor:AppColors.primaryColor
              ),
              maxLines: 1,
              minFontSize: 10,
              maxFontSize: SizeConfig.fontSizeSmall,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * .01,
            ),
            Padding(
              padding: SizeConfig.sidelargepadding,
              child: Divider(
                color: premiumTile.isSelected ? Theme.of(context).cardColor : Theme.of(context).focusColor,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * .005,
            ),
            AutoSizeText(
              premiumTile.monthString,
              style: AppStyles.GrayStyle_Font16(context).copyWith(
                color: premiumTile.isSelected?AppColors.whiteColor:AppColors.grayFont
              ),
              maxLines: 1,
              minFontSize: 8,
              maxFontSize: SizeConfig.fontSizeSmaller,
            ),
            Text(
              premiumTile.price,
              style: AppStyles.GreenStyleWithBold800_Font30(context).copyWith(
                color: premiumTile.isSelected?AppColors.whiteColor:AppColors.primaryColor
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: AutoSizeText(
                premiumTile.paymentType+'/'+AppStrings.MONTHLY.tr(),
                style: AppStyles.GrayStyle_Font16(context).copyWith(
                  color:premiumTile.isSelected?AppColors.whiteColor:AppColors.grayFont
                ),
                maxLines: 2,
                minFontSize: 8,
                maxFontSize: SizeConfig.fontSizeSmaller,
                textAlign: TextAlign.center,
              ),
            ),
            SizeConfig.verticalSpaceSmall(),

            premiumTile.tileName==PremiumSelectedTile.middle?Padding(
              padding:SizeConfig.sidepadding,
              child: Row(
                children: [
                  Icon(StoreangelIcons.madel,color: AppColors.whiteColor,size: SizeConfig.iconSize,),
                  AutoSizeText(
                    AppStrings.BEST_SELLER.tr() ,
                    style: AppStyles.WhiteStyle_Font20.copyWith(fontSize: SizeConfig.fontSizeSmall,
                    ),
                    maxLines: 1,
                    minFontSize: 5,
                    maxFontSize: SizeConfig.fontSizeSmall,
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ):Container(height:  SizeConfig.iconSize,),
            SizeConfig.verticalSpaceMedium(),

          ],
        ),
      ),
    );
  }



  void onTap(PremiumTile premiumTile){
    switch(premiumTile.tileName){
      case PremiumSelectedTile.left:
        _firstTileController.forward();
        _secondTileController.reverse();
        _thirdTileController.reverse();
        break;
      case PremiumSelectedTile.middle:
        _firstTileController.reverse();
        _secondTileController.forward();
        _thirdTileController.reverse();
        break;
      case PremiumSelectedTile.right:
        _firstTileController.reverse();
        _secondTileController.reverse();
        _thirdTileController.forward();
        break;
    }
    Provider.of<PremiumViewModel>(context, listen: false).setPremiumSelectedTile = premiumTile.tileName;
  }

  Animation _getAnimation(PremiumSelectedTile tileName) {
    switch (tileName) {
      case PremiumSelectedTile.left:
        return _firstTileAnimation;
      case PremiumSelectedTile.middle:
        return _secondTileAnimation;
      case PremiumSelectedTile.right:
        return _thirdTileAnimation;
      default:
        return null;
    }
  }

  double _getScaleValue(PremiumTile premiumTile) {
    switch (premiumTile.tileName) {
      case PremiumSelectedTile.left:
        return _firstTileAnimation.value;
      case PremiumSelectedTile.middle:
        return _secondTileAnimation.value;
      case PremiumSelectedTile.right:
        return _thirdTileAnimation.value;
      default:
        return 0;
    }
  }
}