import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/string_service.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_offers.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/custom_divider_widget.dart';
import 'package:storeangelApp/ui/shared/deliveryinfo_rowWidget.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_common_order_text_row.dart';

class ViewOfferOrderWidget extends StatelessWidget {
  final OrderOrPurchases order;

  ViewOfferOrderWidget({this.order});

  @override
  Widget build(BuildContext context) {
    return BaseView<CourierOffersViewModel>(
      builder: (context, model, child) {
        return CustomCard(
          side: BorderSide.none,

            child: Padding(
              padding: SizeConfig.verticalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeConfig.VerticalSpaceSmallMedium(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).toggleableActiveColor,
                          borderRadius: BorderRadius.circular(AppConstants.ContainerRoundCorner_Radius)),
                      height: SizeConfig.screenHeight * .06,
                      child: Padding(
                        padding: SizeConfig.sidepadding * 1.15,
                        child: Row(
                          children: [
                            Text(
                              AppStrings.STATUS.tr(),
                              style: AppStyles.GreenStyleWithBold800_Font30(context).copyWith(
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                            Text(
                              order.status == OrderPurchaseStatus.Pending
                                  ? AppStrings.PENDING.tr()
                                  : order.status == OrderPurchaseStatus.Rejected
                                      ? AppStrings.REJECTED.tr()
                                      : '',
                              style: order.status == OrderPurchaseStatus.Rejected
                                  ? AppStyles.BlackStyleFont_20(context).copyWith(
                                      fontWeight: FontWeight.normal, color: AppColors.red, fontSize: SizeConfig.fontSizeLarge)
                                  : AppStyles.BlackStyleFont_20(context)
                                      .copyWith(fontWeight: FontWeight.normal, fontSize: SizeConfig.fontSizeLarge),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:
                              Row(
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
                  SizeConfig.verticalSpaceSmall(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: CourierCommonOrderTextRowWidget(
                      firstText: order.storeDetails.fullAddress,
                      secondText: order.clientDetails.addressLine,
                    ),
                  ),
                  SizeConfig.CVerticalSpaceMedium(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: CourierCommonOrderTextRowWidget(
                      firstText: '${order.purchaseDetails.products.length} ${AppStrings.ITEMS.tr()}',
                      onTapFirstItem: model.toggleView,
                      firstTextSyle: AppStyles.BlackStyleFont_16(context),
                      secondText: '6 ' + AppStrings.PUBLISHED.tr(),
                      secondTextStyle: AppStyles.BlackStyleFont_16(context),
                    ),
                  ),
                  InkWell(
                    onTap: model.toggleView,
                    child: SizedBox(
                      height: 4,
                    ),
                  ),
                  Padding(
                    padding:SizeConfig.sidepadding,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: model.toggleView,
                            child: Text(
                                  model.viewDetails?AppStrings.CLOSE.tr():AppStrings.VIEW.tr(),
                                  style: AppStyles.GreenStyleWith_Font16(context),
                                ),
                          ),
                        ),
                        SizeConfig.horizontalSpaceSmall(),
                        Expanded(
                            child: Text(
                          '4 (1) ${AppStrings.COMPLETED.tr()}',
                          style: AppStyles.GreenStyleWith_Font16(context),
                        ))
                      ],
                    ),
                  ),
                  model.viewDetails
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizeConfig.verticalSpaceSmall(),
                            CustomDividerWidget(
                              height: 1,
                            ),

                            SizeConfig.verticalSpaceSmall(),
                            Padding(
                              padding: SizeConfig.sidepadding,
                              child: DeliveryInfoRowWidget(
                                  hasBorderColor: false,
                                  enablePadding: false,
                                  firstText: AppStrings.PREFERRED_DELIVERY_DATE.tr()+':',
                                  secondText: '${DateService.getDateFormatWithYear(order.selectedDate.toIso8601String(), context)}'),
                            ),
                            SizeConfig.verticalSpaceSmall(),
                            Padding(
                              padding: SizeConfig.sidepadding,
                              child: DeliveryInfoRowWidget(
                                  hasBorderColor: false,
                                  enablePadding: false,
                                  firstText: AppStrings.YOUR_DELIVERY_PERIOD.tr()+':',
                                  secondText: '${DateService.getDateFormatWithYear(order.selectedDate.toIso8601String(), context)} ${order.timeDuration}'),
                            ),
                            SizeConfig.verticalSpaceSmall(),
                            Padding(
                              padding: SizeConfig.sidepadding,
                              child: DeliveryInfoRowWidget(
                                firstText: AppStrings.ORDER_PAYMENT.tr()+':',
                                secondText: AppStrings.PREPAYMENT.tr(),
                                hasBorderColor: false,
                                enablePadding: false,
                              ),
                            ),
                            SizeConfig.verticalSpaceSmall(),
                            Padding(
                              padding:SizeConfig.sidepadding,
                              child: Text(
                                AppStrings.COMMENT.tr()+':',
                                style: AppStyles.GrayStyle_Font12(context),
                              ),
                            ),
                            SizeConfig.verticalSpace(5),
                            Padding(
                              padding: SizeConfig.sidepadding,
                              child: Text(
                                'When you deliver, please do not ring the bell. My baby can sleep. Just call me and I’ll meet you.',
                                style: AppStyles.BlackStyleFontWeightSmall_12(context),
                              ),
                            ),
                            SizeConfig.verticalSpaceSmall(),
                          ],
                        )
                      : Container(),
                  SizeConfig.verticalSpaceSmall(),
                  CustomDividerWidget(
                   height: 1,
                  ),
                  SizeConfig.verticalSpaceSmall(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          StringService.getCourierBudgetName(order.purchaseDetails).name+':',
                          style: AppStyles.BlackStyleFont_20(context),
                        )),
                        Text('${AppStrings.euro+' '}${NumberService.priceAfterConvert(230,context)}',
                            style: AppStyles.BlackStyleFont_20(context))
                      ],
                    ),
                  ),
                  SizeConfig.verticalSpaceSmall(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          AppStrings.YOUR_FEE.tr()+':',
                          style: AppStyles.BlackStyleFont_20(context),
                        )),
                        Text('${AppStrings.euro+' '}${NumberService.priceAfterConvert(10,context)}',
                            style: AppStyles.BlackStyleFont_20(context))
                      ],
                    ),
                  ),
                  SizeConfig.verticalSpaceSmall(),
                  CustomDividerWidget(
                    height: 1,
                  ),
                  SizeConfig.verticalSpaceSmall(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          AppStrings.TOTAL.tr()+':',
                          style: AppStyles.BlackStyleFontw300_20(context).copyWith(fontWeight: FontWeight.bold),
                        )),
                        Text('${AppStrings.euro+' '}${NumberService.priceAfterConvert(240,context)}',
                            style: AppStyles.BlackStyleFontw300_20(context).copyWith(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  SizeConfig.verticalSpaceMedium(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          TimeAgoService.timeAgoFromPlugin(DateTime.now().subtract(Duration(minutes: 10),),context),
                          style: AppStyles.GrayStyle_Font16(context),
                        )
                      ],
                    ),
                  ),
                  SizeConfig.verticalSpaceSmall(),
                ],
              ),
            ),

        );
      },
    );
  }
}
