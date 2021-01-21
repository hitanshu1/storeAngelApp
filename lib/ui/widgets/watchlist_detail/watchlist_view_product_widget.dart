import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/ui/shared/custom_divider_widget.dart';
import 'package:storeangelApp/ui/shared/customstatuscheckbox.dart';
import 'package:storeangelApp/ui/shared/status_dot.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/created_list/alternative_item_view.dart';

class WatchListViewProductWidget extends StatelessWidget {
  final bool enableBorder;
  final Function onRemove;
  final Product product;
  WatchListViewProductWidget({this.product,this.onRemove,this.enableBorder});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.4,
      secondaryActions:  <Widget>[
        IconSlideAction(
          foregroundColor: AppColors.primaryColor,
          color: Colors.red,
          iconWidget: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(StoreangelIcons.delete_icon, color: AppColors.whiteColor, size: SizeConfig.iconSize,),
              SizeConfig.horizontalSpaceSmall(),
              Text(
                AppStrings.DELETE.tr(),
                style: AppStyles.WhiteStyle_Font16,
              ),
            ],
          ),
          onTap:onRemove,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(SizeConfig.sidepadding.left, SizeConfig.screenHeight*.013,
                SizeConfig.sidepadding.right, SizeConfig.screenHeight*.013),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomStatusCheckBox(
                  minSize: Size(50,50),
                  maxSize: Size(60,60),
                  status: product.availableStatus,
                  padding: 10,
                ),
                SizeConfig.horizontalSpaceSmall(),
                Expanded(
                  child:Text('${product.name}',
                  style: AppStyles.BlackStyleFontWeight500_13(context).copyWith(
                      height: 1.5
                  ),)

                ),
                SizeConfig.horizontalSpaceSmall(),
                Text(
                    '${product.quantity} x ${NumberService.priceAfterConvert(product.price,context)}',
                    style: AppStyles.BlackStyleFontWeightSmall_12(context)),
                SizeConfig.horizontalSpaceSmall(),
                StatusDot(
                  availableStatus: product.availableStatus,
                )
              ],
            ),
          ),
          product.alternativeProduct != null
              ? AlternativeItemView(
            alternativeProducts:product.alternativeProduct,
          )
              : Container(),
          Padding(
            padding: SizeConfig.sidepadding,
            child:CustomDividerWidget(
              height: 1,
            ),
          ),

        ],
      ),
    );
  }
}
