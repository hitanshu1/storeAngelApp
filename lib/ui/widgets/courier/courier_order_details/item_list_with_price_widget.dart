import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_item_tile_widget.dart';

class ItemListWithPriceWidget extends StatelessWidget {
  final List<Product>products;
  ItemListWithPriceWidget({this.products});
  @override
  Widget build(BuildContext context) {
    return AppShapeItem(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).toggleableActiveColor
        ),
        child: Padding(
          padding: SizeConfig.innerpadding,
          child: ListView.builder(itemCount: products.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context,int index){
            return CourierItemTileWidget(
              isBorder: index!=products.length-1,
              product:products[index] ,
              enablePrice: true,
            );
          }),
        ),
      ),
    );
  }
}
