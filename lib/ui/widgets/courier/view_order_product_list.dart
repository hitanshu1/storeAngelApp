import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/ui/widgets/items/selectableItemlist.dart';

class ViewOrderProductList extends StatefulWidget {
  final List<Product>products;
  final bool enablePadding;
  ViewOrderProductList({this.products,this.enablePadding:true});
  @override
  _ViewOrderProductListState createState() => _ViewOrderProductListState();
}

class _ViewOrderProductListState extends State<ViewOrderProductList> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizeConfig.CVerticalSpaceMedium(),
        Padding(
          padding: SizeConfig.sidepadding,
          child: Text('${widget.products.length} ${AppStrings.ITEMS.tr()}',style: AppStyles.BlackStyleFont_20(context),),
        ),
        SizeConfig.CVerticalSpaceSmallMedium(),
        SelectableItemList(products: widget.products,showprice: true,slideable: false,),
        SizeConfig.CVerticalSpaceSmallMedium(),
        Padding(
          padding:  SizeConfig.sidepadding,
          child: Row(
            children: [
              SizeConfig.horizontalSpaceMedium(),
              Expanded(child: Text(AppStrings.BUDGET.tr(),style: AppStyles.BlackStyleWithw500_FontC18(context))),
              Text('${AppStrings.euro+' '}300,00',style: AppStyles.BlackStyleWithw500_FontC18(context))
            ],
          ),
        ),
      ],
    );
  }
}