import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/ui/shared/status_dot.dart';


class ProductListDetails extends StatelessWidget {
 final List<Product> products;
 ProductListDetails({this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConfig.padding,
      child: Padding(
        padding: SizeConfig.verticalLarPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.separated(
                separatorBuilder: (context,index)=>Divider(height: SizeConfig.screenHeight*.06,
                color:AppColors.lightGrayLittleColor,),physics: NeverScrollableScrollPhysics(),shrinkWrap: true,
                itemCount: products.length,itemBuilder:(context,int i){
              return Container(
                decoration: BoxDecoration(

                  border:Border(bottom: BorderSide(color: AppColors.lightGrayDotColor))
                ),
                child:  Padding(
                  padding: SizeConfig.verticalC13Padding,
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: '${products[i].name} ',
                            style: AppStyles.BlackStyleFontWeight500_13(context),
                          ),
                        ),
                      ),
                      SizeConfig.horizontalSpaceSmall(),
                      Text('${products[i].quantity}',style: AppStyles.BlackStyleFontWeightSmall_12(context)),
                      SizeConfig.horizontalSpaceSmall(),
                      StatusDot(availableStatus: products[i].availableStatus,)

                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }


}
