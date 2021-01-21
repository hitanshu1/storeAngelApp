import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_available_bar.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';

class AvailabilityBar extends StatelessWidget {
  final List<Product>products;
  final double width;
  AvailabilityBar({@required this.products,this.width});





  @override
  Widget build(BuildContext context) {
    return BaseView<AvailableBarViewModel>(
      onModelReady: (model)=>model.initializeData(products),
      builder: (context,model,child){
        return FittedBox(
          child: Container(
            child: Row(
              children: [
                Container(
                  width: SizeConfig.screenWidth*model.available/10,
                  height: 5,

                  decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        bottomLeft: Radius.circular(2),

                      )
                  ),
                ),
                Container(
                  width:SizeConfig.screenWidth*model.someAvailable/10,
                  height: 5,
                  color: AppColors.amber.withOpacity(1),
                ),
                Container(
                  width: SizeConfig.screenWidth*model.unavailable/10,
                  height: 5,

                  decoration: BoxDecoration(
                      color: AppColors.red.withOpacity(1),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                      )
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
