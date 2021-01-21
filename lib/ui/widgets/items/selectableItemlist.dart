
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
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_selectable_item_list.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_watchlist_detail.dart';
import 'package:storeangelApp/ui/screens/courier/courier_orderproductDetailslist.dart';
import 'package:storeangelApp/ui/screens/items/common_item_details_screen.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customstatuscheckbox.dart';
import 'package:storeangelApp/ui/shared/status_dot.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/created_list/alternative_item_view.dart';

class SelectableItemList extends StatefulWidget {
  final List<Product> products;
  final PurchaseDetails purchaseDetails;
  final Function onselect;

  final bool enablePadding;
  final bool showprice;
  final bool slideable;
  final bool enableStatusDot;
  final WatchListDetailViewModel wishListModel;

  SelectableItemList(
      {this.products,
        this.enableStatusDot:true,
      this.onselect,
      this.enablePadding: true,
      this.showprice: false,
      this.slideable: true,
      this.wishListModel,
      this.purchaseDetails});

  @override
  _SelectableItemListState createState() => _SelectableItemListState();
}

class _SelectableItemListState extends State<SelectableItemList> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SelectableItemViewModel>(
      builder: (context,model,child){
        return ListView.builder(
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.products.length,
            itemBuilder: (context, int i) {
              return Padding(
                padding: widget.enablePadding ? SizeConfig.sidepadding : EdgeInsets.all(0),
                child: Container(
                  decoration: BoxDecoration(
                      border: i!=widget.products.length-1?Border(bottom:BorderSide(color: AppColors.lightGrayLittleColor,
                          width: 1) ):Border()
                  ),
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.4,
                    secondaryActions: widget.slideable
                        ? <Widget>[
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
                        onTap: () {
                          if (widget.wishListModel != null) {
                            widget.wishListModel.removeProduct(
                                widget.purchaseDetails.id, widget.products[i], context);
                          } else {
                            print('null');
                          }
                        },
                      ),
                    ]
                        : [],
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(

                            onTap: () {
                              print(widget.products.length);

                              if (!widget.slideable) {}


                              if(widget.purchaseDetails!=null){
//
                                model.navigateToScreen(CommonItemsDetailsScreen.routeName, context,StatusBarType.OffGray,
                                    arguments: CommonItemsDetailsArgument(products: widget.products,currentIndex: i));
                              }else{

                                model.navigateToScreen(CourierOrderProductListScreen.routeName, context,StatusBarType.Light,
                                    arguments:CourierOrderProductListArgument(products: widget.products,currentIndex: i));

                              }

                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomStatusCheckBox(
                                  minSize: Size(50,50),
                                  maxSize: Size(60,60),
                                  status: widget.products[i].availableStatus,
                                  padding: 10,
                                ),
                                SizeConfig.horizontalSpaceSmall(),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      text: '${widget.products[i].name} ',
                                      style: AppStyles.BlackStyleFontWeight500_13(context),
                                    ),
                                  ),
                                ),
                                SizeConfig.horizontalSpaceSmall(),
                                Text(
                                    widget.showprice
                                        ? '${widget.products[i].quantity} x ${NumberService.priceAfterConvert(widget.products[i].price,context)}'
                                        : '${widget.products[i].quantity}',
                                    style: AppStyles.BlackStyleFontWeightSmall_12(context)),
                                SizeConfig.horizontalSpaceSmall(),
                                widget.enableStatusDot?StatusDot(
                                  availableStatus: widget.products[i].availableStatus,
                                ):Container()
                              ],
                            ),
                          ),
                          widget.products[i].alternativeProduct != null
                              ? AlternativeItemView(
                            alternativeProducts: widget.products[i].alternativeProduct,
                          )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
