import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_delivered_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_current_order_tab.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/stepback_dialog.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_action_button.dart';
import 'package:storeangelApp/ui/widgets/courier/currentOrderDelivered/row_with_small_textfield_widget.dart';

class CourierPriceCheckWidget extends StatelessWidget {
  final CourierCurrentOrderTabViewModel model;

  CourierPriceCheckWidget({this.model});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .02),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizeConfig.verticalSpaceSmall(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .15),
                  child: Text(
                    AppStrings.ARE_THE_UNIT_PRICES_USED_CORRECT.tr(),
                    textAlign: TextAlign.center,
                    style: AppStyles.BlackStyleFont_20(context),
                  ),
                ),
                SizeConfig.verticalSpaceBigMedium(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text(AppStrings.EURO.tr())],
                  ),
                ),
                SizeConfig.verticalSpaceSmall(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: RowWithSmallTextFieldWidget(
                    firstText: AppStrings.CALCULATED_PAYMENT.tr(),
                    firstTextStyle: AppStyles.BlackStyleWithBold800Font_24(context),
                  ),
                ),
                SizeConfig.verticalSpaceSmall(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Text(
                    AppStrings.PURCHASE_ITEMS.tr(),
                    style: AppStyles.BlackStyleWithBold800Font_24(context),
                  ),
                ),
                SizeConfig.verticalSpaceSmall(),
              ],
            );
          }
          else if(index==model.products.length+1){
            CourierOrderDeliveredViewModel courierOrderDeliveredViewModel = Provider.of<CourierOrderDeliveredViewModel>(context);
            return Padding(
              padding: SizeConfig.sidepadding.copyWith(top: SizeConfig.screenHeight*.02),
              child: CourierOrderActionButton(
                  firstButtonText: AppStrings.UNDO.tr(),
                  firstButtonTap: (){
                    MyUtils.showAppDialog(
                        context: context,
                        child: StepBackDialog(
                          onPressOk: () {
                            courierOrderDeliveredViewModel.updateOrderStatus(OrderPurchaseStatus.OrderAccepted);
                            courierOrderDeliveredViewModel.navigatorPop();
                          },
                        ));
                  },
                  secondButtonText: AppStrings.PRICE_CHECKED.tr(),
                  secondButtonTap: (){
                    courierOrderDeliveredViewModel.updateOrderStatus(OrderPurchaseStatus.OrderRunning);
                  }
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.fromLTRB(SizeConfig.sidepadding.left, SizeConfig.smallerVerticalPadding3.top,
                SizeConfig.sidepadding.right, SizeConfig.smallerVerticalPadding3.bottom),
            child: RowWithSmallTextFieldWidget(
              firstText: model.products[index-1].name,
              firstTextStyle: AppStyles.BlackStyleFont_20(context).copyWith(fontWeight: FontWeight.w500),
              secondText: model.products[index-1].quantity.toString(),
            ),
          );
        }, childCount: model.products.length + 2),
      ),
    );
  }
}
