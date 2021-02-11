import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order.dart';
import 'package:storeangelApp/ui/screens/courier/courier_order_details_screen.dart';
import 'package:storeangelApp/ui/shared/store_order_details_widget.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:easy_localization/easy_localization.dart';


class CourierOngoingOrderWidget extends StatelessWidget {
  final List<OrderByStore>orderByStoreList;
  final CourierOrderViewModel courierOrderViewModel;
  CourierOngoingOrderWidget({this.orderByStoreList,this.courierOrderViewModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColor
      ),
      child: Padding(
        padding:SizeConfig.sidepadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizeConfig.verticalSpaceSmall(),
            TitleTextWidget(title: AppStrings.ONGOING_ORDERS.tr(),
              color: AppColors.whiteColor,),
            SizeConfig.verticalSpaceMedium(),
            orderByStoreList.length>0?CarouselSlider.builder(
                options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 10),
                    height: SizeConfig.tileHeight,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      courierOrderViewModel.setSelectedIndex(index);
                    }
                ),
                itemCount: orderByStoreList.length,
                itemBuilder: (context, index) {
                  return FittedBox(
                    child: InkWell(
                      child: StoreOrderDetailsWidget(
                        orderByStore: orderByStoreList[index],
                      ),
                      onTap: (){
                        courierOrderViewModel.navigateToScreen(CourierOrderDetailsScreen.routeName, context,
                        arguments: orderByStoreList[index]);
                      },
                    ),
                  );
                }):Text(AppStrings.THERE_ARE_NO_PURCHASES_ON.tr(),
              style: AppStyles.WhiteStyle_Font20,
              textAlign: TextAlign.center,),
            orderByStoreList.length>1?Container(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: orderByStoreList.map((url) {
                  int index = orderByStoreList.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: courierOrderViewModel.selectedIndex == index
                          ? AppColors.whiteColor
                          : Theme.of(context).primaryColorLight,
                    ),
                  );
                }).toList(),
              ),
            ):SizeConfig.verticalSpaceMedium(),
          ],
        ),
      ),
    );
  }
}
