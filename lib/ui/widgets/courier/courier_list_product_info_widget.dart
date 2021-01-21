import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/ui/shared/status_dot.dart';

class CourierListProductInfoWidget extends StatelessWidget {
  final Product product;
  CourierListProductInfoWidget({this.product});
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        StatusDot(
          availableStatus: product.availableStatus,
        ),
        SizeConfig.horizontalSpaceSmall(),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '${product.name} ',
              style: AppStyles.BlackStyleWithBold600Font_20(context),
            ),
          ),
        ),
        product.quantity != 0
            ? Text('${product.quantity}')
            : Container()
      ],
    );
  }
}
