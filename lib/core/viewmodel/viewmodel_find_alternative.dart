
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class FindAlternativeViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();
  List<Product>products=[];
  List<Product>selectedProduct=[];
  int totalSelected=0;
  bool hasShadow = false;
  ScrollController scrollController;
  void navigatorPop() {
    navigationService.pop();
  }

  Future<void> navigateTo(String routeName, {Object arguments})async{
    await navigationService.navigateTo(routeName, arguments: arguments);
  }

  void getProductList(String searchText,String storeName)async{
    setState(ViewState.Busy);
    products=await database.getAlternativeicon(searchText, storeName);


    setState(ViewState.Idle);
  }

  void initialize(ScrollController scrollController){
    Future.delayed(Duration.zero,(){
      this.scrollController = scrollController;
      this.scrollController.addListener(addScrollListener);
    });
  }

  void addScrollListener(){
    if(scrollController.position.pixels==0){
      hasShadow = false;
    }else{
      hasShadow = true;
    }
    setState(ViewState.Idle);
  }

  void removeProductFunction(Product product){
    setState(ViewState.Busy);
    selectedProduct.remove(product);
    setState(ViewState.Idle);
  }
  void clearProduct(){
    setState(ViewState.Busy);
    products=[];
    setState(ViewState.Idle);
  }
  void updateSelectProductList(Product product){
    setState(ViewState.Busy);
    selectedProduct.forEach((element) {
      if(element.name==product.name){
        element.quantity=product.quantity;
      }
    });
    setState(ViewState.Idle);
  }
  void selectProductFunction(Product product){
    setState(ViewState.Busy);
    selectedProduct.add(product);
    setState(ViewState.Idle);
  }
  void increaseCounter(){
    setState(ViewState.Busy);
    totalSelected++;
    setState(ViewState.Idle);
  }
  void decrementCounter(){
    setState(ViewState.Busy);
    totalSelected--;
    setState(ViewState.Idle);
  }


}