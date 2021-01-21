import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/package_model.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order.dart';
import 'package:storeangelApp/ui/screens/consumer/store_details_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class OrderPackageListAndPastOrderWidget extends StatelessWidget {
  final OrderOrPurchases order;
  final CourierOrderViewModel model;

  OrderPackageListAndPastOrderWidget({this.order, this.model});

  @override
  Widget build(BuildContext context) {
    return BaseView<CourierOrderViewModel>(
      onModelReady: (model) => model.getPackagesList(),
      builder: (context, model, child) {
        if (model.state == ViewState.Busy) {
          return Container();
        }
        return CustomCard(
          child: Column(
            children: [
              SizeConfig.verticalSpaceESmall(),
              Text(
                '${order.storeDetails.name} ${AppStrings.CPACKAGE_LIST.tr()}',
                style: AppStyles.GreenStyleWithBoldFont_C20(context),
              ),
              SizeConfig.verticalSpaceESmall(),
              Padding(
                padding: SizeConfig.sidepadding,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).toggleableActiveColor,
                      borderRadius: BorderRadius.circular(AppConstants.ContainerRoundCorner_Radius)),
                  child: Padding(
                    padding: SizeConfig.innerpadding,
                    child: Row(
                      children: [
                        ViewAppImage(
                          height: SizeConfig.smallerImageHeight,
                          width: SizeConfig.smallerImageHeight,
                          imageUrl: order.storeDetails.image,
                          radius: 10,
                        ),
                        SizeConfig.horizontalSpaceSmall(),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  order.storeDetails.name,
                                  style: AppStyles.BlackStyleWithBold600Font_20(context),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        order.storeDetails.address,
                                        style: AppStyles.GrayStyle_Font16(context),
                                      ),
                                    ),
                                    SizedBox(width: 4,),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context, StoreDetailsScreen.routeName, arguments: order.storeDetails);
                                      },
                                      child: Text(
                                        AppStrings.VIEW_STORE.tr(),
                                        style: AppStyles.BlackStyleFont_20(context),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              SizeConfig.verticalSpaceESmall(),
              Padding(
                padding: SizeConfig.sidepadding,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: model.packages.length,
                    itemBuilder: (context, int index) {
                      PackageModel package = model.packages[index];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * .012),
                        decoration:
                        BoxDecoration(border: AppConstants.bottomBorder(context)),
                        child: Row(
                          children: [
                            ViewAppImage(
                              height: SizeConfig.smallImageHeight60,
                              width: SizeConfig.smallImageHeight60,
                              radius: SizeConfig.smallImageHeight60,
                              imageUrl: package.clientDetails.imageUrl,
                            ),
                            SizeConfig.horizontalSpaceSmall(),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      package.clientDetails.name,
                                      style: AppStyles.BlackStyleWithBold800Font_20(context),
                                    ),
                                    Text(
                                      package.clientDetails.street,
                                      style: AppStyles.GrayStyle_Font12(context),
                                    ),
                                    Text(package.clientDetails.addressLine, style: AppStyles.GrayStyle_Font12(context)),
                                    SizeConfig.verticalSpaceSmall(),
                                    Text(
                                      '${package.totalItems} ${AppStrings.ITEMS.tr()}',
                                      style: AppStyles.BlackStyleFont_20(context),
                                    ),
                                    SizeConfig.verticalSpaceSmall(),
                                  ],
                                ))
                          ],
                        ),
                      );
                    }),
              ),
              SizeConfig.verticalSpaceMedium(),
              Padding(
                padding: SizeConfig.sidepadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '10 minutes ago',
                      style: AppStyles.GrayStyle_Font16(context),
                    )
                  ],
                ),
              ),
              SizeConfig.verticalSpaceSmall(),
            ],
          ),
        );
      },
    );
  }
}
