import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/ui/shared/customer_details/cutomer_details_widget.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:easy_localization/easy_localization.dart';

class DeclineOfferWidget extends StatelessWidget {
  final OrderOrPurchases order;
  DeclineOfferWidget({this.order});
  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.bottomPadding.bottom),
      child: Opacity(
        opacity: SizeConfig.lowOpacity,
        child: CustomerDetailsWidget(
          clientDetails: order.clientDetails,
          products: order.purchaseDetails.products,
          orderAmout: order.orderAmount,
          deliveryDate: order.selectedDate,
          title: AppStrings.OFFERS.tr(),
          trailingOne: Center(child: Icon(Icons.clear,
            color: AppColors.whiteColor,size: SizeConfig.mediumIcon,)),
          trailingTwo: FittedBox(
              fit: BoxFit.cover,
              child:ViewAppImage(
                width: 50,
                imageUrl: order.storeDetails.image,
              )
          ),),
      ),
    );
  }
}
