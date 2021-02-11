import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/shared/circular_image_with_border.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class AlterNativeItemTileWidget extends StatelessWidget {
  final Product product;
  AlterNativeItemTileWidget({this.product});
  @override
  Widget build(BuildContext context) {
    return AppShapeItem(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor
        ),
        child: Padding(
          padding: SizeConfig.innerpadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ViewAppImage(
                  height: SizeConfig.screenHeight*.11,
                  imageUrl: product.imageUrl,
                ),
              ),
              Text(product.name,style: AppStyles.BlackStyleWithBold800Font_20(context),
              maxLines: 2,),
              SizeConfig.verticalSpaceVeryGap(),
              Text(AppStrings.euroSymbol+NumberService.priceAfterConvert(product.price, context),style: AppStyles.BlackStyleFont20W300(context),),
              SizeConfig.verticalSpaceVeryGap(),
              SizedBox(
                height: 30,
                child: ListView.builder(scrollDirection: Axis.horizontal,
                    itemCount: product.alterNativeAddedClients.length,
                    itemBuilder: (context,int index){
                  return CircularImageWithBorder(
                    imageUrl: product.alterNativeAddedClients[index].imageUrl,
                    isActive: false,
                    height: 30,

                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
