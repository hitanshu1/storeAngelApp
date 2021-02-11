import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/ui/shared/sliver_app_shape_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class CourierSummaryGroceryListWidget extends StatefulWidget {
  final List<Product>products;
  CourierSummaryGroceryListWidget({this.products});

  @override
  _CourierSummaryGroceryListWidgetState createState() => _CourierSummaryGroceryListWidgetState();
}

class _CourierSummaryGroceryListWidgetState extends State<CourierSummaryGroceryListWidget> {
  bool expanded=false;

  int getLength(){
    if(expanded){
      return widget.products.length;
    }else{
      if(widget.products.length>3){
        return 3;
      }else{
        return widget.products.length;
      }

    }
  }

  bool  isBorderColor(int index){
  if(expanded){
    if(index==widget.products.length-1){
      return false;
    }else{
      return true;
    }
  }else{
    if(widget.products.length>3){
      if(index==2){
        return false;
      }else{
        return true;
      }
    }else{
      if(index==widget.products.length-1){
        return false;
      }else{
        return true;
      }
    }
  }
  }


  @override
  Widget build(BuildContext context) {
    return SliverAppShapeWidget(
      child: SliverPadding(
        padding: SizeConfig.padding,
        sliver: MultiSliver(
          children: [
            SliverToBoxAdapter(
              child: Text(AppStrings.GROCERY_LIST.tr()+":",
              style: AppStyles.BlackStyleWithBold800Font_24(context),),
            ),
            SizeConfig.verticalSliverSmallSpace(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      Product _product=widget.products[index];

                  return Container(
                    child: Padding(
                      padding: SizeConfig.tilePadding,
                      child: Row(
                        children: [
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_product.name,style: AppStyles.BlackStyleFont_20(context),),
                              Text('${_product.quantity} '+AppStrings.PIECES.tr()+' x '+AppStrings.euroSymbol+'${_product.price}',
                              style: AppStyles.GrayStyle_Font16(context),)
                            ],
                          )),
                          SizeConfig.horizontalSpaceSmall(),
                          Text(AppStrings.euroSymbol+'${NumberService.addAfterCommaTwoZeros('${_product.price*_product.quantity}', context)}')
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      border:isBorderColor(index)?Border(
                        bottom: BorderSide(
                          color: Provider.of<AppThemeViewModel>(context).themeData == AppTheme.dark
                              ? AppColors.backgroundColor
                              : Theme.of(context).primaryColorLight
                        )
                      ):Border()
                    ),
                  );
                },
                childCount: getLength(),
              ),
            ),
            SizeConfig.verticalSliverSmallSpace(),

            widget.products.length>3?
            SliverToBoxAdapter(child: InkWell(
              onTap: (){
                setState(() {
                  expanded=!expanded;
                });
              },
              child: Column(
                children: [
                  Text(expanded?AppStrings.CLOSE.tr():AppStrings.EXTENDED_VIEW.tr(),
                    style: AppStyles.GrayStyleItalicFont16(context),
                  ),
                  Icon(expanded?Icons.expand_less:Icons.expand_more)
                ],
              ),
            ),):
            SliverToBoxAdapter(),

          ],
        ),
      ),
    );
  }
}
