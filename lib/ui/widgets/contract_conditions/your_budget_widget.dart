import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/ui/shared/custom_tile.dart';
import 'package:easy_localization/easy_localization.dart';

class YourBudgetWidget extends StatelessWidget {
  final List<Product>products;
  final bool enableEdit;
  YourBudgetWidget({this.products,this.enableEdit:true});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CustomTile(leadingText: AppStrings.YOUR_BUDGET.tr()+":",
        tradingText:!enableEdit?AppStrings.euroSymbol+'${NumberService.totalPrice(products, context)}':null ,
        tradingWidget: enableEdit?Container(
          width: 70,
          height: 30,
          child: Center(child: Text(AppStrings.euroSymbol+'${NumberService.totalPrice(products, context)}'),),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(SizeConfig.radiusSmall),
          ),

        ):null,

        subtitle: AppStrings.MAXIMUM_SUM_THAT_THAT_A_SUPPLIER_MAY_SPEND.tr(),
      isItalic: false,),
    );
  }
}
