import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/varify_status.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_viewcourier_candidate_details.dart';
import 'package:storeangelApp/ui/screens/order/check_out_page.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class ViewCourierCandidateDetails extends StatefulWidget {
  final OrderOrPurchases orderOrPurchases;

  ViewCourierCandidateDetails({
    this.orderOrPurchases,
  });

  @override
  _ViewCourierCandidateDetailsState createState() => _ViewCourierCandidateDetailsState();
}

class _ViewCourierCandidateDetailsState extends State<ViewCourierCandidateDetails> {
  CourierCandidate courierCandidate;

  @override
  void initState() {
    super.initState();
    courierCandidate = widget.orderOrPurchases?.candidates.first ?? CourierCandidate();
  }

  Widget paymentOption(String title, BuildContext context, {bool available: true}) {
    return Expanded(
      child: Container(
        width: SizeConfig.screenWidth * .34,
        height: 22,
        child: Padding(
          padding: SizeConfig.innersidepadding,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: available
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                        size: 18,
                      )
                    : Icon(
                        Icons.clear,
                        color: AppColors.red,
                        size: 18,
                      ),
              ),
              SizeConfig.horizontalSpaceSmall(),
              Expanded(
                child: Text(
                  title,
                  style: AppStyles.BlackStyleFont_16(context),
                  maxLines: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ViewCourierCandidateDetailsViewModel>(
      builder: (context, model, child) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ..._imageNameRatingWidget(context),
              ..._orderDescriptionDetail(context),
              _actionButtons(context, model)
            ],
          ),
        );
      },
    );
  }

  List<Widget> _imageNameRatingWidget(BuildContext context) {
    return [
      Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ViewAppImage(
              imageUrl: widget.orderOrPurchases.candidates.first.imageUrl,
              height: SizeConfig.screenHeight * .17,
              width: SizeConfig.screenHeight * .17,
              radius: SizeConfig.screenHeight * .17,
            ),
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.topLeft,
            child: widget.orderOrPurchases.candidates.first.verifyStatus != VerifyStatus.Unknown
                ? Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.screenHeight * .09,
                    ),
                    child: Icon(
                      StoreangelIcons.verified_icon,
                      size: SizeConfig.screenHeight * .035,
                      color: AppColors.blueVerifyColor,
                    ),
                  )
                : Container(),
          )),
          Positioned.fill(
              child: Align(
            alignment: Alignment.topLeft,
            child: widget.orderOrPurchases.candidates.first.verifyStatus != VerifyStatus.Unknown
                ? Padding(
                    padding: EdgeInsets.only(top: SizeConfig.screenHeight * .012, left: SizeConfig.screenHeight * .014),
                    child: Icon(
                      StoreangelIcons.verified_icon,
                      size: SizeConfig.screenHeight * .035,
                      color: AppColors.primaryColor,
                    ),
                  )
                : Container(),
          )),
          Positioned.fill(
              child: Align(
            alignment: Alignment.topLeft,
            child: widget.orderOrPurchases.candidates.first.verifyStatus != VerifyStatus.Unknown
                ? Container(
                    margin: EdgeInsets.only(top: SizeConfig.screenHeight * .05),
                    height: SizeConfig.screenHeight * .035,
                    width: SizeConfig.screenHeight * .035,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primaryColor),
                        color: Theme.of(context).cardColor),
                    child: Icon(Icons.check, color: AppColors.primaryColor, size: SizeConfig.screenHeight * .035 / 1.5),
                  )
                : Container(),
          )),
          Positioned.fill(
              child: Align(
            alignment: Alignment.topLeft,
            child: widget.orderOrPurchases.candidates.first.verifyStatus != VerifyStatus.Unknown
                ? Padding(
                    padding: EdgeInsets.only(top: SizeConfig.screenHeight * .13, left: SizeConfig.screenWidth * .03),
                    child: GestureDetector(
                      onTap: () {
                        courierCandidate.favourite = !(courierCandidate?.favourite ?? false);
                        setState(() {});
                      },
                      child: Icon(
                        courierCandidate.favourite ? StoreangelIcons.heart_full : StoreangelIcons.heart_outlined_icon,
                        size: SizeConfig.screenHeight * .035,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                : Container(),
          )),
        ],
      ),
      SizeConfig.CVerticalSpaceMedium25(),
      Text(
        widget.orderOrPurchases.candidates.first.name,
        style: AppStyles.BlackStyleWithBold800Font_24(context),
      ),
      SizeConfig.CVerticalSpaceMedium25(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomRatingWidget(
              reviewCount: widget.orderOrPurchases.candidates.first.reviews,
              initialRating: widget.orderOrPurchases.candidates.first.stars.toDouble(),
              stars: widget.orderOrPurchases.candidates.first.stars.roundToDouble()),
        ],
      ),
      SizeConfig.CVerticalSpaceSmallMediumC11(),
      Text(
        '${widget.orderOrPurchases.candidates.first.reviews} ${widget.orderOrPurchases.candidates.first.reviews > 1 ? AppStrings.REVIEWS.tr() : AppStrings.REVIEW.tr()} ${widget.orderOrPurchases.candidates.first.totalOrder} '
        '${widget.orderOrPurchases.candidates.first.totalOrder > 1 ? AppStrings.ORDERS.tr() : AppStrings.ORDER.tr()}',
        style: AppStyles.GrayStyle_Font16(context),
      ),
      SizeConfig.CVerticalSpacevMedium(),
    ];
  }

  List<Widget> _orderDescriptionDetail(BuildContext context) {
    return [
      SizeConfig.CVerticalSpaceSmallMedium(),
      Padding(
        padding: SizeConfig.sidepadding,
        child: SizedBox(
          height: 240,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(AppConstants.button_Radius)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizeConfig.verticalSpaceSmall(),
                      Text(
                        "${AppStrings.FEE.tr()}",
                        style: AppStyles.BlackStyleWithBold800Font_20(context),
                      ),
                      Padding(
                        padding: SizeConfig.innerpadding,
                        child: Container(
                          width: SizeConfig.screenWidth,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(AppConstants.ContainerRoundCorner_Radius),
                          ),
                          child: Center(
                              child: Text(
                            '${AppStrings.euro + ' '} ${NumberService.priceAfterConvert(widget.orderOrPurchases.candidates.first.charge,context)}',
                            style: AppStyles.BlackStyleWithBold_FontC20(context),
                          )),
                        ),
                      ),
                      Text(
                        AppStrings.TOTAL_SUM.tr(),
                        style: AppStyles.GrayStyle_Font16(context),
                      ),
                      Text(
                        '${AppStrings.euro + ' '}${NumberService.priceAfterConvert(3067,context)}',
                        style: AppStyles.BlackStyleWithBold600Font_20(context),
                      ),
                      Padding(
                        padding: SizeConfig.innerpadding,
                        child: Container(
                          width: SizeConfig.screenWidth,
                          height: 50,
                          child: Center(
                              child: Text(
                            AppStrings.PREPAYMENT.tr(),
                            style: AppStyles.BlackStyleFont_16(context),
                          )),
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(AppConstants.ContainerRoundCorner_Radius)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizeConfig.horizontalSpaceSmall(),
              Expanded(
                child: Container(
                  width: SizeConfig.screenWidth,
                  child: Column(
                    children: [
                      SizeConfig.CVerticalSpacevMedium(),
                      Text(
                        AppStrings.PAYMENT_METHODS.tr(),
                        style: AppStyles.BlackStyleWithBold800Font_20(context),
                      ),
                      SizeConfig.CVerticalSpaceSmallMedium(),
                      paymentOption(AppStrings.PAYPAL.tr(), context),
                      SizeConfig.CVerticalSpaceVarySmall(),
                      paymentOption(AppStrings.KLARNA.tr(), context, available: false),
                      SizeConfig.CVerticalSpaceVarySmall(),
                      paymentOption(AppStrings.GOOGLE_PAY.tr(), context),
                      SizeConfig.CVerticalSpaceVarySmall(),
                      paymentOption(AppStrings.APPLE_PAY.tr(), context),
                      SizeConfig.CVerticalSpaceVarySmall(),
                      paymentOption(AppStrings.CREDIT_CARDS.tr(), context),
                      SizeConfig.CVerticalSpaceVarySmall(),
                      paymentOption(AppStrings.CASH.tr(), context),
                      SizeConfig.CVerticalSpaceMedium(),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(AppConstants.button_Radius)),
                ),
              ),
            ],
          ),
        ),
      ),
      SizeConfig.CVerticalSpaceSmallMedium(),
      Padding(
        padding: SizeConfig.sidepadding,
        child: Container(
          width: SizeConfig.screenWidth,
          child: Column(
            children: [
              SizeConfig.CVerticalSpaceSmallMedium(),
              Text(
                AppStrings.DELIVERY_DATE.tr(),
                style: AppStyles.BlackStyleWithBold800Font_20(context),
              ),
              SizeConfig.CVerticalSpaceSmallMedium(),
              Padding(
                padding: SizeConfig.sidepadding,
                child: Container(
                  child: Padding(
                    padding: SizeConfig.padding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DateService.getDateFormatWithYear(DateTime(2020,10,11).toIso8601String(), context), style: AppStyles.BlackStyleWithBold800Font_20(context)),
                        SizeConfig.horizontalSpaceSmall(),
                        Center(
                          child: Text(
                            '18:00-21:00',
                            style: AppStyles.BlackStyleFont_20(context),
                          ),
                        )
                      ],
                    ),
                  ),
                  decoration:
                      BoxDecoration(color: Theme.of(context).backgroundColor, borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizeConfig.verticalSpace(20),
            ],
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(AppConstants.button_Radius)),
        ),
      ),
      SizeConfig.CVerticalSpaceSmallMedium(),
    ];
  }

  Widget _actionButtons(BuildContext context, ViewCourierCandidateDetailsViewModel model) {
    return Padding(
      padding: SizeConfig.bottomPadding,
      child: SizedBox(
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.padding.left, right: SizeConfig.padding.right),
              child: ButtonWidget(
                  radius: AppConstants.button_Radius,
                  fontSize: AppConstants.fontSizeSmall,
                  buttonColor: Theme.of(context).primaryColor,
                  buttonText: AppStrings.HIRE.tr(),
                  onPressed: () async {
                    StatusBarService.changeStatusBarColor(StatusBarType.Light, context);
                    await model.navigateToScreen(CourierCheckOutScreen.routeName, context,
                        arguments: CheckOutPageArgument(
                          orderOrPurchases: widget.orderOrPurchases,
                        ));
                    Future.delayed(
                        Duration.zero, () => StatusBarService.changeStatusBarColor(StatusBarType.Gray, context));
                  }),
            ),
            Padding(
              padding: SizeConfig.padding,
              child: ButtonWidget(
                  radius: AppConstants.button_Radius,
                  elevation: 0,
                  fontSize: AppConstants.fontSizeSmall,
                  buttonColor: Theme.of(context).scaffoldBackgroundColor,
                  buttonText: AppStrings.BACK.tr(),
                  textColor: Theme.of(context).focusColor,
                  onPressed: () {
                    Navigator.pop(context);}),
            ),
          ],
        ),
      ),
    );
  }
}
