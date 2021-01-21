import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/pickStore_viewmodel.dart';
import 'package:storeangelApp/ui/shared/search_text_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class PickStoreHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PickStoreViewModel>(
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
                padding:SizeConfig.sidepadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back,
                            color: AppColors.whiteColor,),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(child: Text('${model.selectedStoreList.length}/3',
                        style: AppStyles.WhiteStyle_Font20,textAlign: TextAlign.end,))

                      ],
                    ),
                    SearchTextFieldWidget(
                      hintText: AppStrings.SEARCH_FOR_STORE.tr(),
                      scan: false,
                      controller: model.searchController,
                      onChange: (val){
                        model.searchStore(val);
                      },
                      onSubmit: (val){
                        model.searchStore(val);
                      },
                    ),
                    SizeConfig.verticalSpaceSmall(),

                  ],
                ),
              ),
            ),
          );
        });
  }
}
