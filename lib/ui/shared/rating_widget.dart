import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/mobileSize.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/widgets/orderDelivered/rating_dialog_widget.dart';

class RatingWidget extends StatelessWidget {
  ///Header which is above the object name
  final String objectHeader;

  ///Specific name of the object
  final String objectName;

  ///Rating which the user selects
  final Function(double) onRatingUpdate;

  final TextStyle headerStyle;

  const RatingWidget(
      {Key key,
      @required this.objectName,
      @required this.onRatingUpdate,
      @required this.objectHeader,
      this.headerStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

//        SizeConfig.verticalSpaceSmall(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CustomRatingWidget(reviewCount: 10, initialRating: 5, stars: 5),
            TextButton(
              onPressed: () => onTap(context),
              child: AutoSizeText(
                AppStrings.RATE_NOW.tr(),
                maxLines: 1,
                minFontSize: 6,
                maxFontSize: AppStyles.GrayStyle_FontMedium(context).fontSize,
                style: AppStyles.GreenStyleWithBold800_Font20(context),
              ),
            ),
          ],
        ),

      ],
    );
  }

  void onTap(BuildContext context) {
    MyUtils.showAppDialog(
        context: context,
        child: RatingDialogWidget(
          header: objectHeader,
          rateObjectName: objectName,
          onRatingUpdate: onRatingUpdate,
          onPressOK: () => Navigator.pop(context),
        ));
  }
}
