import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/core/enums/order_purchase_status.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/ui/shared/cantidant_rating_widget.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/shared/view_order_status.dart';

class PrepareOrderWidget extends StatelessWidget {
  final OrderByStore order;
  final int index;
  PrepareOrderWidget({this.order,this.index});
  @override
  Widget build(BuildContext context) {

    return Consumer<CourierOrderViewModel>(
        builder: (context,courierOrderViewModel,child){
          return Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.bottomPadding.bottom),
            child:Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.4,
              actions: <Widget>[
                IconSlideAction(
                  color: Colors.transparent,
                  foregroundColor: AppColors.primaryColor,
                  icon: StoreangelIcons.shoppingBasket,
                  onTap: () {
                    courierOrderViewModel.updateOrderStatus(OrderPurchaseStatus.Purchasing, index);

                  },
                ),

              ],

              secondaryActions:  <Widget>[
                IconSlideAction(
                  foregroundColor: AppColors.red,
                  color: Colors.transparent,
                  icon: StoreangelIcons.delete,
                  onTap: () {
                    courierOrderViewModel.onDeletePurchase(order);
                  },
                ),
              ],
              child: CustomFiveWidgetsTile(
                  imageUrl: order.clients.first.imageUrl,
                  trailingOneBackGroundColor:AppColors.blueGradient,
                  trailingTwoBackGroundColor: AppColors.blueGradient,
                  enableTrailingTwoPadding: false,
                  trailingOne: ViewOrderStatusWidget(status: order.status,),
                  trailingTwo: FittedBox(
                    fit: BoxFit.cover,
                    child: ViewAppImage(
                      imageUrl: order.storeDetails.image,
                    ),
                  ),
                  middleWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizeConfig.verticalSpaceSmall(),
                      Row(
                        children: [
                          Expanded(child: Text( AppStrings.ORDER.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                          Text(TimeAgoService.timeAgoSinceDate(order.orderTime, context),
                            style: AppStyles.GrayStyleItalicFont16(context),),

                        ],
                      ),
                      SizeConfig.verticalSpaceSmall(),
                      Text(order.clients.first.name,style: AppStyles.BlackStyleWithBold800Font_24(context),),
                      SizeConfig.verticalSpaceSmall(),
                      Text(AppStrings.euroSymbol+'${NumberService.priceAfterConvert(order.orderAmount, context)}'+' | '+'${order.products.length} '+AppStrings.ARTICLES.tr(),
                        style: AppStyles.BlackStyleFont20W300(context),),
                      SizeConfig.verticalSpaceSmall(),
                      CustomRatingWidget(reviewCount: 15, initialRating: 2, stars: 3.5),
                      SizeConfig.verticalSpaceMedium(),
                      Text(order.clients.first.twoLineAddress,
                        style: AppStyles.BlackStyleFont16Light(context),),
                      SizeConfig.verticalSpaceSmall(),
                    ],
                  )),
            ),
          );
        });
  }
}
