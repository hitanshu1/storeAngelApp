import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/mobileSize.dart';

class ProfileRating extends StatelessWidget {
  final double initialRating;
  final double ratingAverage;
  final int ratingCount;

  const ProfileRating({Key key,@required
  this.initialRating,@required
  this.ratingAverage,@required
  this.ratingCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IgnorePointer(
          ignoring: true,
          child: FlutterRatingBar(
            onRatingUpdate: (val) {},
            itemCount: 5,
            initialRating: initialRating,
            allowHalfRating: true,
            itemSize: SizeConfig.mobileSize == MobileSize.small ? 24 : 30,
            borderColor: Theme.of(context).cardColor,
            fillColor: Theme.of(context).primaryColor,
          ),
        ),
        SizeConfig.verticalSpaceSmall(),
        Text('Ø${ratingAverage.toStringAsFixed(1).replaceAll('.', ',')} ($ratingCount)', style: AppStyles.GrayStyleWithBold500_Font16(context).copyWith(fontSize: SizeConfig.fontSizeLarge),)
      ],
    );
  }
}
