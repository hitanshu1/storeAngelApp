import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/common_itemsscreen_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_find_alternative.dart';
import 'package:storeangelApp/ui/screens/items/alternativeProduct/single_alternative_product_view.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/widgets/items/item_appbar.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';
import 'package:storeangelApp/ui/widgets/share/search_product_list.dart';

import 'alternative_product_view.dart';

class FindAlternativeScreen extends StatefulWidget {
  static const String routeName = 'findAlternative';
  final FinalAlternativeArgument argument;

  FindAlternativeScreen({this.argument});

  @override
  _FindAlternativeScreenState createState() => _FindAlternativeScreenState();
}

class _FindAlternativeScreenState extends State<FindAlternativeScreen> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();
  bool dataNull = false;
  FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _searchFocusNode.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<CommonItemScreenViewModel>(context);
    StatusBarService.changeStatusBarColor(StatusBarType.Dark, context);
    return BaseView<FindAlternativeViewModel>(
      onModelReady: (findAlternativeViewModel) => findAlternativeViewModel.initialize(_scrollController),
      builder: (context, findAlternativeViewModel, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: ItemAppbar(
            title: AppStrings.SEARCH_FOR_PRODUCT.tr(),
            controller: _searchController,
            focusNode: _searchFocusNode,
            elevation: findAlternativeViewModel.hasShadow ? 4 : 0,
            onChange: (val) {
              Future.delayed(Duration(milliseconds: 300), () {
                findAlternativeViewModel.getProductList(
                  val,
                  widget.argument.product.storeDetails.name,
                );
              });
            },
            onSubmit: (val) {
              setState(() {
                dataNull = true;
              });
              findAlternativeViewModel.getProductList(
                _searchController.text,
                widget.argument.product.storeDetails.name,
              );
            },
            onClear: () {
              setState(() {
                _searchController.clear();
                dataNull = false;
              });
            },
          ),
          body: _body(findAlternativeViewModel),
          floatingActionButtonAnimator: NoScalingAnimation(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: findAlternativeViewModel.selectedProduct.length > 0
              ? Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * .1,
                      right: SizeConfig.screenWidth * .1,
                      bottom: SizeConfig.screenHeight * .04),
                  child: ButtonWidget(
                      radius: AppConstants.button_Radius,
                      fontSize: AppConstants.fontSizeSmall,
                      buttonColor: Theme.of(context).primaryColor,
                      buttonText: AppStrings.BACK_TO_THE_ITEM.tr(),
                      onPressed: () {
                        productModel.addAlternativeProductToProduct(
                          findAlternativeViewModel.selectedProduct,
                          widget.argument.currentIndex,
                        );
                        findAlternativeViewModel.navigatorPop();
                      }),
                )
              : Container(),
        );
      },
    );
  }

  Widget _body(FindAlternativeViewModel findAlternativeViewModel) {
    if (!dataNull && _searchController.text == '') {
      return InkWell(
        child: Padding(
          padding: SizeConfig.sidepadding.copyWith(top: SizeConfig.verticalMediumPadding.top),
          child: Center(
              child: SizedBox(
            width: SizeConfig.screenWidth * .85,
            child: Text(
              AppStrings.SEARCH_FOR_PRODUCTS.tr(),
              style: AppStyles.BlackStyleFontWeightSmall_24(context),
              textAlign: TextAlign.center,
            ),
          )),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(_searchFocusNode);
        },
      );
    }
    if (!dataNull && findAlternativeViewModel.products.length > 0) {
      return Padding(
        padding: SizeConfig.sidepadding.copyWith(top: SizeConfig.verticalMediumPadding.top),
        child: SearchProductList(
          products: findAlternativeViewModel.products,
          controller: _searchController,
          scrollController: _scrollController,
          onSelect: (val) {
            setState(() {
              dataNull = true;
              _searchController.text = val;
            });
            findAlternativeViewModel.getProductList(
              val,
              widget.argument.product.storeDetails.name,
            );
          },
        ),
      );
    } else {
      return ListView.builder(
          itemCount: findAlternativeViewModel.products.length,
          controller: _scrollController,
          itemBuilder: (context, int index) {
            return Padding(
              padding: SizeConfig.bottomsmallPadding.copyWith(top: SizeConfig.verticalMediumPadding.top),
              child: AlternativeProductView(
                product: findAlternativeViewModel.products[index],
                mainProducts: findAlternativeViewModel.selectedProduct,
                productType: AlterNativeProductType.ListScreen,
                quantity: findAlternativeViewModel.products[index].quantity,
                increment: () {
                  findAlternativeViewModel.selectProductFunction(findAlternativeViewModel.products[index]);
                },
                decrement: () {
                  findAlternativeViewModel.removeProductFunction(findAlternativeViewModel.products[index]);
                },
                onTap: () async {
                  await findAlternativeViewModel.navigateTo(SingleAlternativeProductView.routeName,
                      arguments: SingleProductAlternativeScreenArguments(
                          product: findAlternativeViewModel.products[index],
                          mainProductsList: findAlternativeViewModel.selectedProduct,
                          onTap: () {
                            if (findAlternativeViewModel.selectedProduct
                                .contains(findAlternativeViewModel.products[index])) {
                              findAlternativeViewModel.removeProductFunction(findAlternativeViewModel.products[index]);
                            } else {
                              findAlternativeViewModel.selectProductFunction(findAlternativeViewModel.products[index]);
                              Navigator.pop(context);
                            }
                          }));
                  StatusBarService.changeStatusBarColor(StatusBarType.Dark, context);
                },
              ),
            );
          });
    }
  }
}

class FinalAlternativeArgument {
  int currentIndex;
  var model;
  Product product;

  FinalAlternativeArgument({this.model, this.currentIndex, this.product});
}
