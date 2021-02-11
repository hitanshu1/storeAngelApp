import 'package:flutter/material.dart';
import 'package:flutter_group_sliver/flutter_group_sliver.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/product.dart';
import '../courier_item_tile_widget.dart';

class CourierItemList extends StatelessWidget {
  final List<Product> products;
  final bool enableQuantity;
  CourierItemList({this.products,this.enableQuantity:false});
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
            return Padding(
              padding: SizeConfig.sidepadding,
              child: CourierItemTileWidget(
                onClickStatus: (){

                },
                isBorder:index!=products.length-1,
                product: products[index],
                enableQuantity: enableQuantity,
                isItalicFont: false,
              ),

            );
          },
          childCount: products.length,
        ),
      ),

    ),);
  }
}
