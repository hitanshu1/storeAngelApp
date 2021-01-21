import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_delivered_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_current_order_tab.dart';
import 'package:storeangelApp/ui/screens/courier/courier_order/courier_order_delivered_summary_screen.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/platform_alert_dialog.dart';
import 'package:storeangelApp/ui/shared/selected_image_overlay_widget.dart';
import 'package:storeangelApp/ui/shared/stepback_dialog.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order_action_button.dart';


class CourierDeliveringOrderWidget extends StatefulWidget {
  final CourierCurrentOrderTabViewModel model;

  CourierDeliveringOrderWidget({this.model});

  @override
  _CourierDeliveringOrderWidgetState createState() => _CourierDeliveringOrderWidgetState();
}

class _CourierDeliveringOrderWidgetState extends State<CourierDeliveringOrderWidget> {
  PlatformFile file;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .02),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            SizeConfig.verticalSpaceSmall(),
            Padding(
              padding: SizeConfig.sidepadding,
              child: Row(
                children: [
                  ViewAppImage(
                    imageUrl: widget.model.selectedClients.first.imageUrl,
                    height: SizeConfig.screenWidth * .15,
                    width: SizeConfig.screenWidth * .15,
                    radius: 40,
                  ),
                  SizeConfig.horizontalSpaceMedium(),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                              child: Text(
                            widget.model.selectedClients.first.name,
                            style: AppStyles.BlackStyleFont_20(context).copyWith(fontWeight: FontWeight.w700),
                          )),
                          SizeConfig.horizontalSpaceSmall(),
                          Icon(
                            Icons.location_on,
                            size: SizeConfig.smallerIconSize,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                      SizeConfig.verticalSpace(5),
                      Text(
                        widget.model.selectedClients.first.street ?? '',
                        style: AppStyles.BlackStyleFont_16(context),
                      ),
                      Text(widget.model.selectedClients.first.zipCoden ?? '',
                          style: AppStyles.BlackStyleFont_16(context))
                    ],
                  ))
                ],
              ),
            ),
            SizeConfig.verticalSpaceMedium(),
            Padding(
              padding: SizeConfig.sidepadding,
              child: Row(
                children: [
                  widget.model.deliveryItemsImage != null
                      ? Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: SizeConfig.screenHeight * .23,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(widget.model.deliveryItemsImage), fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(AppConstants.ContainerRoundCorner_Radius)),
                              ),
                              Positioned.fill(
                                  child: SelectedImageOverlayWidget(
                                title: AppStrings.DELIVERED_ITEMS.tr(),
                                subTitle: AppStrings.RETAKE.tr(),
                                onTap: () {
                                  _optionsDialogForDeliveryItem(widget.model, context);
                                },
                              )),
                            ],
                          ),
                        )
                      : uploadReceiptWidget(AppStrings.DELIVERED_ITEMS.tr(), onTap: () {
                          _optionsDialogForDeliveryItem(widget.model, context);
                        }),
                  SizeConfig.horizontalSpaceMedium(),
                  widget.model.receiptsImages.length > 0
                      ? Expanded(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                height: SizeConfig.screenHeight * .23,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(widget.model.receiptsImages.first), fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(AppConstants.ContainerRoundCorner_Radius)),
                              ),
                              Positioned.fill(
                                  child: SelectedImageOverlayWidget(
                                title: AppStrings.RECEIPT.tr(),
                                subTitle: AppStrings.RETAKE.tr(),
                                onTap: () {
                                  _optionsDialogForReceiptImages(widget.model, context);
                                },
                              )),
                              Positioned.fill(
                                  child: Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: SizeConfig.sidepadding.copyWith(top: SizeConfig.screenHeight * .01),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          height: SizeConfig.iconSize,
                                          child: Image.asset(
                                            AssetsPath.gallery,
                                            color: AppColors.whiteColor,
                                          )),
                                      SizeConfig.horizontalSpaceSmall(),
                                      Expanded(
                                          child: Text(
                                        '${widget.model.receiptsImages.length}',
                                        style: AppStyles.WhiteStyle_Font16,
                                      )),
                                      InkWell(
                                        child: Icon(
                                          Icons.add_circle,
                                          color: AppColors.whiteColor,
                                        ),
                                        onTap: () {
                                          _optionsDialogForReceiptImages(widget.model, context);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        )
                      : uploadReceiptWidget(AppStrings.RECEIPT.tr(), onTap: () {
                          _optionsDialogForReceiptImages(widget.model, context);
                        }),
                ],
              ),
            ),
            SizeConfig.verticalSpaceMedium(),
            Consumer<CourierOrderDeliveredViewModel>(
              builder: (context, courierOrderDeliveredViewModel, child) => CourierOrderActionButton(
                firstButtonText: AppStrings.UNDO.tr(),
                firstButtonTap: () {
                  MyUtils.showAppDialog(
                    context: context,
                    child: StepBackDialog(
                      onPressOk: () {
                        courierOrderDeliveredViewModel.updateOrderStatus(OrderPurchaseStatus.PriceCheck);
                        courierOrderDeliveredViewModel.navigatorPop();
                      },
                    ),
                  );
                },
                secondButtonText: AppStrings.ITEMS_DELIVERED.tr(),
                secondButtonTap: () {
                  courierOrderDeliveredViewModel.navigateToScreen(CourierOrderDeliveredSummaryScreen.routeName,
                      arguments: courierOrderDeliveredViewModel.order);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _optionsDialogForDeliveryItem(CourierCurrentOrderTabViewModel model, BuildContext context) async {
    PlatformAlertDialog(
      title: AppStrings.GET_YOUR_IMAGE.tr(),
      content: '\n${AppStrings.SELECT_WHICH_IMAGE_OPTION_YOU_WANT_TO_CHOOSE.tr()}\n',
      defaultActionText: AppStrings.OPEN_CAMERA_DIALOG_TEXT.tr(),
      defaultFunction: model.openCameraForDeliveryImage,
      defaultActionText2: AppStrings.OPEN_GALLERY_DIALOG_TEXT.tr(),
      defaultFunction2: model.openGalleryForDeliveryImage,
    ).show(context);
  }

  void _optionsDialogForReceiptImages(CourierCurrentOrderTabViewModel model, BuildContext context) async {
    PlatformAlertDialog(
      title: AppStrings.GET_YOUR_IMAGE.tr(),
      content: '\n${AppStrings.SELECT_WHICH_IMAGE_OPTION_YOU_WANT_TO_CHOOSE.tr()}\n',
      defaultActionText: AppStrings.OPEN_CAMERA_DIALOG_TEXT.tr(),
      defaultFunction: model.openCameraForReceiptImages,
      defaultActionText2: AppStrings.OPEN_GALLERY_DIALOG_TEXT.tr(),
      defaultFunction2: model.openGalleryForReceiptImages,
    ).show(context);
  }

  Widget uploadReceiptWidget(String title, {Function onTap}) {
    return Expanded(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(4),
          height: SizeConfig.screenHeight * .21,
          decoration: BoxDecoration(
              border: Border.all(color: Provider.of<AppThemeViewModel>(context).themeData == AppTheme.dark? AppColors.thirdDarkColor:Theme.of(context).primaryColorLight,),
              borderRadius: BorderRadius.circular(AppConstants.ContainerRoundCorner_Radius)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                StoreangelIcons.camera_full,
                size: SizeConfig.screenHeight * .07,
                color: Theme.of(context).primaryColor,
              ),
              SizeConfig.verticalSpaceSmall(),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: AppStyles.BlackStyleWithBold800Font_24(context),
                ),
              )
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
