import 'package:flutter/material.dart';
import 'package:flutter_group_sliver/flutter_group_sliver.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:easy_localization/easy_localization.dart';

import '../courier_item_tile_widget.dart';
class CourierDeliveryItemListWidget extends StatelessWidget {
  final List<Product>products;
  CourierDeliveryItemListWidget({this.products});
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: SizeConfig.sidepadding,
      sliver: SliverGroupBuilder(
        decoration: BoxDecoration(
          color: Theme.of(context).toggleableActiveColor,
          borderRadius: SizeConfig.appItemShapeRadius,
        ),
        child:  SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if(index==0){
                    return  Padding(
                      padding: SizeConfig.paddingWithHighVerticalSpace,
                      child: Text(AppStrings.PURCHASE_PRODUCTS.tr(),style: AppStyles.BlackStyleFont_20(context),),
                    );
                  }
              return Padding(
                padding: SizeConfig.sidepadding,
                child: CourierItemTileWidget(
                  isBorder:index!=products.length,
                  product: products[index-1],
                  enableQuantity: false,
                  enablePriceText: true,
                ),

              );
            },
            childCount: products.length+1,
          ),
        ),

      ),);
  }
}
