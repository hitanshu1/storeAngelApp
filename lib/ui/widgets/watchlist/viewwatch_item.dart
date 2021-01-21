import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_watchlist.dart';
import 'package:storeangelApp/ui/screens/order_courier_flow/select_product_screen.dart';
import 'package:storeangelApp/ui/screens/watchlist_detaillist_item_screen.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/custom_divider_widget.dart';
import 'package:storeangelApp/ui/shared/status_dot.dart';

class WatchListItem extends StatelessWidget {
  final PurchaseDetails item;
  final WatchListViewModel model;
  final bool showHireCourierButton;

  WatchListItem({this.item, this.model, this.showHireCourierButton:true});

  final int watchListItemCap = 5;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        model.navigateToScreen(WatchListDetailListItemScreen.routeName, context,
            arguments: WishListDetailsArgument(purchaseDetails: item));
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: SizeConfig.bottomPadding.bottom),
        child: CustomCard(
          side: BorderSide(color: Colors.transparent),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  item.listName,
                  style: AppStyles.BlackStyleWithBold800Font_24(context).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              CustomDividerWidget(
                height: 2,
              ),
              SizeConfig.CVerticalSpaceSmallMedium(),
              Padding(
                padding: SizeConfig.csmallmediumPadding.copyWith(bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      item.storeDetails.name,
                      style: AppStyles.BlackStyleWithBold800Font_20(context),
                    ),
                  ],
                ),
              ),
              SizeConfig.verticalSpaceSmall(),
              Padding(
                padding: SizeConfig.csmallmediumPadding.copyWith(top: 0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.storeDetails.street,
                        style: AppStyles.GrayStyle_Font16(context),
                      ),
                    ),
                    SizedBox(width: 12,),
                    Text(
                      "${item.quantity} ${AppStrings.ITEMS.tr()}",
                      style: AppStyles.GreenStyleWithBold800_Font20(context),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: SizeConfig.csmallmediumPadding.copyWith(top: 2, bottom: 10),
                child: Text(
                  item.storeDetails.zipCity,
                  style: AppStyles.GrayStyle_Font16(context),
                  textAlign: TextAlign.start,
                ),
              ),
              SizeConfig.CVerticalSpaceSmallMedium(),
              CustomDividerWidget(
                height: 2,
              ),
              SizeConfig.CVerticalSpaceSmallMedium(),
              Padding(
                padding: SizeConfig.csmallmediumPadding.copyWith(bottom: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Icon(StoreangelIcons.shopping_basket_full,color: AppColors.green,
                      size:SizeConfig.iconSize ,),
                    SizeConfig.horizontalSpaceSmall(),
                    Flexible(child: Text(AppStrings.GO_SHOPPING.tr(),
                    style: AppStyles.GreenStyleWithBold800_Font20(context),)),


                  ],
                )),
              SizeConfig.verticalSpaceSmall(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: item.products.length>4?4:item.products.length,
                      itemBuilder: (context, int i) {
                        final product = item.products[i];
                        return Padding(
                          padding: SizeConfig.csmallmediumPadding,
                          child: Row(
                            children: [
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: '${product.name} ',
                                    style: product.availableStatus == AvailableStatus.unknown
                                        ? AppStyles.BlackStyleFont_16(context).copyWith(
                                      height: 1
                                    )
                                        : AppStyles.BlackStyleWithBold700Font_16(context).copyWith(
                                      height: 1
                                    ),
                                  ),
                                ),
                              ),
                              SizeConfig.horizontalSpaceSmall(),
                              Text('${product.quantity}'),
                              SizeConfig.horizontalSpaceSmall(),
                              StatusDot(
                                availableStatus: product.availableStatus,
                              ),
                            ],
                          ),
                        );
                      }),
                  SizeConfig.CVerticalSpaceSmallMedium(),

                  showHireCourierButton?Padding(
                    padding: SizeConfig.padding,
                    child: ButtonWidget(onPressed: (){
                      model.navigateToScreen(SelectProductScreen.routeName, context,arguments: item);
                    },buttonText: AppStrings.LET_SHOP.tr(),
                      buttonColor: AppColors.primaryColor,
                      fontSize: SizeConfig.fontSizeMedium,
                    ),
                  ):Container(),
                  SizeConfig.verticalSpaceSmall(),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
