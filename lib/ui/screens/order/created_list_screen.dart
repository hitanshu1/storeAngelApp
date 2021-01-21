import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_watchlist_detail.dart';
import 'package:storeangelApp/ui/screens/order_courier_flow/estimation_screen.dart';
import 'package:storeangelApp/ui/screens/items/addItems_search_screen.dart';
import 'package:storeangelApp/ui/screens/items/common_item_details_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';
import 'package:storeangelApp/ui/widgets/watchlist_detail/watchlist_details_item_appbar.dart';
import 'package:storeangelApp/ui/widgets/watchlist_detail/watchlist_view_product_widget.dart';

class ListCreatedScreen extends StatefulWidget{
  static const String routeName='createdListScreen';

  final PurchaseDetails purchaseDetails;


  ListCreatedScreen({this.purchaseDetails});

  @override
  _ListCreatedScreenState createState() => _ListCreatedScreenState();
}

class _ListCreatedScreenState extends State<ListCreatedScreen> {

  var radius=SizeConfig.radiusOfSliverAppbar;
  ScrollController _scrollController=ScrollController();

  @override
  void initState() {
    super.initState();


    _scrollController.addListener(() {

      if(_isAppBarExpanded){
        setState(() {
          radius=0.0;
        });
      }else{
        setState(() {
          radius=SizeConfig.radiusOfSliverAppbar;
        });
      }

    });
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BaseView<WatchListDetailViewModel>(
      onModelReady: (model) => model.initializeData(widget.purchaseDetails),
      builder: (context,model,child){
        if(model.state==ViewState.Busy){
          return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: AppConstants.circulerProgressIndicator());
        }else{
          return Scaffold(
            backgroundColor: Theme.of(context).buttonColor,
            body: CustomScrollView(
              controller: _scrollController,
              slivers: [
                WatchListAppBar(purchaseDetails: widget.purchaseDetails,radius: radius,),
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
                                  (context,index)=> InkWell(
                                child: WatchListViewProductWidget(
                                  product: snapshot.data[index],
                                  enableBorder: index<snapshot.data.length-1,
                                  onRemove: (){
                                    model.removeProduct(
                                        widget.purchaseDetails.id, snapshot.data[index], context);
                                  },
                                ),
                                onTap: (){
                                  model.navigateToScreen(CommonItemsDetailsScreen.routeName,context,
                                      arguments: CommonItemsDetailsArgument(products: snapshot.data,currentIndex: index));
                                },
                              )
                              ,childCount: snapshot.data.length
                          ),
                        ),
                      );
                    }),



              ],
            ),
            floatingActionButtonAnimator: NoScalingAnimation(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton:Padding(
              padding:  EdgeInsets.only(
                  left: SizeConfig.screenWidth*.1,
                  right: SizeConfig.screenWidth*.1,
                  bottom: SizeConfig.screenHeight*.04
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ButtonWidget(

                        radius: AppConstants.button_Radius,
                        fontSize:AppConstants.fontSizeSmall,

                        buttonColor: Theme.of(context).primaryColorLight,buttonText: AppStrings.GO_HOME.tr(),
                        textColor: Theme.of(context).primaryColor,
                        onPressed: (){

                        }),
                  ),
                  SizeConfig.horizontalSpaceSmall(),

                  Expanded(
                    child: ButtonWidget(

                        radius: AppConstants.button_Radius,
                        fontSize:AppConstants.fontSizeSmall,

                        buttonColor: Theme.of(context).primaryColor,buttonText: AppStrings.HIRE_A_COURIER.tr(),
                        onPressed: (){
                          model.navigateToScreen(EstimationScreen.routeName, context,
                              arguments: widget.purchaseDetails);
                        }),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}