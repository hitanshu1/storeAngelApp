import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/common_itemsscreen_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_additems_search.dart';
import 'package:storeangelApp/ui/screens/items/common_item_details_screen.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/view_product.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';
import 'package:storeangelApp/ui/widgets/share/search_product_list.dart';

import '../../widgets/items/item_appbar.dart';


class AddItemSearchScreenArgument{
  StoreDataModel store;
  PurchaseDetails purchaseDatails;
  Function onSelect;
  AddItemSearchScreenArgument({this.store,this.purchaseDatails,this.onSelect});
}

class AddItemSearchScreen extends StatefulWidget {
  static const String routeName = 'AddItems';
  final AddItemSearchScreenArgument argument;
  AddItemSearchScreen({this.argument});

  @override
  _AddItemSearchScreenState createState() => _AddItemSearchScreenState();
}

class _AddItemSearchScreenState extends State<AddItemSearchScreen> {
  TextEditingController _serachController=TextEditingController();

  bool dataNull=false;
  FocusNode _searchFocusNode=FocusNode();



  Widget _body(CommonItemScreenViewModel cModel,AddItemsSearchViewModel model){
    if(!dataNull&&_serachController.text==''){
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
        child: SearchProductList(products: cModel.products,controller: _serachController,

        onSelect: (val){
          setState(() {
            dataNull=true;
            _serachController.text=val;
          });
          cModel.getStroeProductList(widget.argument.store.name,val);
        },),
      );
    }else{
      if(cModel.products.length==0){
        return Padding(
          padding: SizeConfig.sidepadding,
          child: Center(child: Text(AppStrings.CREATE_A_NEW_ITEM.tr(),
              style: AppStyles.BlackStyleFontWeightSmall_24(context),textAlign: TextAlign.center)),
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
          model.navigateToScreen(CommonItemsDetailsScreen.routeName,
              arguments: CommonItemsDetailsArgument(
                  products: cModel.products
              ),context: context);

          },);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    final productModel=Provider.of<CommonItemScreenViewModel>(context);
    StatusBarService.changeStatusBarColor(StatusBarType.Dark, context);
    return BaseView<AddItemsSearchViewModel>(
      builder: (context,model,child){
        return Scaffold(
          appBar: ItemAppbar(
            title: AppStrings.SEARCH_FOR_STORES.tr(),
            controller: _serachController,
            focusNode: _searchFocusNode,
            onChange: (val){
              Future.delayed(Duration(milliseconds: 300),(){
                productModel.getStroeProductList(widget.argument.store.name,val);
              });

            },
            onSubmit: (val){
              setState(() {
                dataNull=true;
              });
              productModel.getStroeProductList(widget.argument.store.name,_serachController.text);

            },
            onClear: (){
              setState(() {
                _serachController.clear();
                dataNull=false;
              });

            },
          ),
          body: _body(productModel,model),
          floatingActionButtonAnimator: NoScalingAnimation(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton:Padding(
            padding:  EdgeInsets.only(
                left: SizeConfig.screenWidth*.1,
                right: SizeConfig.screenWidth*.1,
                bottom: SizeConfig.screenHeight*.04
            ),
            child: ButtonWidget(
                radius: AppConstants.button_Radius,
                fontSize:AppConstants.fontSizeSmall,

                buttonColor:Theme.of(context).primaryColor,
                buttonText: AppStrings.BACK_TO_THE_ITEM.tr(),
                onPressed: (){
                  widget.argument.onSelect(productModel.selectedProductList);
                  model.navigatorPop();

                }),
          ),


        );
      },
    );
  }
}
