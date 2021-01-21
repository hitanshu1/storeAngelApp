import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/ui/shared/customstatuscheckbox.dart';
import 'package:storeangelApp/ui/shared/item_thumbnail_image_widget.dart';
import 'package:storeangelApp/ui/shared/status_dot.dart';
import 'package:easy_localization/easy_localization.dart';

class CourierItemTileWidget extends StatelessWidget {
 final  Product product;
 final bool isBorder;
 final bool enableQuantity;
 final bool enablePrice;
 final bool enablePriceText;
 final availableButton;
 final bool editStatus;
 final bool showNewPrice;
 final bool isItalicFont;
  CourierItemTileWidget({this.isItalicFont:true,this.showNewPrice:false,this.editStatus:false,this.availableButton:true,this.product,@required this.isBorder,this.enableQuantity:false,this.enablePrice:false,this.enablePriceText:false});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color:isBorder?(Provider.of<AppThemeViewModel>(context).themeData == AppTheme.dark
                      ? AppColors.backgroundColor
                      : Theme.of(context).primaryColorLight):Colors.transparent
              )
          )
      ) ,
      child: Padding(
        padding: SizeConfig.verticalPadding,
        child: Row(
          children: [
            editStatus?CustomStatusCheckBox(status: product.availableStatus,
            size:  SizeConfig.smallerImageheight75,
            child:ItemThumbnailImageWidget(
              url: product.imageUrl,
            ) ,):ItemThumbnailImageWidget(
              url: product.imageUrl,
            ) ,
            SizeConfig.horizontalSpaceMedium(),
            Expanded(child: Text(product.name,style: AppStyles.BlackStyle_Font16(context),)),
            SizeConfig.horizontalSpaceSmall(),



            Column(

              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    enableQuantity?Row(
                      children: [
                        availableButton?StatusDot(
                          availableStatus: product.availableStatus,
                        ):Container(),
                        SizeConfig.horizontalSpaceSmall(),
                        Text(
                            '${product.quantity} x ',
                            style: isItalicFont?AppStyles.GrayStyleItalicFont16(context):AppStyles.GrayStyle_Font16(context)),
                      ],
                    ):Container(),
                    enablePrice?Container(
                      width: 70,
                      height: 40,
                      child: Center(child: Text(AppStrings.euroSymbol+'${product.price}'),),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(SizeConfig.radiusSmall),
                      ),
                    ):Container(),
                    enablePriceText?Container(
                      width: 70,
                      height: 40,
                      child: Center(child: Text(AppStrings.euroSymbol+'${product.price}'),),

                    ):Container(),
                    enablePrice||enablePriceText?Container():
                    Text(AppStrings.euroSymbol+NumberService.priceAfterConvert(product.price,context),
                      style: isItalicFont?AppStyles.GrayStyleItalicFont16(context):AppStyles.GrayStyle_Font16(context),),
                  ],
                ),
                showNewPrice&&product.newPrice!=null?Text('${AppStrings.NEW_PRICE.tr()}'+AppStrings.euroSymbol+NumberService.priceAfterConvert(product.newPrice,context),
                style: AppStyles.GreenStyleWithBold800_Font16(context).copyWith(
                  color: AppColors.availableStatusColor(product.availableStatus)
                ),):Container()
              ],
            )

          ],
        ),
      ),
    );
  }
}
