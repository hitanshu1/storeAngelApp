import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/numberService.dart';

class ViewDeliveredOrderItem extends StatelessWidget {
  final Product product;
  final bool enableBorderColor;
  final TextStyle totalPriceTextStyle;

  ViewDeliveredOrderItem({this.product, this.enableBorderColor: true, this.totalPriceTextStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizeConfig.horizontalSpaceSmall(),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${product.name}',
                style: AppStyles.BlackStyleFont_20(context),
              ),
              SizeConfig.verticalSpace(SizeConfig.screenHeight*.005),
              product.quantity >1
                  ? Text(
                      '${product.quantity} x ${NumberService.priceAfterConvert(product.price,context)} '+AppStrings.euro,
                      style: AppStyles.BlackStyleFont_16(context),
                    )
                  : Container()
            ],
          )),
          SizeConfig.horizontalSpaceSmall(),
          Text('${AppStrings.euro+' '}${NumberService.priceAfterConvert((product.quantity) * (product.price),context)}',
              style: totalPriceTextStyle??AppStyles.BlackStyleWithBold600Font_20(context))
        ],
      ),
      decoration: BoxDecoration(
          border:enableBorderColor?AppConstants.bottomBorder(context): Border(
              bottom:  BorderSide(color: Colors.transparent))),
    );
  }
}
