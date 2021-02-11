import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/numberService.dart';

class CheckOutProductView extends StatelessWidget {
  final Product product;

  CheckOutProductView({this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConfig.sidepadding,
      child: Container(
        height: 65,
        decoration: BoxDecoration(border: AppConstants.bottomBorder(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${product.name}',
                    style: AppStyles.BlackStyleFont_16(context),
                  ),
                  SizeConfig.verticalSpaceSmall(),
                  Text(
                    AppStrings.euro + ' '+'${NumberService.addAfterCommaTwoZeros((product.quantity*product.price).toString(), context)}',
                    style: AppStyles.BlackStyleFont_16(context),
                  ),
                ],
              ),
            ),
            Text('${product.quantity} x ${AppStrings.euro + ' '}${NumberService.priceAfterConvert(product.price,context)}',
                style: AppStyles.BlackStyleFont_16(context)),
          ],
        ),
      ),
    );
  }
}
