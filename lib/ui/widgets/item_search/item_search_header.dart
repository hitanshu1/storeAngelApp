import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

import 'package:storeangelApp/core/viewmodel/viewmodel_item_search.dart';
import 'package:storeangelApp/ui/shared/search_text_field_widget.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:easy_localization/easy_localization.dart';
class ItemSearchHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Consumer<ItemSearchViewModel>(
        builder: (context,model,child){
          return SliverToBoxAdapter(
            child: Container(
              height: SizeConfig.customerHeaderHeight,
              width: SizeConfig.screenWidth,

              decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient
              ),
              padding: SizeConfig.smalltopPadding.copyWith(
                  left: 0,right: 0
              ),
              child: Padding(
                padding:SizeConfig.sidepadding.copyWith(
                    bottom: SizeConfig.screenHeight * 0.01
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Padding(
                        padding: SizeConfig.verticalSmallPadding,
                        child: Icon(Icons.arrow_back,
                          color: AppColors.whiteColor,),
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight*.06,
                      child: SearchTextFieldWidget(

                        scan: false,
                        hintText: AppStrings.SEARCH_FOR_PRODUCT.tr()+' ...',


                        controller: model.searchController,
                        onChange: (val){
                          model.onSearchText(val);
                        },
                        onSubmit: (val){
                          model.onSearchText(val);
                        },
                      ),
                    ),


                  ],
                ),
              ),
            ),
          );
        });
  }
}
