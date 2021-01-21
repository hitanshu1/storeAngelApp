import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/ui/shared/customstatuscheckbox.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class OrderAndClientBackgroundView extends StatelessWidget {
  final PurchaseDetails purchaseDetails;

  OrderAndClientBackgroundView({this.purchaseDetails});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: Column(
        children: [
          Text(
            AppConstants.getTimeString(purchaseDetails?.time??DateTime.now()),
            style: AppStyles.BlackStyleFont_16(context),
          ),
          SizeConfig.verticalSpaceBigMedium(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    ViewAppImage(
                      imageUrl: purchaseDetails.storeDetails.image,
                      height: SizeConfig.screenWidth * .1,
                      width: SizeConfig.screenWidth * .1,
                      radius: 5,
                    ),
                    SizeConfig.VerticalSpaceSmallMedium(),
                    FittedBox(
                      child: Text(
                        purchaseDetails.storeDetails.name,
                        style: AppStyles.BlackStyleWithBold600Font_20(context).copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    SizeConfig.verticalSpaceSmall(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: Text(
                        '${purchaseDetails.storeDetails.street ?? ''}',
                        style: AppStyles.GrayStyle_FontMedium(context),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: Text(
                        '${purchaseDetails.storeDetails.txtZip ?? ''}',
                        style: AppStyles.GrayStyle_FontMedium(context),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: Text(
                        '${purchaseDetails.storeDetails.city ?? ''}',
                        style: AppStyles.GrayStyle_FontMedium(context),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              SizeConfig.horizontalSpaceSmall(),
              Column(
                children: [
                  CustomStatusCheckBox(
                    status: AvailableStatus.plenty,
                    size: SizeConfig.iconSize * 1.5,
                  ),
                  SizeConfig.verticalSpaceSmall(),
                  Text(
                    '${purchaseDetails.quantity}/10 ${AppStrings.ITEMS.tr()}',
                    textAlign: TextAlign.center,
                    style: AppStyles.BlackStyleFont_16(context),
                  )
                ],
              ),
              SizeConfig.horizontalSpaceSmall(),
              Expanded(
                child: Column(
                  children: [
                    ViewAppImage(
                      height: SizeConfig.screenWidth * .1,
                      width: SizeConfig.screenWidth * .1,
                      radius: 40,
                      imageUrl: 'https://images-na.ssl-images-amazon.com/images/I/41dd%2Bg%2BIxvL.jpg',
                    ),
                    SizeConfig.VerticalSpaceSmallMedium(),
                    FittedBox(
                      child: Text(
                        '${purchaseDetails.customer.name}',
                        style: AppStyles.BlackStyleWithBold600Font_20(context).copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    SizeConfig.verticalSpaceSmall(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: Text(
                        '${purchaseDetails.storeDetails.txtZip ?? ''}',
                        style: AppStyles.GrayStyle_FontMedium(context),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: Text(
                        '${purchaseDetails.storeDetails.city ?? ''}',
                        style: AppStyles.GrayStyle_FontMedium(context),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizeConfig.verticalSpaceMedium(),
        ],
      ),
    );
  }
}
