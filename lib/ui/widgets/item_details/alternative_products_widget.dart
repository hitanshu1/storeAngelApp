import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_item_details.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/widgets/item_details/alternative_item_tile_widget.dart';

class AlternativeProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemDetailsViewModel>(builder: (context,model,child){
      return SliverPadding(
        padding: SizeConfig.sidepadding,
        sliver: MultiSliver(children: [

          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(child: TitleTextWidget(title: AppStrings.ALTERNATIVES.tr())),
                IconButton(icon: Icon(Icons.add,color: AppColors.primaryColor,), onPressed: (){

                })
              ],
            ),
          ),
          SizeConfig.verticalSliverSmallSpace(),
          model.currentProduct.alternativeProduct!=null?SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300.0,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.9,
            ),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return AlterNativeItemTileWidget(
                  product: model.currentProduct.alternativeProduct[index],
                );
              },
              childCount: model.currentProduct.alternativeProduct.length,
            ),
          ):SliverToBoxAdapter()
        ]),
      );
    });
  }
}
