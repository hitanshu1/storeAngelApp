import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order_details.dart';
import 'package:storeangelApp/ui/screens/courier/courier_delivery_details_screen.dart';
import 'package:storeangelApp/ui/shared/customer_details/cutomer_details_widget.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/view_order_status.dart';

class CourierOrderDetailsTabThree extends StatelessWidget {
  final OrderByStore orderByStore;
  CourierOrderDetailsTabThree({this.orderByStore});
  @override
  Widget build(BuildContext context) {
    return Consumer<CourierOrderDetailsViewModel>(
        builder: (context,courierOrderDetailsViewModel,child){
          return MultiSliver(
            children: [
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: TitleTextWidget(title: AppStrings.DELIVERY_ADDRESSES.tr()+":"),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverPadding(padding: SizeConfig.sidepadding,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Padding(
                      padding: SizeConfig.verticalPadding,
                      child: GestureDetector(
                        onTap: (){
                          courierOrderDetailsViewModel.navigateToScreen(CourierDeliveryDetailsScreen.routeName,
                              arguments: CourierDeliveryDetailsArguments(
                                participant: orderByStore.participants[index],
                                  clientDetails: orderByStore.participants[index].clientDetails,
                                  orderByStore: orderByStore
                              ));
                        },

                        child: CustomerDetailsWidget(
                            deliveryDate: orderByStore.orderTime,
                            orderAmout: orderByStore.orderAmount,
                            products: orderByStore.participants[index].products,
                            clientDetails: orderByStore.participants[index].clientDetails,
                            trailingOneBackGroundColor: AppColors.blueGradient,
                            trailingOne: Center(
                              child: ViewOrderStatusWidget(
                                status: orderByStore.participants[index].status,
                              ),
                            ), trailingTwo:  FittedBox(
                            fit: BoxFit.cover,
                            child:ViewAppImage(
                              width: 50,
                              imageUrl: orderByStore.storeDetails.image,
                            )
                        ), title: AppStrings.DELIVERY_ADDRESSES.tr()),
                      ),
                    );
                  },
                  childCount: orderByStore.participants.length,
                ),
              ),),

            ],
          );
        });
  }
}
