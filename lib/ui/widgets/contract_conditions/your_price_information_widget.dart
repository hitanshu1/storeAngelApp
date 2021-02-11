import 'package:flutter/material.dart';
import 'package:flutter_group_sliver/flutter_group_sliver.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_contract_condition_viewmodel.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_item_tile_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class YourPriceInformationWidget extends StatelessWidget {
  final bool enableTextField;
  YourPriceInformationWidget({this.enableTextField:true});
  @override
  Widget build(BuildContext context) {
    return  Consumer<ContractConditionViewModel>(
        builder: (context,model,child){
          return SliverPadding(
            padding: SizeConfig.padding,
            sliver: SliverGroupBuilder(
              decoration: BoxDecoration(
                color: Theme.of(context).toggleableActiveColor,
                borderRadius: SizeConfig.appItemShapeRadius,
              ),
              child:  SliverPadding(
                padding: SizeConfig.sidepadding,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      if(index==0){
                        return Padding(
                          padding:SizeConfig.verticalPadding,
                          child: Text(AppStrings.YOUR_PRICING_INFORMATION.tr()+":",
                            style: AppStyles.BlackStyleFont_24(context),),

                        );
                      }
                      return CourierItemTileWidget(
                        onClickStatus: (){

                        },
                        isBorder:index!=model.purchaseDetails.products.length,
                        product: model.purchaseDetails.products[index-1],
                        enableQuantity: false,
                        enablePrice: enableTextField,
                      );


                    },
                    childCount: model.purchaseDetails.products.length+1,
                  ),
                ),
              ),

            ),
          );
        });
  }
}
