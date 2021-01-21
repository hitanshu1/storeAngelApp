import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_candidate_details.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/candidate_status_widget.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:easy_localization/easy_localization.dart';


class CourierCandidateHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Consumer<CourierCandidateDetailsViewModel>(
        builder: (context,model,child){
          return Container(
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizeConfig.verticalSpace(SizeConfig.smallHeaderSize+SizeConfig.imageHeight160*.5),
                    AppHeader(
                      height: SizeConfig.smallHeaderSize,

                      isBack: true,
                    ),

                    Positioned.fill(child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomCard(
                        radius: SizeConfig.imageHeight160,
                        child: ViewAppImage(
                          height: SizeConfig.imageHeight160,
                          width: SizeConfig.imageHeight160,
                          radius: SizeConfig.imageHeight160,
                          imageUrl: model.currentCandidate.imageUrl,
                        ),
                      ),
                    ))
                  ],
                ),

                CarouselSlider.builder(
                    options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 10),
                        height: 150,
                        viewportFraction: 1,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          model.setSelectedIndex(index);
                        }
                    ),
                    itemCount: model.candidates.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: SizeConfig.innerpadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizeConfig.verticalSpaceSmall(),
                            Padding(
                              padding: SizeConfig.sidepadding,
                              child: Text(model.currentCandidate.name,style: AppStyles.BlackStyleWithBold800Font_20(context),),
                            ),
                            SizeConfig.verticalSpaceSmall(),
                            Padding(
                              padding: SizeConfig.sidepadding,
                              child: Text('1(1) '+AppStrings.ORDERS.tr(),style: AppStyles.BlackStyle_Font16(context),),
                            ),
                            SizeConfig.verticalSpaceSmall(),
                            Padding(
                              padding:SizeConfig.sidepadding,
                              child: CustomRatingWidget(reviewCount: 15, initialRating: 2, stars: 3.5),
                            ),
                            SizeConfig.verticalSpaceMedium(),

                            Padding(
                              padding: SizeConfig.sidepadding,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CandidateStatusWidget( active: model.currentCandidate.approved, title: AppStrings.APPROVED.tr(),
                                      iconData: Icons.done),
                                  CandidateStatusWidget( active: model.currentCandidate.reliable, title: AppStrings.RELIABLE.tr(),
                                      iconData: StoreangelIcons.thumbsUp),
                                  CandidateStatusWidget( active:  model.currentCandidate.insured, title: AppStrings.INSURED.tr(),
                                      iconData: StoreangelIcons.insurance_icon),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: model.candidates.map((url) {
                      int index = model.candidates.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: model.initialIndex == index
                              ? AppColors.primaryColor
                              : Theme.of(context).primaryColorLight,
                        ),
                      );
                    }).toList(),
                  ),
                )

              ],
            ),
          );
        });
  }
}
