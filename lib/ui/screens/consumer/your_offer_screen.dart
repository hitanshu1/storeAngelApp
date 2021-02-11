import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/icon_service.dart';
import 'package:storeangelApp/core/services/string_service.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_your_offer.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order/item_available_widget.dart';
import 'package:storeangelApp/ui/widgets/your_offer/candidates_list_widget.dart';

class YourOfferScreen extends StatelessWidget {
  static const String routeName = 'yourOrderScreen';
  final OrderOrPurchases order;
  YourOfferScreen({this.order});
  Widget getTrailingTwoWidget(OrderOrPurchases order){
    if(order.status==OrderPurchaseStatus.PlaceAOrder){
      return FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('10',style: AppStyles.WhiteStyle_WithBold900_Font36,),
            Text(AppStrings.DEALS.tr(),style: AppStyles.WhiteStyle_FontSmall,)
          ],
        ),
      );
    }
    return FittedBox(
      fit: BoxFit.cover,
      child: ViewAppImage(
        imageUrl: order.clientDetails.imageUrl,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BaseView<YourOfferViewModel>(
        builder: (context,model,child){
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    SizedBox(
                      height: SizeConfig.smallHeaderSize+(SizeConfig.tileHeight*.47),
                    ),
                    AppHeader(

                      height:SizeConfig.smallHeaderSize ,
                      isBack: true,
                    ),

                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: SizeConfig.sidepadding,
                          child: CustomFiveWidgetsTile(
                            enableTrailingTwoPadding: order.status==OrderPurchaseStatus.PlaceAOrder,
                              trailingTwoBackGroundColor: AppColors.amberGradient,
                              trailingOneBackGroundColor: AppColors.getStatusColor(order.status),
                              trailingOne: Center(
                                child: Icon(IconService.getStatusIcon(order.status),color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
                              ),
                              trailingTwo: getTrailingTwoWidget(order),
                              imageUrl: order.purchaseDetails.storeDetails.image,

                              middleWidget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizeConfig.verticalSpaceSmall(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: Text(AppStrings.ORDER.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                                      Text(TimeAgoService.timeAgoSinceDate(DateTime.now().subtract(Duration(
                                          minutes: 5
                                      )), context),
                                        style: AppStyles.GrayStyleItalicFont16(context),),
                                    ],
                                  ),
                                  SizeConfig.verticalSpaceSmall(),
                                  Text(StringService.orderStatus(order.status),style: AppStyles.BlackStyleWithBold800Font_24(context),),
                                  SizeConfig.verticalSpaceSmall(),
                                  Text(AppStrings.euroSymbol+'${order.purchaseDetails.totalAmount} | ${order.purchaseDetails.products.length}'+AppStrings.ARTICLES.tr(),
                                    style: AppStyles.BlackStyleFont16Light(context),),
                                  SizeConfig.verticalSpaceSmall(),
                                  ItemAvailableWidget(products: order.purchaseDetails.products,),
                                  SizeConfig.verticalSpaceSmall(),
                                  Text(order.purchaseDetails.storeDetails.twoLineAddress,
                                    style: AppStyles.BlackStyleFont16Light(context),),
                                  SizeConfig.verticalSpaceSmall(),


                                ],
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizeConfig.verticalSliverMediumSpace(),

              SliverToBoxAdapter(
                child: Padding(
                  padding:SizeConfig.sidepadding,
                  child: TitleTextWidget(title: AppStrings.YOUR_OFFERS.tr()),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              CandidatesListWidget(candidates: order.candidates,order: order,)

            ],
          );
        },
      ),
    );
  }
}
