import 'package:flutter/material.dart';
import 'package:flutter_group_sliver/flutter_group_sliver.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_item_tile_widget.dart';

class ArticlesListWidget extends StatelessWidget {
  final List<Product>products;
  final bool showNewPrice;
  final bool isItalicFont;
  ArticlesListWidget({this.products,this.showNewPrice:false,this.isItalicFont:true});
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
                  isBorder:index!=products.length,
                  product: products[index],
                  enableQuantity: true,
                  availableButton: true,
                  editStatus: true,
                  showNewPrice: showNewPrice,
                  isItalicFont:isItalicFont ,
                ),

              );
            },
            childCount: products.length,
          ),
        ),

      ),
    );
  }
}
