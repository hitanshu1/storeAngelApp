import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/view_model_courier_item_details.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/custom_item_status_widget.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/item_details/item_editable_value_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class CourierItemDetailsHeader extends StatelessWidget {
  final Product product;
  CourierItemDetailsHeader({this.product});


  @override
  Widget build(BuildContext context) {
    print(product.itemStatus);
    return Consumer<CourierItemDetailsViewModel>(
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
                        onBackPress: (){
                          Navigator.pop(context,model.products);

                        },
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
                                      emptyText: AppStrings.NO_DATA_FOUND.tr(),
                                      height: SizeConfig.imageHeight140,
                                      width: SizeConfig.imageHeight140,
                                      radius: SizeConfig.imageHeight140,
                                      imageUrl: model.currentProduct.imageUrl,
                                    ),
                                  ),
                                ),
                                Positioned(right: 0,bottom: 0,child: Align(
                                  alignment:Alignment.bottomRight,
                                  child: model.currentProduct.id!=null?InkWell(
                                    child: CustomItemStatusWidget(
                                      status: model.currentProduct.itemStatus,
                                      size: SizeConfig.screenWidth * .2,
//                                    iconSize: SizeConfig.screenWidth*.13,
                                    child: Container(
                                      child: Center(
                                        child: Icon(Icons.check,color: AppColors.grayLight.withOpacity(.3),
                                        size: SizeConfig.mediumIcon,),
                                      ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.whiteColor,
                                      border: Border.all(color: AppColors.primaryColor,width: 5)
                                    ),),
                                    ),
                                    onTap: (){
                                      model.onClickProductStatus(model.initialIndex);
                                    },
                                  ):Container(),
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
                          autoPlay: false,
                          autoPlayInterval: Duration(seconds: 10),
                          height: model.currentProduct.id!=null?230:0,
                          viewportFraction: 1,
                          enlargeCenterPage: false,
                          onPageChanged: (index, reason) {
                            model.setSelectedIndex(index);
                          }
                      ),
                      itemCount: model.currentProduct.id!=null?model.products.length:0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: SizeConfig.padding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.euroSymbol+NumberService.priceAfterConvert(model.currentProduct?.price??0, context)+' ${model.currentProduct.id!=null?'| 100 ml':""}',
                                style: AppStyles.BlackStyleFont_20(context),),
                              SizeConfig.verticalSpaceSmall(),
                             Text(model.currentProduct.name??'',style: AppStyles.BlackStyleWithBold800Font_24(context),),
                              SizeConfig.verticalSpaceSmall(),
                              model.currentProduct.id!=null?CustomRatingWidget(reviewCount: 6, initialRating: 3, stars: 12):Container(),

                              SizeConfig.verticalSpaceMedium(),

                              model.currentProduct.id!=null?ItemEditableValueWidget(product: model.currentProduct??0,enable: false,):
                              Container(),

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
                  ),
                  SizeConfig.verticalSpaceSmall()
                ],
              ),
            ),
          );
        });
  }
}
