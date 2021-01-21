import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/numberService.dart';

class ItemAvailableWidget extends StatelessWidget {
  final List<Product>products;
  ItemAvailableWidget({this.products});

  Widget viewWidget({Color color,int quantity}){
    return Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle
      ),
      child: Center(child: Text('$quantity',style: AppStyles.WhiteStyle_Font16,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        viewWidget(color:AppColors.green ,quantity: NumberService.getAvailableProduct(products,AvailableStatus.plenty)),
        SizeConfig.horizontalSpaceVeryGap(),
        viewWidget(color:AppColors.amber,quantity: NumberService.getAvailableProduct(products,AvailableStatus.few) ),
        SizeConfig.horizontalSpaceVeryGap(),
        viewWidget(color:AppColors.red,quantity: NumberService.getAvailableProduct(products,AvailableStatus.runOut) ),
      ],
    );

  }
}
