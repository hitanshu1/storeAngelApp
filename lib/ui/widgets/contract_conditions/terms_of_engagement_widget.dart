import 'package:flutter/material.dart';
import 'package:flutter_group_sliver/flutter_group_sliver.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_contract_condition_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/custom_check_box.dart';
import 'package:storeangelApp/ui/shared/custom_check_box_tile_widget.dart';
import 'package:storeangelApp/ui/widgets/contract_conditions/time_of_payment_widget.dart';


class TermsOfEngagementWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<ContractConditionViewModel>(builder: (
    context,model,child){
      return MultiSliver(children: [
        SizeConfig.verticalSliverSmallSpace(),
        SliverPadding(
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
                          return Row(
                            children: [
                              Expanded(
                                child: Text(AppStrings.ADDRESSES.tr()+":",
                                style: AppStyles.BlackStyleWithBold800Font_20(context),),
                              ),
                              IconButton(padding: EdgeInsets.zero,icon: Icon(Icons.add,color: AppColors.primaryColor,),
                                  onPressed: (){

                              })

                            ],
                          );
                        }

                        if(index==model.userAddress.length+1){
                          return Padding(
                            padding: SizeConfig.verticalPadding,
                            child: Row(
                             crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomCheckBox(value: model.furtherValue,
                                  onTap: (){
                                  model.onSelectFurther();
                                  },),
                                SizeConfig.horizontalSpaceSmall(),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Text(AppStrings.FURTHER.tr(),style: AppStyles.GrayStyle_Font16(context),),
                                      SizeConfig.verticalSpaceMedium(),
                                      Text(AppStrings.DEPOSIT_AT_THE_PLACE_OF_DELIVERY.tr(),
                                      style: AppStyles.BlackStyle_Font16(context),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return CustomCheckBoxTileWidget(
                            value: model.addressValue(model.userAddress[index-1].id),
                            title: model.userAddress[index-1].threeLineAddress,
                            onTap: (){

                              model.onSelectAddress(model.userAddress[index-1]);

                            }

                        );


                  },
                  childCount: model.userAddress.length+2,
                ),
              ),
            ),

          ),
        ),
        TimeOfPaymentWidget(),
        SliverToBoxAdapter(
          child: Padding(
            padding: SizeConfig.sidepadding,
            child: AppShapeItem(
              child: Container(
                color: Theme.of(context).toggleableActiveColor,
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizeConfig.verticalSpaceSmall(),
                      Text(AppStrings.COMMENT.tr()+":",
                        style: AppStyles.BlackStyleWithBold800Font_20(context),),
                      SizeConfig.verticalSpaceSmall(),
                      TextField(

                        minLines: 4,
                        maxLines: 4,
                        textInputAction: TextInputAction.done,
                        style: AppStyles.BlackStyleFont_20(context),
                        onTap: () {

                        },
                        onSubmitted: (txt) {
                        },
                        decoration: InputDecoration.collapsed(
                            hintText: '', hintStyle: AppStyles.GrayStyle_Font16(context)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        SizeConfig.verticalSliverSmallSpace(),
        SliverToBoxAdapter(
          child: Padding(
            padding: SizeConfig.sidepadding,
            child: ButtonWidget(
              buttonText: AppStrings.CONTINUE.tr(),
              onPressed: (){
                model.onChangeStep(2);
              },
            ),
          ),
        ),
        SizeConfig.verticalSliverSmallSpace(),




      ]);
    });
  }

}
