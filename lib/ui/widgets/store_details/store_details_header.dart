import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_store_details.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class StoreDetailsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreDetailsViewModel>(

        builder: (context,model,child){
          return SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizeConfig.verticalSpace(SizeConfig.smallHeaderSize+SizeConfig.imageHeight160*.5),
                      AppHeader(
                        height: SizeConfig.smallHeaderSize,
                        isBack: true,
                      ),
                      Positioned.fill(child:Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomCard(
                          elevation: 20,
                          radius:SizeConfig.imageHeight160 ,
                          child: ViewAppImage(
                            height: SizeConfig.imageHeight160,
                            width: SizeConfig.imageHeight160,
                            radius: SizeConfig.imageHeight160,
                            imageUrl: model.currentStore.image,
                          ),
                        ),
                      ))
                    ],
                  ),
                  CarouselSlider.builder(
                      options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 10),
                          height: 70,
                          viewportFraction: 1,
                          enlargeCenterPage: false,
                          onPageChanged: (index, reason) {
                            model.setSelectedIndex(index);
                          }
                      ),
                      itemCount: model.stores.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: SizeConfig.padding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SizeConfig.verticalSpaceSmall(),
                              Text(model.currentStore.name,style: AppStyles.BlackStyleWithBold800Font_20(context),),
                              SizeConfig.verticalSpaceSmall(),
                              CustomRatingWidget(reviewCount: 6, initialRating: 3, stars: 14)

                            ],
                          ),
                        );
                      }),

                  Container(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: model.stores.map((url) {
                        int index = model.stores.indexOf(url);
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
                  ),
                  SizeConfig.verticalSpaceSmall(),
                ],
              ),
            ),
          );
        });
  }
}
