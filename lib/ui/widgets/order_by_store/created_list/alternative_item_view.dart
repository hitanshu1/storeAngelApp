
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/ui/widgets/items/selectableItemlist.dart';
class AlternativeItemView extends StatefulWidget {
  final List<Product>alternativeProducts;
  final bool enablePadding;
  final bool enableStatusDot;
  AlternativeItemView({this.alternativeProducts,this.enablePadding:true,this.enableStatusDot:true});
  @override
  _AlternativeItemViewState createState() => _AlternativeItemViewState();
}

class _AlternativeItemViewState extends State<AlternativeItemView> {


  bool view=true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Theme.of(context).primaryColorLight,
      child: Padding(
        padding: widget.enablePadding?SizeConfig.sidepadding:EdgeInsets.all(0),
        child: Column(
          children: [
            SizeConfig.verticalSpaceSmall(),
            Padding(
              padding: SizeConfig.sidepadding,
              child: InkWell(
                onTap: (){
                  setState(() {
                    view=!view;
                  });
                },
                child: Row(
                  children: [
                    Image.asset(AssetsPath.alternatives,color: Theme.of(context).focusColor,),
                    SizeConfig.horizontalSpaceSmall(),
                    Text('${widget.alternativeProducts.length} ${AppStrings.ALTERNATIVES_S.tr()}',style: AppStyles.BlackStyleFont_16(context),),
                    Spacer(),
                    Text(view?'${AppStrings.HIDE.tr()}':AppStrings.VIEW.tr(),style: AppStyles.GreenStyleWith_Font16(context),)

                  ],
                ),
              ),
            ),
            view?Divider(
              color: AppColors.lightGreyColor,
            ):SizeConfig.verticalSpaceSmall(),
            view?SelectableItemList(products:widget.alternativeProducts,
              enablePadding: false,showprice: true,enableStatusDot: widget.enableStatusDot,):Container()
          ],
        ),
      ),
    );
  }
}
