import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_share_list.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/search_text_field_widget.dart';
class ShareListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShareListViewModel>(
        builder: (context,model,child){
          return SliverToBoxAdapter(
            child:  model.searchText?Container(
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
                        hintText: AppStrings.USERNAME_OR_PASSWORD.tr(),

                        scan: false,

                        controller: model.searchController,
                        onChange: (val){
                          model.onSearch(val);
                        },
                        onSubmit: (val){
                          model.onSearch(val);
                        },
                      ),
                    ),


                  ],
                ),
              ),
            ):AppHeader(
              isBack: true,
              title:AppStrings.YOUR_FRIENDS.tr(),
              actions: [
                IconButton(icon: Icon(Icons.add,color: AppColors.whiteColor,),
                    onPressed: (){
                  model.onEnableSearch(true);
                    })
              ],


            ),
          );
        });
  }
}
