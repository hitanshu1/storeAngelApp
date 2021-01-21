import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_item_details.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/customstatuscheckbox.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';


import 'item_editable_value_widget.dart';

class ItemDetailsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemDetailsViewModel>(
        builder: (context,model,child){
      return SliverToBoxAdapter(
        child: Container(
          color: Theme.of(context).cardColor,
          child: Column(
            children: [
              Stack(
                children: [
                  SizeConfig.verticalSpace(SizeConfig.smallHeaderSize+115),
                  AppHeader(
                    height: SizeConfig.smallHeaderSize,
                    isBack: true,
                    title: '',
                  ),
                  Positioned.fill(child:Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: 0,
                              height: SizeConfig.imageHeight140+60,
                            ),
                            CustomCard(
                              radius:SizeConfig.imageheight90+4 ,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ViewAppImage(
                                  height: SizeConfig.imageHeight140,
                                  width: SizeConfig.imageHeight140,
                                  radius: SizeConfig.imageHeight140,
                                  imageUrl: model.currentProduct.imageUrl,
                                ),
                              ),
                            ),
                            Positioned(right: 0,bottom: 10,child: Align(
                              alignment:Alignment.bottomRight,
                              child: CustomStatusCheckBox(
                                status: model.currentProduct.availableStatus,
                                size: SizeConfig.screenWidth * .15,
                                iconSize: SizeConfig.screenWidth*.10,
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                  ))
                ],
              ),
              CarouselSlider.builder(
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 10),
                      height: 230,
                      viewportFraction: 1,
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason) {
                      model.setSelectedIndex(index);
                      }
                  ),
                  itemCount: model.products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: SizeConfig.padding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.euroSymbol+NumberService.priceAfterConvert(model.currentProduct.price, context)),
                          CustomRatingWidget(reviewCount: 6, initialRating: 3, stars: 12),
                        SizeConfig.verticalSpaceSmall(),
                          Text(model.currentProduct.name,style: AppStyles.BlackStyleWithBold800Font_20(context),),
                          SizeConfig.verticalSpaceSmall(),

                          ItemEditableValueWidget(product: model.currentProduct,),


                        ],
                      ),
                    );
                  }),

              Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: model.products.map((url) {
                    int index = model.products.indexOf(url);
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
        ),
      );
    });
  }
}
