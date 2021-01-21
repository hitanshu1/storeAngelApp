import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/viewmodel/common_itemsscreen_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_store_catalogue.dart';
import 'package:storeangelApp/ui/screens/items/common_item_details_screen.dart';
import 'package:storeangelApp/ui/screens/order/created_list_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/widgets/items/item_appbar.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/view_product.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';
import 'package:storeangelApp/ui/widgets/share/search_product_list.dart';

class StoreCatalogueScreen extends StatefulWidget {
  static const String routeName='storeCatalogue';
  final StoreDataModel store;
  StoreCatalogueScreen({@required this.store});


  @override
  _StoreCatalogueScreenState createState() => _StoreCatalogueScreenState();
}

class _StoreCatalogueScreenState extends State<StoreCatalogueScreen> {
  TextEditingController _searchController=TextEditingController();
  bool dataNull=false;
  FocusNode _searchFocusNode=FocusNode();


  @override
  Widget build(BuildContext context) {
    final productModel=Provider.of<CommonItemScreenViewModel>(context);
    return BaseView<StoreCatalogueViewModel>(
      builder: (context,model,child){
        if(model.state==ViewState.Busy){
          return CustomScaffold(
            body: AppConstants.circulerProgressIndicator(),
          );
        }else{
          return Scaffold(
            appBar: ItemAppbar(
              title: AppStrings.SEARCH_FOR_PRODUCT.tr(),
              controller: _searchController,
              onChange: (val){
                Future.delayed(Duration(milliseconds: 300),(){
                  productModel.getStroeProductList(widget.store.name,val);
                });

              },
              onSubmit: (val){
                setState(() {
                  dataNull=true;
                });
                productModel.getStroeProductList(widget.store.name,_searchController.text);

              },
              onClear: (){
                setState(() {
                  _searchController.clear();
                  dataNull=false;
                });

              },
            ),
            body: _body(productModel,model),
            floatingActionButtonAnimator: NoScalingAnimation(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton:productModel.length>0?Padding(
              padding:  EdgeInsets.only(
                  left: SizeConfig.screenWidth*.1,
                  right: SizeConfig.screenWidth*.1,
                  bottom: SizeConfig.screenHeight*.04
              ),
              child: ButtonWidget(
                  radius: AppConstants.button_Radius,
                  fontSize:AppConstants.fontSizeSmall,

                  buttonColor: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: SizeConfig.sidepadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Opacity(
                            opacity: 0,
                            child: Text('${productModel.length} ${AppStrings.ITEMS.tr()}',
                              style:AppStyles.WhiteStyle_Font16 ,)),
                        Text(AppStrings.GO_TO_THE_LIST.tr(),
                          style: AppStyles.WhiteStyle_Font20,),
                        Text(productModel.length>1?'${productModel.length} ${AppStrings.ITEMS.tr()}':"${productModel.length} item",
                          style:AppStyles.WhiteStyle_Font16 ,),

                      ],
                    ),
                  ),
                  onPressed: (){
                    productModel.getSelectedProduct();
                    PurchaseDetails purchaseDatails=PurchaseDetails(
                      id:'12',
                      listName: 'Weekly food',
                      customer: UserModel(
                          name: 'Bernand Flores'
                      ),
                      time: DateTime.now(),
                      amount: 0,
                      products: productModel.selectedProduct,
                      quantity: productModel.length,
                      storeDetails: widget.store,

                    );
                    model.navigateToScreen(ListCreatedScreen.routeName,context,arguments: purchaseDatails);



                  }),
            ):null,
          );
        }
      },
    );

  }

  Widget _body(CommonItemScreenViewModel cModel,StoreCatalogueViewModel model){
    if(!dataNull&&_searchController.text==''){
      return InkWell(
        child: Padding(
          padding:  SizeConfig.sidepadding,
          child: Center(
              child: SizedBox(
                width: SizeConfig.screenWidth*.85,
                child: Text(AppStrings.SEARCH_FOR_PRODUCTS.tr(),
                  style: AppStyles.BlackStyleFontWeightSmall_24(context),textAlign: TextAlign.center,),
              )),
        ),
        onTap: (){
          FocusScope.of(context).requestFocus(_searchFocusNode);
        },
      );
    }
    if(!dataNull&&cModel.products.length>0){
      return Padding(
        padding: SizeConfig.sidepadding,
        child: SearchProductList(products: cModel.products,controller: _searchController,

          onSelect: (val){
            setState(() {
              dataNull=true;
              _searchController.text=val;
            });
            cModel.getStroeProductList(widget.store.name,val);
          },),
      );
    }else{
      if(cModel.products.length==0){
        return Padding(
          padding: SizeConfig.sidepadding,
          child: Center(child: Text(AppStrings.CREATE_A_NEW_ITEM.tr(), style: AppStyles.BlackStyleFontWeightSmall_24(context),textAlign: TextAlign.center)),
        );
      }
      return ListView.builder(itemCount: cModel.products.length,itemBuilder: (context,int index){
        return InkWell(child: ViewProduct(product: cModel.products[index],
          selectedProducts:cModel.selectedProduct,
          onDecrement: (){
            cModel.onDecrement(index);

          },
          onIncrement: (){
            cModel.onIncrement(index);

          },),
          onTap: (){
          model.navigateToScreen(CommonItemsDetailsScreen.routeName, context,
              arguments: CommonItemsDetailsArgument(
                  products: cModel.products
              ));


          },);
      });

    }
  }

}
