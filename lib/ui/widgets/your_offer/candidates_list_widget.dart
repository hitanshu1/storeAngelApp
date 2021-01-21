import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_your_offer.dart';
import 'package:storeangelApp/ui/screens/consumer/courier_candidate_details_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/candidate_status_widget.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:easy_localization/easy_localization.dart';


class CandidatesListWidget extends StatelessWidget {
  final List<CourierCandidate>candidates;
  final OrderOrPurchases order;
  
  CandidatesListWidget({this.candidates,this.order});

  @override
  Widget build(BuildContext context) {
    return Consumer<YourOfferViewModel>(
        builder: (context,model,child){
          return SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, int index) {

                  return Padding(
                    padding: SizeConfig.tilesPadding,
                    child: GestureDetector(
                      onTap: (){
                        model.navigateToScreen(CourierCandidateDetailsScreen.routeName,
                        arguments: CourierCandidateDetailsArguments(
                          initialIndex: index,
                          candidates: candidates,
                          order: order
                        ));
                      },
                      child: CustomFiveWidgetsTile(
                          trailingTwoBackGroundColor: AppColors.amberGradient,
                          trailingOneBackGroundColor: AppColors.amberGradient,
                          enableFav: true,
                          isFav: candidates[index].favourite,
                          onToggleFav: (){
//                            model.onToggleFave(!candidates[index].favourite, candidates[index]);
                            candidates[index].favourite=!candidates[index].favourite;
                            model.setState(ViewState.Idle);
                          },
                          trailingOne: Center(
                            child: Icon(StoreangelIcons.timer,color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
                          ),
                          trailingTwo: FittedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('10',style: AppStyles.WhiteStyle_WithBold900_Font36,),
                                Text(AppStrings.ORDERS.tr(),style: AppStyles.WhiteStyle_FontSmall,)
                              ],
                            ),
                          ),
                          imageUrl: candidates[index].imageUrl,
                          middleWidget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizeConfig.verticalSpaceSmall(),
                              Row(
                                children: [
                                  Expanded(child: Text(AppStrings.OFFERS.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                                  Text(TimeAgoService.timeAgoSinceDate(DateTime.now().subtract(Duration(
                                      minutes: 15
                                  )), context),
                                    style: AppStyles.GrayStyleItalicFont16(context),),

                                ],
                              ),
                              SizeConfig.verticalSpaceSmall(),
                              Text(candidates[index].name,style: AppStyles.BlackStyleWithBold800Font_24(context),),
                              SizeConfig.verticalSpaceSmall(),
                              Text(AppStrings.euroSymbol+'${NumberService.priceAfterConvert(candidates[index].charge, context)}',
                              style: AppStyles.BlackStyleFont_20(context),),
                              SizeConfig.verticalSpaceSmall(),
                              FittedBox(
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        CustomRatingWidget(reviewCount: 15, initialRating: 2, stars: 3.5),
                                        SizeConfig.verticalSpaceSmall(),
                                        Text(AppStrings.DELIVERY_PERIOD.tr(),style: AppStyles.BlackStyleFont300_16(context),),
                                        Text(DateService.getDateFormatWithDay(DateTime.now().toIso8601String(), context),
                                          style: AppStyles.BlackStyleFont16Light(context),),
                                        Text('8:00 a.m. - 8:00 p.m.',style: AppStyles.BlackStyleFont16Light(context),)
                                      ],
                                    ),
                                    SizeConfig.horizontalSpaceSmall(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CandidateStatusWidget( active: candidates[index].approved, title: AppStrings.APPROVED.tr(),
                                            iconData: Icons.done),
                                        SizeConfig.verticalSpaceSmall(),
                                        CandidateStatusWidget( active: candidates[index].reliable, title: AppStrings.RELIABLE.tr(),
                                            iconData: StoreangelIcons.thumbsUp),
                                        SizeConfig.verticalSpaceSmall(),
                                        CandidateStatusWidget( active: candidates[index].insured, title: AppStrings.INSURED.tr(),
                                            iconData: StoreangelIcons.insurance_icon),
                                       ],
                                    ),
                                                                     ],
                                ),
                              ),
                              SizeConfig.verticalSpaceSmall(),

                            ],
                          )),
                    ),
                  );
                },
                childCount: candidates.length,
              ));
        });
  }
}
