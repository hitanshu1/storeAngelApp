import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class AppRatingWidget extends StatelessWidget {
  final bool enable;
  final double initialRating;
  final int maxRating;
  final double size;
  AppRatingWidget({this.enable:true,@required this.initialRating,@required this.maxRating,
  this.size});
  @override
  Widget build(BuildContext context) {
    return FlutterRatingBar(onRatingUpdate: (val){},
      ignoreGestures: !enable,itemCount: maxRating,
      initialRating: initialRating,
      itemSize: size??SizeConfig.screenHeight*.015,
      borderColor: Theme.of(context).textTheme.headline4.color,
      fillColor: Theme.of(context).primaryColor,
    );
  }
}
