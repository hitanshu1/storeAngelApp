import 'package:flutter/material.dart';
import 'package:flutter_group_sliver/flutter_group_sliver.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_contract_condition_viewmodel.dart';
import 'package:storeangelApp/ui/shared/custom_check_box_tile_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/showbottomSheet.dart';
import 'package:storeangelApp/ui/widgets/share/custom_date_picker.dart';
class DeliveryPeriodWidget extends StatelessWidget {
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
                      return Padding(
                        padding:SizeConfig.verticalPadding,
                        child: Text(AppStrings.DELIVERY_PERIOD.tr(),
                          style: AppStyles.BlackStyleFont_24(context),),
                      );
                    }
                    if(index==model.deliveryPeriods.length){
                      return CustomCheckBoxTileWidget(
                        isBorderColor: false,
                        value: model.paymentValue(model.deliveryPeriods[index-1]),
                        title:  model.selectDateAndTime != null
                            ? model.selectDateAndTime
                            : AppStrings.SELECT_DELIVERY_DATE.tr(),
                        onTap: () {
                          model.onSelectPayment(model.deliveryPeriods[index-1]);
                          onTapSelectDate(model, context);
                        },
                      );
                    }
                    return CustomCheckBoxTileWidget(
                        padding: SizeConfig.verticalC13Padding,
                        value: model.paymentValue(model.deliveryPeriods[index-1]),
                        title: model.deliveryPeriods[index-1],
                        onTap: (){

                          model.onSelectDeliveryPeriod(model.deliveryPeriods[index-1]);

                        }

                    );


                  },
                  childCount: model.deliveryPeriods.length+1,
                ),
              ),
            ),

          ),
        ),

      ]);
    });
  }
  void onTapSelectDate(ContractConditionViewModel contractConditionViewModel, BuildContext context) {
    DateTime now = DateTime.now();
    int minuteDifference = now.minute != 0 ? 60 - now.minute : 0;
    DateTime initialDate = now.add(Duration(hours: 2, minutes: minuteDifference));
    ShowBottomSheet.showLarge(
        child: CustomDatePickerWidget(
          minuteInterval: 1,
          initialDatetime: initialDate,
          bottomText: AppStrings.NEXT_SELECT_END_TIME.tr(),
          onSelect: (dateTime) {
            contractConditionViewModel.onSelectStartDate(dateTime);
            if (dateTime != null) {
              Navigator.pop(context);
              ShowBottomSheet.showLarge(
                  child: CustomDatePickerWidget(
                    minuteInterval: 1,
                    initialDatetime: contractConditionViewModel.startDate.add(Duration(hours: 2)),
                    bottomText: AppStrings.DELIVERY_UNTIL.tr(),
                    minimumDate: contractConditionViewModel.startDate.add(Duration(hours: 2)),
                    onSelect: (dateTime) {
                      if (dateTime != null) {
                        contractConditionViewModel.onSelectEndDate(dateTime);
                        contractConditionViewModel.onSelectDeliveryTimeOption(3);
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  context: context,
                  heightFactor: .4);
            }
          },
        ),
        context: context,
        heightFactor: .4);
  }
}
