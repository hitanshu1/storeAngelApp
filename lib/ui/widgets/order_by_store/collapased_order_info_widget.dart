import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_complete_order_screen.dart';
import 'package:storeangelApp/ui/shared/deliveryinfo_rowWidget.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/view_delivered_order_item.dart';

class CollapsedOrderInfoWidget extends StatefulWidget {
  final OrderOrPurchases orderOrPurchases;
  final bool storeDetailsVisible;
  final CompleteOrderViewModel model;
  final Function onMaxScrol;

  CollapsedOrderInfoWidget({this.orderOrPurchases, this.storeDetailsVisible: true, this.onMaxScrol, this.model});

  @override
  _CollapsedOrderInfoWidgetState createState() => _CollapsedOrderInfoWidgetState();
}

class _CollapsedOrderInfoWidgetState extends State<CollapsedOrderInfoWidget> {
  ScrollController _scrollController = ScrollController();

  bool get _isAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.position.pixels == _scrollController.position.maxScrollExtent;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_isAppBarExpanded) {
        if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
          Future.delayed(Duration(microseconds: 700), () {
            _scrollController.jumpTo(0);
          });

          widget.onMaxScrol(true);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Theme.of(context).canvasColor),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.storeDetailsVisible
                ? DecoratedBox(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Text(
                          AppStrings.AS_SOON_AS_POSSIBLE.tr(),
                          style: AppStyles.BlackStyleFont_16(context),
                        ),
                        Padding(
                          padding: SizeConfig.sidepadding,
                          child: Padding(
                            padding: SizeConfig.mediumPadding,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ViewAppImage(
                                  width: SizeConfig.smallImageHeight60,
                                  height: SizeConfig.smallImageHeight60,
                                  imageUrl: widget.orderOrPurchases.purchaseDetails.storeDetails.image,
                                  radius: 10,
                                ),
                                SizeConfig.horizontalSpaceSmall(),
                                Expanded(
                                  child: SizedBox(
                                    height: SizeConfig.smallImageHeight60,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              widget.orderOrPurchases.purchaseDetails.storeDetails.name,
                                              style: AppStyles.BlackStyleWithBold800Font_24(context),
                                            )),
                                            Text(
                                              '${AppStrings.euro + ' '}297.32',
                                              style: AppStyles.BlackStyleWithBold600Font_20(context),
                                            )
                                          ],
                                        ),
                                        SizeConfig.verticalSpaceSmall(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    widget.orderOrPurchases.purchaseDetails.storeDetails.street,
                                                    style: AppStyles.GrayStyle_Font16(context),
                                                  ),
                                                  Text(
                                                    widget.orderOrPurchases.purchaseDetails.storeDetails.city,
                                                    style: AppStyles.GrayStyle_Font16(context),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              '${widget.orderOrPurchases.purchaseDetails.quantity} ${AppStrings.ITEMS.tr()}',
                                              style: AppStyles.GrayStyle_Font16(context),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizeConfig.CVerticalSpaceMedium(),
                      ],
                    ),
                  )
                : Container(),
            Padding(
              padding: SizeConfig.sidepadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeConfig.CVerticalSpacevMedium(),
                  Text(
                    AppStrings.SHOPING_LIST.tr(),
                    style: AppStyles.BlackStyleWithBold600Font_20(context),
                  )
                ],
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: widget.orderOrPurchases.purchaseDetails.products.length + 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, int index) {
                  if (index == widget.orderOrPurchases.purchaseDetails.products.length) {
                    return Padding(
                      padding: SizeConfig.sidepadding,
                      child: Container(
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizeConfig.horizontalSpaceMedium(),
                            Expanded(
                                child: Text(
                              AppStrings.COURIER_FEE.tr(),
                              style: AppStyles.BlackStyleFont_20(context),
                            )),
                            SizeConfig.horizontalSpaceSmall(),
                            Text('${AppStrings.euro + ' '}10,00',
                                style: AppStyles.BlackStyleWithBold600Font_20(context))
                          ],
                        ),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.lightGreyColor))),
                      ),
                    );
                  }

                  return Padding(
                    padding: SizeConfig.sidepadding,
                    child: ViewDeliveredOrderItem(
                      product: widget.orderOrPurchases.purchaseDetails.products[index],
                    ),
                  );
                }),
            SizeConfig.CVerticalSpaceMedium(),
            Padding(
              padding: SizeConfig.sidepadding,
              child: Row(
                children: [
                  SizeConfig.horizontalSpaceMedium(),
                  Text(
                    AppStrings.TOTAL.tr(),
                    style: AppStyles.BlackStyleWithw500_FontC18(context),
                  ),
                  Expanded(
                      child: Text(
                    '${AppStrings.euro + ' '}82.93',
                    style: AppStyles.BlackStyleWithw500_FontC18(context),
                    textAlign: TextAlign.right,
                  ))
                ],
              ),
            ),
            SizeConfig.verticalSpaceSmall(),
            Padding(
              padding: SizeConfig.sidepadding,
              child: Row(
                children: [
                  SizeConfig.horizontalSpaceMedium(),
                  Text(
                    AppStrings.BUDGET.tr(),
                    style: AppStyles.BlackStyleWithBold600Font_20(context),
                  ),
                  Expanded(
                      child: Text(
                    '${AppStrings.euro + ' '}300,00',
                    style: AppStyles.BlackStyleWithBold600Font_20(context),
                    textAlign: TextAlign.right,
                  ))
                ],
              ),
            ),
            SizeConfig.CVerticalSpaceMedium(),
            Padding(
              padding: SizeConfig.sidepadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeConfig.CVerticalSpacevMedium(),
                  Text(
                    AppStrings.DELIVERY_DETAILLS.tr(),
                    style: AppStyles.BlackStyleWithBold600Font_20(context),
                  )
                ],
              ),
            ),
            SizeConfig.verticalSpaceSmall(),
            DeliveryInfoRowWidget(
                firstText: AppStrings.DELIVERY_TIME.tr(), secondText: AppStrings.AS_SOON_AS_POSSIBLE.tr()),
            DeliveryInfoRowWidget(
                firstText: AppStrings.ADDRESS.tr(),
                secondText: widget.orderOrPurchases.purchaseDetails.storeDetails.street),
            DeliveryInfoRowWidget(firstText: AppStrings.POSTED.tr(), secondText: 'May 12, 2020 13:40'),
            DeliveryInfoRowWidget(
              firstText: AppStrings.ORDER_NUMBER.tr(),
              secondText: '245678',
              hasBorderColor: false,
            ),
            SizeConfig.CVerticalSpacevEMedium(),
            _getFiller()
          ],
        ),
      ),
    );
  }

  Widget _getFiller() {
    switch (widget.orderOrPurchases?.purchaseDetails.products?.length??0) {
      case 0:
        return SizeConfig.verticalSpace(SizeConfig.screenHeight * .15);
      case 1:
        return SizeConfig.verticalSpace(SizeConfig.screenHeight * .1);
      case 2:
        return SizeConfig.verticalSpace(SizeConfig.screenHeight * .05);
      default: return Container();
    }
  }
}
