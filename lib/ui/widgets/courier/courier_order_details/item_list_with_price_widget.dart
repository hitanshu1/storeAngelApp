import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_details_two_viewmodel.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/sliver_app_shape_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_item_tile_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class ItemListWithPriceWidget extends StatelessWidget {
  final List<Product>products;
  ItemListWithPriceWidget({this.products});
  @override
  Widget build(BuildContext context) {

    return Consumer<CourierOrderDetailsTwoViewModel>(
        builder: (context,courierOrderDetailTwoViewModel,child){
          return SliverAppShapeWidget(
              child: SliverPadding(
                padding:SizeConfig.padding,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      if(index==0){
                        return Padding(
                          padding: SizeConfig.verticalPadding,
                          child: Text(AppStrings.PURCHASE_PRODUCTS.tr(),style: AppStyles.BlackStyleFont_20(context),),
                        );

                      }
                      return CourierItemTileWidget(
                        onClickStatus: (){

                        },
                        changeState: (){
                          courierOrderDetailTwoViewModel.setState(ViewState.Idle);
                        },

                        isBorder: index!=products.length,
                        product:products[index-1] ,
                        enableQuantityText:true,
                        enableEditPrice: true,
                      );
                    },
                    childCount: products.length+1,
                  ),
                ),
              ));
        });

  }
}
