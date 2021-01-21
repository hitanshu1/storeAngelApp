import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/varify_status.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_orderpage.dart';
import 'package:storeangelApp/ui/screens/proposal_screen.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class ShowCandidatesList extends StatelessWidget {
  final List<CourierCandidate> candidates;
  final OrderPageViewModel model;
  final PurchaseDetails purchaseDetails;
  final int index;

  ShowCandidatesList({this.candidates, this.model, this.purchaseDetails, this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              SizeConfig.sidepadding.left, 0, SizeConfig.sidepadding.right, SizeConfig.bottomPadding.bottom),
          child: InkWell(
            onTap: () {
              model.navigateToScreen(ProposalScreen.routeName, context,
                  arguments: ProposalScreenArgument(
                      currentIndex: index, candidates: candidates, model: model, purchaseDatails: purchaseDetails));
            },
            child: CustomCard(
              child: Padding(
                padding: SizeConfig.paddingWihLittleHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ViewAppImage(
                      height: SizeConfig.smallImageHeight55,
                      width: SizeConfig.smallImageHeight55,
                      radius: SizeConfig.smallImageHeight55,
                      imageUrl: candidates[index].imageUrl,
                    ),
                    SizeConfig.horizontalSpaceSmall(),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Text(
                              candidates[index].name,
                              style: AppStyles.BlackStyleWithBold800Font_24(context),
                            )),
                            Text('${AppStrings.euro + ' '}${NumberService.priceAfterConvert(candidates[index].charge,context)}',
                                style: AppStyles.BlackStyleWithBold800Font_24(context))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              DateService.getDateFormatWithYear(candidates[index].date.toIso8601String(), context) +
                                  ' ${candidates[index].time}',
//                              '3. Dec 18:00 - 21:00',
                              style: AppStyles.BlackStyleFont_16(context),
                            )
                          ],
                        ),
                        SizeConfig.CVerticalSpaceSmallMediumC12(),
                        CustomRatingWidget(
                          reviewCount: candidates[index].reviews,
                          initialRating: candidates[index].stars.toDouble(),
                          stars: candidates[index].stars.roundToDouble(),
                        ),
                        SizeConfig.verticalSpaceSmall(),
                        Text(
                          '${candidates[index].totalOrder} (${candidates[index].completedOrders}) ${AppStrings.orders.tr()}',
                          style: AppStyles.BlackStyleFont_16(context),
                        ),
                        SizeConfig.verticalSpaceSmall(),
                        Row(
                          children: [
                            Text(
                              AppStrings.DELIVERY_PERIOD.tr(),
                              style: AppStyles.BlackStyleFont300_16(context),
                            ),
                            Flexible(
                              child: AutoSizeText(
                                ' ' +
                                    DateService.getDateFormatWithYear(candidates[index].date.toIso8601String(), context) +
                                    ' ${candidates[index].time}',
                                minFontSize: 6,
                                maxFontSize: AppStyles.BlackStyleFont_16(context).fontSize,
                                maxLines: 1,
                                style: AppStyles.BlackStyleFont_16(context),
                              ),
                            ),
                          ],
                        ),
                        SizeConfig.verticalSpaceSmall(),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                model.onToggleFav(candidates[index]);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    candidates[index].favourite ? Icons.favorite : Icons.favorite_border,
                                    color: AppColors.primaryColor,
                                    size: 24,
                                  ),
                                  SizeConfig.horizontalSpace(2),
                                  Text(
                                    '${AppStrings.FAVOURITE.tr()}',
                                    style: AppStyles.BlackStyleFont_16(context),
                                  ),
                                  SizeConfig.horizontalSpace(2),
                                  areOtherOptionsUpcoming(index)
                                      ? Container(height: 16, child: VerticalDivider(color: AppColors.darkGrayColor))
                                      : Container(),
                                ],
                              ),
                            ),
                            verifyWidget(candidates[index].verifyStatus, context, candidates[index].insurance),
                            candidates[index].insurance
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        StoreangelIcons.insurance_icon,
                                        size: 20,
                                        color: AppColors.primaryColor,
                                      ),
                                      SizeConfig.horizontalSpace(4),
                                      Text(
                                        '${AppStrings.INSURANCE.tr()}',
                                        style: AppStyles.BlackStyleFont_16(context),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget verifyWidget(VerifyStatus verifyStatus, BuildContext context, bool hasInsurance) {
    if (verifyStatus == VerifyStatus.Varified) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            StoreangelIcons.verified_icon,
            size: 20,
            color: AppColors.primaryColor,
          ),
          SizeConfig.horizontalSpace(4),
          Text('${AppStrings.VERIFIED.tr()}', style: AppStyles.BlackStyleFont_16(context)),
          Container(height: 16, child: VerticalDivider(color: AppColors.darkGrayColor)),
        ],
      );
    } else if (verifyStatus == VerifyStatus.Reliable) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            StoreangelIcons.verified_icon,
            size: 20,
            color: AppColors.blueVerifyColor,
          ),
          SizeConfig.horizontalSpace(4),
          Text(
            '${AppStrings.RELIABLE.tr()}',
            style: AppStyles.BlackStyleFont_16(context),
          ),
          hasInsurance ? Container(height: 16, child: VerticalDivider(color: AppColors.darkGrayColor)) : Container(),
        ],
      );
    } else {
      return Container();
    }
  }

  bool areOtherOptionsUpcoming(index) {
    return candidates[index].insurance ||
        candidates[index].verifyStatus == VerifyStatus.Reliable ||
        candidates[index].verifyStatus == VerifyStatus.Varified;
  }
}
