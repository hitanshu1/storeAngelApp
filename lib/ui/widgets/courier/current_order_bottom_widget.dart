import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/courier_order_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_current_order_screen.dart';
import 'package:storeangelApp/ui/shared/platform_alert_dialog.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/courier/view_order_product_list.dart';

enum CurrentPageImageType{DeliveredItem,Receipt}

class CurrentOrderBottomWidget extends StatelessWidget {
  final CurrentOrderViewModel model;
  final OrderOrPurchases order;
  CurrentOrderBottomWidget({@required this.model,@required this.order});

  @override
  Widget build(BuildContext context) {
    switch(model.courierOrderStatus){
      case CourierOrderStatus.GOTOSTORE:
        return _goToStore(context);
      case CourierOrderStatus.STARTSHOPPING:
        return ViewOrderProductList(products: order.purchaseDetails.products,);
      case CourierOrderStatus.SHOPPINGDONE:
        return ViewOrderProductList(products: order.purchaseDetails.products,);
      case CourierOrderStatus.BRING_ITEMS:
        return _bringItems(context);
      case CourierOrderStatus.DELIVERED:
        return _bringItems(context);
      default:
        return Container();
    }
  }


  Widget _goToStore(BuildContext context)=>Column(
    children: [
      SizeConfig.CVerticalSpaceBig(),
      ViewAppImage(
        width: SizeConfig.smallImageHeight55,
        height: SizeConfig.smallImageHeight55,
        radius: 10,
        imageUrl: order.storeDetails.image,
      ),
      SizeConfig.CVerticalSpaceMedium(),
      Text(order.storeDetails.street,style: AppStyles.BlackStyleFont_20(context),),
      SizeConfig.CVerticalSpaceMedium(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsPath.smallfind),
          SizeConfig.horizontalSpaceSmall(),
          Text(AppStrings.FIND_A_WAY.tr(),style: AppStyles.BlackStyleFont_20(context),)

        ],
      )
    ],
  );

  Widget _bringItems(BuildContext context)=>Padding(
    padding: SizeConfig.sidepadding,
    child: Column(
      children: [
        SizeConfig.CVerticalSpaceMedium25(),
        ViewAppImage(
          imageUrl: order.clientDetails.imageUrl,
          height: 50,
          width: 50,
          radius: 50,
        ),
        SizeConfig.CVerticalSpaceSmallMediumC12(),
        Text('Bernard Flores',style: AppStyles.BlackStyleWithBold800Font_24(context),),
        SizeConfig.CVerticalSpaceSmallMedium(),
        Text(order.storeDetails.street,style: AppStyles.BlackStyleFont_20(context),),
        SizeConfig.CVerticalSpacevMedium(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsPath.smallfind),
            SizeConfig.horizontalSpaceSmall(),
            Text(AppStrings.FIND_A_WAY.tr(),style: AppStyles.BlackStyleFont_20(context),)

          ],
        ),
        SizeConfig.CVerticalSpacevEMedium(),
        Row(
          children: [
            Expanded(
              child: InkWell(
                child: model.deliveredImage!=null?Container(
                  height: 200,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: FileImage(model.deliveredImage),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(AppConstants.button_Radius)
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.darkGrayColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(AppConstants.button_Radius)
                    ),
                    child: Column(
                      children: [
                        SizeConfig.CVerticalSpaceExtraBig(),
                        SizedBox(
                            height: 40,
                            child: Image.asset(AssetsPath.roundWhitSelected)),
                        SizeConfig.CVerticalSpacevEMedium(),
                        Text(AppStrings.DELIVERED_ITEMS.tr(),style: AppStyles.WhiteStyle_Font20,),
                        Text(AppStrings.RETAKE.tr(),style: AppStyles.WhiteStyle_Font20,)
                      ],
                    ),
                  ),
                ):
                Container(
                  height: 200,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(AppConstants.button_Radius)
                  ),
                  child: Column(
                    children: [
                      SizeConfig.CVerticalSpace60(),
                      SizedBox(
                          height: 30,
                          child: Image.asset(AssetsPath.camera)),
                      SizeConfig.CVerticalSpaceExtraBig(),
                      Text(AppStrings.DELIVERED_ITEMS.tr(),style: AppStyles.BlackStyleFont_20(context),)
                    ],
                  ),
                ),
                onTap: (){
                  _optionsDialogBox(model, context,CurrentPageImageType.DeliveredItem);
                },
              ),
            ),
            SizeConfig.horizontalSpaceMedium(),
            Expanded(
              child: InkWell(
                child: model.receiptImage!=null?Container(
                  height: 200,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: FileImage(model.receiptImage),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(AppConstants.button_Radius)
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.darkGrayColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(AppConstants.button_Radius)
                    ),
                    child: Column(
                      children: [
                        SizeConfig.CVerticalSpaceExtraBig(),
                        SizedBox(
                            height: 40,
                            child: Image.asset(AssetsPath.roundWhitSelected)),
                        SizeConfig.CVerticalSpacevEMedium(),
                        Text(AppStrings.RECEIPT.tr(),style: AppStyles.WhiteStyle_Font20,),
                        Text(AppStrings.RETAKE.tr(),style: AppStyles.WhiteStyle_Font20,)
                      ],
                    ),
                  ),
                ):Container(
                  height: 200,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(AppConstants.button_Radius)
                  ),
                  child: Column(
                    children: [
                      SizeConfig.CVerticalSpace60(),
                      SizedBox(
                          height: 30,
                          child: Image.asset(AssetsPath.camera)),
                      SizeConfig.CVerticalSpaceExtraBig(),
                      Text(AppStrings.RECEIPT.tr(),style: AppStyles.BlackStyleFont_20(context),)
                    ],
                  ),
                ),
                onTap: (){
                  _optionsDialogBox(model, context,CurrentPageImageType.Receipt);
                },
              ),
            )
          ],
        )
      ],
    ),
  );

  void _optionsDialogBox(CurrentOrderViewModel model, BuildContext context,CurrentPageImageType currentPageImageType) async {
    PlatformAlertDialog(
      title: '${AppStrings.GET_YOUR_IMAGE.tr()}',
      content: '\n${AppStrings.SELECT_WHICH_IMAGE_OPTION_YOU_WANT_TO_CHOOSE.tr()}\n',
      defaultActionText: AppStrings.OPEN_CAMERA_DIALOG_TEXT.tr(),
      defaultFunction: (){
        model.openCamera(currentPageImageType);
      },
      defaultActionText2: AppStrings.OPEN_GALLERY_DIALOG_TEXT.tr(),
      defaultFunction2: (){
        model.openGallery(currentPageImageType);
      },
    ).show(context);
  }
}
