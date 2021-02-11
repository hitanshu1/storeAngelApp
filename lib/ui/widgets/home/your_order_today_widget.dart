import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/icon_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/string_service.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/home_viewmodel.dart';
import 'package:storeangelApp/ui/screens/consumer/your_offer_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order/item_available_widget.dart';

class YourOrderTodayWidget extends StatelessWidget {
  final EdgeInsets sidePadding;
  YourOrderTodayWidget({this.sidePadding});


  Widget getTrailingTwoWidget(OrderOrPurchases order){
    if(order.status==OrderPurchaseStatus.PlaceAOrder){
      return FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('10',style: AppStyles.WhiteStyle_WithBold900_Font36,),
            Text(AppStrings.OFFERS.tr(),style: AppStyles.WhiteStyle_FontSmall,)
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
    return Consumer<HomeViewModel>(
        builder: (context,model,child){
          if(model.state==ViewState.Busy){
            return SliverToBoxAdapter(
              child: AppConstants.circulerProgressIndicator()
            );
          }

      return SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, int index) {

              return Padding(
                padding: sidePadding.copyWith(bottom: SizeConfig.bottomPadding.bottom*.7),
                child: GestureDetector(
                  onTap: (){
                    model.navigateToScreen(YourOfferScreen.routeName, context,
                    arguments: model.orderList[index]);

                  },
                  child: CustomFiveWidgetsTile(
                      trailingTwoBackGroundColor: AppColors.amberGradient,
                      trailingOneBackGroundColor: AppColors.getStatusColor(model.orderList[index].status),
                      trailingOne: Center(
                        child: Icon(IconService.getStatusIcon(model.orderList[index].status),color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
                      ),
                      trailingTwo: getTrailingTwoWidget(model.orderList[index]),
                      imageUrl: model.orderList[index].purchaseDetails.storeDetails.image,
                      enableTrailingTwoPadding:model.orderList[index].status==OrderPurchaseStatus.PlaceAOrder,
                      middleWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizeConfig.verticalSpaceSmall(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Expanded(child: Text(AppStrings.ORDER.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                              Text(TimeAgoService.timeAgoSinceDate(model.orderList[index].purchaseDetails.time, context),
                                style: AppStyles.GrayStyleItalicFont16(context),),

                            ],
                          ),
                          SizeConfig.verticalSpaceSmall(),
                          Text(StringService.orderStatus(model.orderList[index].status),style: AppStyles.BlackStyleWithBold800Font_24(context),),
                          SizeConfig.verticalSpaceSmall(),

                          Text(AppStrings.euroSymbol+' ${NumberService.priceAfterConvert(model.orderList[index].purchaseDetails.totalAmount, context)}'+' | '+'${model.orderList[index].purchaseDetails.products.length} '+AppStrings.ARTICLES.tr(),
                            style: AppStyles.BlackStyleFont20W300(context),),
                          SizeConfig.verticalSpaceSmall(),
                          ItemAvailableWidget(products: model.orderList[index].purchaseDetails.products,),
                          SizeConfig.verticalSpaceSmall(),
                          Text(model.orderList[index].purchaseDetails.storeDetails.twoLineAddress,
                            style: AppStyles.BlackStyleFont16Light(context),),
                          SizeConfig.verticalSpaceSmall(),
                        ],
                      )),
                ),
              );
            },
            childCount: model.orderList.skip(2).length,
          ));
    });
  }
}
