import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/home_viewmodel.dart';
import 'package:storeangelApp/ui/screens/order_delivered_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/buttonWithIcon.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order/item_available_widget.dart';


class HomePurchasesTiles extends StatelessWidget {
  final EdgeInsets sidePadding;

  const HomePurchasesTiles({Key key,@required this.sidePadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        if (homeViewModel.state == ViewState.Busy) {
          return SliverToBoxAdapter(
            child: AppConstants.circulerProgressIndicator(),
          );
        } else {
          if (homeViewModel.completedOrders.length > 0) {
            return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, int index) {
                    return Padding(
                      padding: sidePadding.copyWith(bottom: SizeConfig.bottomPadding.bottom*.5),
                      child: Opacity(
                        opacity: .6,
                        child: InkWell(
                          onTap: (){
                            homeViewModel.navigateToScreen(OrderDeliveredScreen.routeName, context,
                                arguments: OrderDeliveredScreenArgument(orderOrPurchases: homeViewModel.completedOrders[index], isPrePaid: true));
//                            if (homeViewModel.orderList[index].status == OrderPurchaseStatus.Finished || homeViewModel.orderList[index].status == OrderPurchaseStatus.OrderDelivered) {
//                              homeViewModel.navigateToScreen(OrderDeliveredScreen.routeName, context,
//                                  arguments: OrderDeliveredScreenArgument(orderOrPurchases: homeViewModel.orderList[index], isPrePaid: false));
//                            }else if(homeViewModel.orderList[index].status==OrderPurchaseStatus.Proposal){
//                              homeViewModel.navigateToScreen(OrderPageScreen.routeName, context,
//                                  arguments: homeViewModel.orderList[index].purchaseDetails);
//                            } else {
//                              homeViewModel.navigateToScreen(CourierStatusScreen.routeName, context,
//                                  arguments: CourierStatusScreenArgument(orderOrPurchases: homeViewModel.orderList[index]));
//                            }
                          },
                          child: CustomFiveWidgetsTile(
                              trailingTwoBackGroundColor: AppColors.blueGradient,
                              trailingOneBackGroundColor: AppColors.primaryGradient,
                              trailingOne: Center(
                                child: Icon(StoreangelIcons.shopping_basket,color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
                              ),
                              enableTrailingTwoPadding: false,
                              trailingTwo:FittedBox(
                                fit: BoxFit.cover,
                                child: ViewAppImage(

                                  imageUrl: homeViewModel.completedOrders[index].purchaseDetails.customer.imageUrl,
                                ),
                              ),
                              imageUrl: homeViewModel.completedOrders[index].purchaseDetails.storeDetails?.image,
                              middleWidget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizeConfig.verticalSpaceSmall(),
                                  Row(
                                    children: [
                                      Expanded(child: Text(AppStrings.PURCHASING.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                                      Text(TimeAgoService.timeAgoSinceDate(DateTime.now().subtract(Duration(minutes: 15)), context),
                                        style: AppStyles.GrayStyleItalicFont16(context),),

                                    ],
                                  ),
                                  SizeConfig.verticalSpaceSmall(),
                                  Text(AppStrings.DELIVERED.tr(),style: AppStyles.BlackStyleWithBold800Font_20(context),),
                                  SizeConfig.verticalSpaceSmall(),
                                  Text(AppStrings.BY.tr()+' '+homeViewModel.completedOrders[index].clientDetails.name,
                                    style: AppStyles.BlackStyleFont_20(context),),
                                  SizeConfig.verticalSpaceSmall(),
                                  ItemAvailableWidget(products: homeViewModel.completedOrders[index].purchaseDetails.products,),
                                  SizeConfig.verticalSpaceSmall(),
                                  Text(homeViewModel.completedOrders[index].purchaseDetails.storeDetails.twoLineAddress,
                                    style: AppStyles.BlackStyleFont16Light(context),),
                                  SizeConfig.verticalSpaceSmall(),
                                ],
                              )),
                        ),
                      ),
                    );
                  },
                  childCount: homeViewModel.completedOrders.length,
                ));
          } else {
            return SliverToBoxAdapter(
              child: Padding(
                padding: sidePadding.copyWith(
                    bottom: SizeConfig.screenHeight * .02
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.NO_RUNNING_ORDER_YET.tr(),
                      style: AppStyles.BlackStyleFont_20(context),
                    ),
                    SizeConfig.verticalSpaceMedium(),
                    Center(
                      child: ButtonWithIcon(
                          height: 50,
                          weight: SizeConfig.screenWidth * .5,
                          buttonColor: AppColors.primaryGradient,
                          radius: AppConstants.button_Radius,
                          icon: Icons.add_circle,
                          iconSize: SizeConfig.iconSize * 1.2,
                          fontSize: SizeConfig.fontSizeMedium,
                          buttonText: AppStrings.CREATE_A_LIST.tr(),
                          onPressed: () {}),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
