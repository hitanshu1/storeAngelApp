import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/ui/shared/custom_item_status_widget.dart';
import 'package:storeangelApp/ui/shared/item_thumbnail_image_widget.dart';
import 'package:storeangelApp/ui/shared/smalltextfield.dart';
import 'package:storeangelApp/ui/shared/status_dot.dart';
import 'package:easy_localization/easy_localization.dart';

class CourierItemTileWidget extends StatefulWidget {
 final  Product product;
 final bool isBorder;
 final bool enableQuantity;
 final bool enablePrice;
 final bool enablePriceText;
 final availableButton;
 final bool editStatus;
 final bool showNewPrice;
 final bool isItalicFont;
 final Function onClickStatus;
 final bool enableQuantityText;
 final bool enableEditPrice;
 final Function changeState;
  CourierItemTileWidget({@required this.onClickStatus,this.isItalicFont:true,
    this.showNewPrice:false,this.editStatus:false,this.availableButton:true,this.product,@required this.isBorder,this.enableQuantity:false,
    this.enablePrice:false,this.enablePriceText:false,this.enableQuantityText:false,this.enableEditPrice:false,this.changeState});

  @override
  _CourierItemTileWidgetState createState() => _CourierItemTileWidgetState();
}

class _CourierItemTileWidgetState extends State<CourierItemTileWidget> {


  TextEditingController controller=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text='${widget.product.price}';
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color:widget.isBorder?(Provider.of<AppThemeViewModel>(context).themeData == AppTheme.dark
                      ? AppColors.backgroundColor
                      : Theme.of(context).primaryColorLight):Colors.transparent
              )
          )
      ) ,
      child: Padding(
        padding: SizeConfig.verticalPadding,
        child: Row(
          children: [
            widget.editStatus?InkWell(
              onTap: (){
                if(widget.onClickStatus!=null){
                  widget.onClickStatus();
                }
              },
              child: CustomItemStatusWidget(
                status: widget.product.itemStatus,
              size:  SizeConfig.smallerImageheight75,
              child:ItemThumbnailImageWidget(
                url: widget.product.imageUrl,
              ),),
            ):ItemThumbnailImageWidget(
              url: widget.product.imageUrl,
            ),
            SizeConfig.horizontalSpaceMedium(),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.product.name,style: AppStyles.BlackStyleFont_20(context),),
                SizeConfig.verticalSpaceVeryGap(),
                widget.enableQuantityText?Text('${widget.product.quantity} '+AppStrings.PIECES.tr(),
                  style: AppStyles.GrayStyle_Font16(context),):Container(),
              ],
            )),
            SizeConfig.horizontalSpaceSmall(),



            Column(

              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    widget.enableQuantity?Row(
                      children: [
                        widget.availableButton?StatusDot(
                          availableStatus: widget.product.availableStatus,
                        ):Container(),
                        SizeConfig.horizontalSpaceSmall(),
                        Text(
                            '${widget.product.quantity} x ',
                            style: widget.isItalicFont?AppStyles.GrayStyleItalicFont16(context):AppStyles.BlackStyleFont_16(context)),
                      ],
                    ):Container(),
                    widget.enablePrice?Container(
                      width: 70,
                      height: 40,
                      child: Center(child: Text(AppStrings.euroSymbol+'${NumberService.addAfterCommaTwoZeros('${widget.product.price}', context)}'),),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(SizeConfig.radiusSmall),
                      ),
                    ):Container(),
                    widget.enablePriceText?Container(
                      width: 70,
                      height: 40,
                      child: Center(child: Text(AppStrings.euroSymbol+'${NumberService.addAfterCommaTwoZeros('${widget.product.price}', context)}'),),

                    ):Container(),
                    widget.enablePrice||widget.enablePriceText||widget.enableEditPrice?Container():
                    Text(AppStrings.euroSymbol+NumberService.addAfterCommaTwoZeros('${widget.product.price}',context),
                      style: widget.isItalicFont?AppStyles.GrayStyleItalicFont16(context):AppStyles.BlackStyleFont_16(context),),
                    widget.enableEditPrice?Container(
                        width: 70,
                        height: 40,
                        child:
                        SmallTextField(color: AppColors.whiteColor,
                          controller:controller,
                          style: AppStyles.BlackStyleFont_20(context),
                          onChange: (val){
                            widget.product.price=double.parse(val);
                            widget.changeState();
                          },
                          onSubmit: (val) {
                            try {
                              if (double.parse(val) >= 0) {
                                print('object2');
                                widget.product.price=double.parse(val);
                                widget.changeState();
                              }
                            } catch (e) {

//                    widget.controller.text =val;
                            }

                          },
                          validator: (value) {
                            final n = int.tryParse(value);

                            if (n < 1) {
                              return 'Invalid charge';
                            }
                            return null;
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputType: TextInputType.numberWithOptions(signed: false, decimal: false),
                        )):
                    Container(),
                    SizeConfig.horizontalSpaceSmall(),
                  ],
                ),
                widget.showNewPrice&&widget.product.newPrice!=null?Text('${AppStrings.NEW_PRICE.tr()}'+AppStrings.euroSymbol+NumberService.addAfterCommaTwoZeros('${widget.product.newPrice}',context),
                style: AppStyles.GreenStyleWithBold800_Font16(context).copyWith(
                  color: AppColors.availableStatusColor(widget.product.availableStatus)
                ),):Container()
              ],
            ),


          ],
        ),
      ),
    );
  }
}
