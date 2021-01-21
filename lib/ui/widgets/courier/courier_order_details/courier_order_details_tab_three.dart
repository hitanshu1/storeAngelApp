import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order_details.dart';
import 'package:storeangelApp/ui/screens/courier/courier_delivery_details_screen.dart';
import 'package:storeangelApp/ui/shared/customer_details/cutomer_details_widget.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:easy_localization/easy_localization.dart';

class CourierOrderDetailsTabThree extends StatelessWidget {
  final OrderByStore orderByStore;
  final CourierOrderDetailsViewModel courierOrderDetailsViewModel;
  CourierOrderDetailsTabThree({this.orderByStore,this.courierOrderDetailsViewModel});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizeConfig.verticalSpaceSmall(),
        Padding(
          padding: SizeConfig.sidepadding,
          child: TitleTextWidget(title: AppStrings.DELIVERY_ADDRESSES.tr()),
        ),
        Expanded(child: Padding(
          padding: SizeConfig.sidepadding,
          child: ListView.builder(itemCount: orderByStore.clients.length,
              padding: EdgeInsets.zero,
              itemBuilder:(context,int index){
                return Padding(
                  padding: SizeConfig.verticalPadding,
                  child: GestureDetector(
                    onTap: (){
                      courierOrderDetailsViewModel.navigateToScreen(CourierDeliveryDetailsScreen.routeName,
                      arguments: CourierDeliveryDetailsArguments(
                        clientDetails: orderByStore.clients[index],
                        orderByStore: orderByStore
                      ));
                    },

                    child: CustomerDetailsWidget(
                        deliveryDate: orderByStore.orderTime,
                        orderAmout: orderByStore.orderAmount,
                        products: orderByStore.products,
                        clientDetails: orderByStore.clients[index],
                        trailingOneBackGroundColor: AppColors.blueGradient,
                        trailingOne: Center(
                          child: Icon(StoreangelIcons.change_to_courier_profile_screen,
                          color: AppColors.whiteColor,size: SizeConfig.mediumIcon,),
                        ), trailingTwo:  FittedBox(
                        fit: BoxFit.cover,
                        child:ViewAppImage(
                          width: 50,
                          imageUrl: orderByStore.storeDetails.image,
                        )
                    ), title: AppStrings.DELIVERY_ADDRESSES.tr()),
                  ),
                );
              }),
        ))

      ],
    );
  }
}
