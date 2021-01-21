import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order.dart';
import 'package:storeangelApp/ui/screens/courier/courier_order/courier_order_delivered_summary_screen.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/custom_divider_widget.dart';
import 'package:storeangelApp/ui/shared/deliveryinfo_rowWidget.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_common_order_text_row.dart';
import 'package:storeangelApp/ui/widgets/orderDelivered/order_status_row_widget.dart';

class CourierOrderCompletedWidget extends StatelessWidget {
  final OrderOrPurchases order;
  final CourierOrderViewModel model;

  CourierOrderCompletedWidget({this.order, this.model});

  @override
  Widget build(BuildContext context) {

    return CustomCard(
      child: InkWell(
        onTap: () async{
          model.navigateToScreen(CourierOrderDeliveredSummaryScreen.routeName,context, arguments: order);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeConfig.verticalSpaceMedium(),
            Padding(
              padding: SizeConfig.sidepadding,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).toggleableActiveColor,
                    borderRadius: BorderRadius.circular(AppConstants.ContainerRoundCorner_Radius)),
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: Column(
                    children: [
                      SizeConfig.verticalSpaceMedium(),
                      Padding(
                        padding: SizeConfig.sidepadding,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: FittedBox(
                                  child: Text(
                                    AppStrings.CURRENT_STATUS.tr(),
                                    style:
                                        AppStyles.GreenStyleWith_Font16(context).copyWith(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                  ),
                                )),
                            Expanded(flex: 1, child: Image.asset(AssetsPath.green_arrow)),
                            Expanded(
                              flex: 3,
                              child: FittedBox(
                                child: Text(
                                  AppConstants.getStatusTitle(order),
                                  style: AppStyles.BlackStyleFont_16(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizeConfig.verticalSpaceSmall(),
                      Padding(
                        padding: SizeConfig.sidepadding,
                        child: OrderStatusRowWidget(
                          status: order.status,
                        ),
                      ),
                      SizeConfig.verticalSpaceMedium(),
                    ],
                  ),
                ),
              ),
            ),
            SizeConfig.verticalSpaceSmall(),
            SizeConfig.verticalSpaceMedium(),
            Padding(
              padding: SizeConfig.sidepadding,
              child: Row(
                children: [
                  Expanded(
                      child: Row(
                        children: [
                          ViewAppImage(
                            imageUrl: order.storeDetails.image,
                            height: SizeConfig.smallerImageHeight,
                            width: SizeConfig.smallerImageHeight,
                            radius: 10,
                          ),
                        ],
                      )),
                  SizeConfig.horizontalSpaceSmall(),
                  Expanded(
                    child: Row(
                      children: [
                        ViewAppImage(
                          imageUrl: order.clientDetails.imageUrl,
                          height: SizeConfig.smallerImageHeight,
                          width: SizeConfig.smallerImageHeight,
                          radius: SizeConfig.smallerImageHeight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizeConfig.verticalSpaceSmall(),
            Padding(
              padding: SizeConfig.sidepadding,
              child: CourierCommonOrderTextRowWidget(
                firstText: order.storeDetails.name,
                firstTextSyle: AppStyles.BlackStyleWithBold600Font_20(context),
                secondTextStyle: AppStyles.BlackStyleWithBold600Font_20(context),
                secondText: order.clientDetails.name,
              ),
            ),
            SizeConfig.CVerticalSpaceVarySmall(),
            Padding(
              padding: SizeConfig.sidepadding,
              child: CourierCommonOrderTextRowWidget(
                firstText: order.storeDetails.zipCity,
                secondText: order.clientDetails.street,
              ),
            ),
            SizeConfig.CVerticalSpaceVarySmall(),
            Padding(
              padding: SizeConfig.sidepadding,
              child: CourierCommonOrderTextRowWidget(
                firstText: order.storeDetails.street,
                secondText: order.clientDetails.city,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.sidepadding.left, SizeConfig.screenHeight * .013, SizeConfig.sidepadding.right, 0),
              child: CourierCommonOrderTextRowWidget(
                firstChild: Row(
                  children: [
                    Text('10 ${AppStrings.ITEMS.tr()} '),
                  ],
                ),
                secondChild: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(StoreangelIcons.message_icon, color: Theme.of(context).focusColor),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: SizeConfig.sidepadding,
              child: CustomDividerWidget(),
            ),
            Padding(
              padding: SizeConfig.sidepadding.copyWith(top: 4),
              child: DeliveryInfoRowWidget(
                enablePadding: false,
                hasBorderColor: false,
                firstText: AppStrings.PURCHASE_COSTS.tr()+':',
                secondText: AppStrings.euro+' '+ NumberService.priceAfterConvert(209,context),
              ),
            ),
            SizeConfig.CVerticalSpaceVarySmall(),
            Padding(
              padding: SizeConfig.sidepadding,
              child: DeliveryInfoRowWidget(
                enablePadding: false,
                hasBorderColor: false,
                firstText: AppStrings.YOUR_FEE.tr()+':',
                secondText: AppStrings.euro+' '+ NumberService.priceAfterConvert(10,context),
              ),
            ),
            SizeConfig.verticalSpaceMedium(),
          ],
        ),
      ),
    );
  }
}
