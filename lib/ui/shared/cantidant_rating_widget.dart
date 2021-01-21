import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/numberService.dart';

class CustomRatingWidget extends StatelessWidget {
  final int reviewCount;
  final double initialRating;
  final double stars;

  CustomRatingWidget({@required this.reviewCount,@required  this.initialRating,@required  this.stars});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${NumberService.addAfterCommaTwoZeros(stars.toString(),context)}',
          style: AppStyles.GrayStyle_Font16(context),
        ),
        SizeConfig.horizontalSpace(SizeConfig.screenWidth*.01),
        IgnorePointer(
          ignoring: true,
          child: FlutterRatingBar(
            initialRating: initialRating,
            itemCount: AppConstants.Ratingbar_item_count,
            itemSize: AppConstants.Ratingbar_itemSize,
            fillColor: AppColors.amber,
            borderColor: AppColors.grayFont,
            allowHalfRating: true,
            noRatingWidget: Icon(
              Icons.star,
              size: AppConstants.Ratingbar_itemSize?? 25.0,
              color: AppColors.grayFont,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ),
        SizeConfig.horizontalSpace(SizeConfig.screenWidth*.02),
        Icon(StoreangelIcons.user,size: SizeConfig.smallIconSize,color: AppColors.darkGrayLittleColor,),
        SizeConfig.horizontalSpace(SizeConfig.screenWidth*.01),
        Text(
          '$reviewCount ',
          style: AppStyles.GrayStyle_Font16(context),
        ),
      ],
    );
  }
}
