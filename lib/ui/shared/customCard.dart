import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final BorderSide side;
  final double elevation;
  final double radius;

  const CustomCard({Key key, this.child, this.margin, this.side, this.elevation,this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin??EdgeInsets.symmetric(horizontal: 2),
        child: Material(
          type: MaterialType.card,
          shadowColor: Colors.black.withOpacity(.65),
          color: Theme.of(context).cardColor,
          elevation: elevation??AppConstants.cardElevation,
          shape: RoundedRectangleBorder(
            side: side??BorderSide(color: Theme.of(context).cardColor),
              borderRadius: BorderRadius.circular(radius??AppConstants.ContainerRoundCorner_Radius),
          ),
            child: child,
          ),
    );
  }


}
