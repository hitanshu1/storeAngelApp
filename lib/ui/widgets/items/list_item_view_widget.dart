import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/ui/shared/customstatuscheckbox.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/created_list/alternative_item_view.dart';

class ListItemViewWidget extends StatelessWidget {
  final Product product;
  final bool enableBorder;

  ListItemViewWidget({this.product, this.enableBorder: true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(SizeConfig.sidepadding.left, SizeConfig.screenHeight * .008,
              SizeConfig.sidepadding.right, SizeConfig.screenHeight * .008),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomStatusCheckBox(
                minSize: Size(SizeConfig.screenWidth * .13, SizeConfig.screenWidth * .13),
                maxSize: Size(SizeConfig.screenWidth * .15, SizeConfig.screenWidth * .15),
                status: product.availableStatus,
                padding: 10,
              ),
              SizeConfig.horizontalSpaceSmall(),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: '${product.name} ',
                    style: AppStyles.BlackStyleFontWeight500_13(context).copyWith(height: 1),
                  ),
                ),
              ),
              SizeConfig.horizontalSpaceSmall(),
              product.assignClient != null
                  ? ViewAppImage(
                      height: 15,
                      width: 15,
                      imageUrl: product.assignClient.imageUrl,
                      radius: 15,
                    )
                  : Container(),
              SizeConfig.horizontalSpaceSmall(),
              Text('${product.quantity} x ${NumberService.priceAfterConvert(product.price,context)}',
                  style: AppStyles.BlackStyleFontWeightSmall_12(context)),
              SizeConfig.horizontalSpaceSmall(),
            ],
          ),
        ),
        product.alternativeProduct != null
            ? Container(
                color: Theme.of(context).primaryColorLight,
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: AlternativeItemView(
                    alternativeProducts: product.alternativeProduct,
                    enablePadding: false,
                    enableStatusDot: false,
                  ),
                ),
              )
            : Container(),
        Padding(
          padding: SizeConfig.sidepadding,
          child: Divider(
            color: Theme.of(context).primaryColorLight,
          ),
        )
      ],
    );
  }
}
