import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_ratingdialog.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';

class RatingDialogWidget extends StatelessWidget {
  ///Header which tells us what we will rate
  final String header;

  ///Name of the object which will be rated by the user
  final String rateObjectName;

  ///This is what happens when the user selects an rating
  final Function(double) onRatingUpdate;

  final Function onPressOK;

  RatingDialogWidget(
      {@required this.header, @required this.rateObjectName, @required this.onRatingUpdate, @required this.onPressOK});

  @override
  Widget build(BuildContext context) {
    return BaseView<RatingDialogViewModel>(
      builder: (context, ratingDialogProvider, child) {
        return Padding(
          padding: SizeConfig.padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizeConfig.verticalSpaceMedium(),
              Text(
                header,
                style: AppStyles.BlackStyleWithBold_Font36(context),
                textAlign: TextAlign.center,
              ),
              SizeConfig.verticalSpaceSmall(),
              Text(rateObjectName),
              SizeConfig.verticalSpaceMedium(),
              FlutterRatingBar(
                onRatingUpdate: onRatingUpdate,
                itemCount: 5,
                initialRating: 5,
                borderColor: Theme.of(context).textTheme.headline4.color,
                fillColor: Theme.of(context).primaryColor,
              ),
              SizeConfig.verticalSpaceMedium(),
              SizeConfig.verticalSpaceVerySmall(),
              Row(
                children: [
                  Expanded(
                      child: ButtonWidget(
                          radius: 15,
                          fontSize: 16,
                          buttonColor: Theme.of(context).primaryColorLight,
                          buttonText: AppStrings.BACK.tr(),
                          textColor: Theme.of(context).focusColor,
                          onPressed: () {
                            ratingDialogProvider.navigatorPop();
                          })),
                  SizeConfig.horizontalSpaceMedium(),
                  Expanded(
                      child: ButtonWidget(
                          radius: 15,
                          fontSize: AppStyles.WhiteStyle_WithBold700_Font20.fontSize,
                          fontWeight: FontWeight.w700,
                          buttonColor: Theme.of(context).primaryColor,
                          buttonText: AppStrings.SEND.tr(),
                          onPressed: onPressOK))
                ],
              ),
              SizeConfig.verticalSpaceMedium(),
            ],
          ),
        );
      },
    );
  }
}
