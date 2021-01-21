import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_item_tile_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderDetailsEstimateBudgetWidget extends StatelessWidget {
  final List<Product>products;
  OrderDetailsEstimateBudgetWidget({this.products});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConfig.sidepadding,
      child: AppShapeItem(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).toggleableActiveColor,
          ),
          child: ListView.builder(itemCount: products.length+1,itemBuilder: (context,int index){
            if(index==0){
              return Padding(
                padding: SizeConfig.padding,
                child: Text(AppStrings.ESTIMATED_BUDGET.tr(),
                  style: AppStyles.BlackStyleFont_20(context),),
              );
            }
            return Padding(
              padding: SizeConfig.sidepadding,
              child: CourierItemTileWidget(
                isBorder:index!=products.length,
                product: products[index-1],
                enableQuantity: true,
                availableButton: false,
              ),

            );
          }),
        ),
      )
    );
  }
}
