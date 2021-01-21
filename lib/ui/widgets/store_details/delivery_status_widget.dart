import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class DeliveryStatusWidget extends StatefulWidget {
  final int step;
  DeliveryStatusWidget({this.step:1});

  @override
  _DeliveryStatusWidgetState createState() => _DeliveryStatusWidgetState();
}

class _DeliveryStatusWidgetState extends State<DeliveryStatusWidget> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  ColorTween _colorTween;
  Animation<Color> _colorTweenAnimation;

  @override
  void initState() {

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _colorTween = ColorTween(begin:  AppColors.grayFont, end: AppColors.primaryColor);
    _colorTweenAnimation = _colorTween.animate(_animationController);
    _animationController.forward();
    super.initState();
  }

  void redraw(Color beginColor, Color endColor) {
    setState(() {
      _colorTween = ColorTween(begin: beginColor, end: endColor);

      _colorTweenAnimation = _colorTween.animate(_animationController);
    });
  }

  Future<void> changeColorController;
  @override
  void dispose() {
    _animationController.dispose();
    disposed = true;
    super.dispose();
  }

  bool disposed = false;

  IconData get _iconData{
    if(widget.step==2){
      return StoreangelIcons.calculator_icon;

    }else if(widget.step==3){
      return Icons.done;

    }else{
      return StoreangelIcons.location_pin;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      radius:SizeConfig.smallImageheight ,
      child: Container(
        height: SizeConfig.smallImageheight,

//        child: CircularPercentIndicator(
//          radius: 45.0,
//          lineWidth: 10.0,
//          percent: 0.60,
//          center: new Text("60%"),
//          progressColor: Colors.yellow,
//        ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Stack(
          children: [
            Positioned.fill(child: Align(
              alignment: Alignment.topLeft,
              child: AnimatedBuilder(
                animation: _colorTweenAnimation,
                builder: (context,child){
                  return ViewAppImage(
                    color: widget.step>2?_colorTweenAnimation.value:null,
                    height:SizeConfig.smallImageheight*.6,
                    assetUrl: AssetsPath.grayIndicatorLeft,
                  );
                },
              ),
            )),
            Positioned.fill(child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedBuilder(
                animation: _colorTweenAnimation,
                builder: (context,child){
                  return ViewAppImage(
                    color: widget.step>1?_colorTweenAnimation.value:null,
                    height:SizeConfig.smallImageheight*.27,
                    assetUrl: AssetsPath.grayIndicatorBottom,
                  );
                },
              ),
            )),
            Positioned.fill(child: Align(
              alignment: Alignment.topRight,
              child: ViewAppImage(
                height:SizeConfig.smallImageheight*.6,
                assetUrl: AssetsPath.greenIndicatorRight,
              ),
            )),
            Positioned.fill(child: Align(
              alignment: Alignment.center,
              child: Icon(_iconData,color: AppColors.black,),
            ))
          ],
        ),
      ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.whiteColor
        ),
      ),
    );
  }
}
