import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_watchlist_detail.dart';
import 'package:storeangelApp/ui/screens/items/addItems_search_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/widgets/watchlist/watchlist_last_list_item.dart';
import 'package:storeangelApp/ui/widgets/watchlist_detail/watchlist_details_item_appbar.dart';
import 'package:storeangelApp/ui/widgets/watchlist_detail/watchlist_view_product_widget.dart';
import 'items/common_item_details_screen.dart';

class WatchListDetailListItemScreen extends StatefulWidget {
  static const String routeName = 'wishListDetails';
  final WishListDetailsArgument argument;

  WatchListDetailListItemScreen({this.argument});

  @override
  _WatchListDetailListItemScreenState createState() => _WatchListDetailListItemScreenState();
}

class _WatchListDetailListItemScreenState extends State<WatchListDetailListItemScreen> {
  var radius = SizeConfig.radiusOfSliverAppbar;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_isAppBarExpanded) {
        setState(() {
          radius = 0.0;
        });
      } else {
        setState(() {
          radius = SizeConfig.radiusOfSliverAppbar;
        });
      }
    });
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients && _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Dark,context);
    return BaseView<WatchListDetailViewModel>(
      onModelReady: (model) => model.initializeData(widget.argument.purchaseDetails),
      builder: (context, model, child) {
        if (model.state == ViewState.Busy) {
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: AppConstants.circulerProgressIndicator(),
          );
        }
        return Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              WatchListAppBar(
                purchaseDetails: model.purchaseDetails,
                radius: radius,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizeConfig.CVerticalSpaceMedium(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            '${model.purchaseDetails.quantity} ${AppStrings.ITEMS.tr()}',
                            style: AppStyles.BlackStyleWithBold600Font_20(context),
                          )),
                          InkWell(
                            child: AppConstants.addIcon,
                            onTap: () {

                              model.navigateToScreen(AddItemSearchScreen.routeName, context,
                                  arguments: AddItemSearchScreenArgument(
                                      store: model.purchaseDetails.storeDetails,
                                      purchaseDatails: model.purchaseDetails,
                                      onSelect: (List<Product> products) {
                                        model.onUpdateProduct(products);
                                      }));
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
             StreamBuilder<List<Product>>(stream: model.getProductList(model.purchaseDetails),
                 initialData:model.purchaseDetails.products,
                 builder: (context, snapshot){
               return  SliverPadding(
                 padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .15),
                 sliver: SliverList(
                   delegate: SliverChildBuilderDelegate(
                           (context,index){
                             if(index == snapshot.data.length)return WatchlistLastListItem(
                               onTap: (){
                                 model.navigateToScreen(CommonItemsDetailsScreen.routeName,context,
                                     arguments: CommonItemsDetailsArgument(products: snapshot.data,currentIndex: index));
                               },
                             );

                             return InkWell(
                               onTap: (){
                                 model.navigateToScreen(CommonItemsDetailsScreen.routeName,context,
                                     arguments: CommonItemsDetailsArgument(products: snapshot.data,currentIndex: index));
                               },
                               child: WatchListViewProductWidget(
                                 product: snapshot.data[index],
                                 enableBorder: index<snapshot.data.length-1,
                                 onRemove: (){
                                   model.removeProduct(
                                       widget.argument.purchaseDetails.id, snapshot.data[index], context);
                                 },
                               ),
                             );
                           }
                       ,childCount: snapshot.data.length+1
                   ),
                 ),
               );
             }),
            ],
          ),

        );
      },
    );
  }
}

class WishListDetailsArgument {
  PurchaseDetails purchaseDetails;

  WishListDetailsArgument({this.purchaseDetails});
}
