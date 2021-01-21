import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/models/response_model.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class AddItemsViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();


  List<Product>products=[];
  List<Product>selectedProducts=[];

  void getStoreProductList(String storeName,String productName)async{
    setState(ViewState.Busy);
    products=await database.getStoreProduct(storeName,productName);
    setState(ViewState.Idle);
  }

  void addAlterNativeProduct(int productIndex,List<Product> alternativeProducts){
   setState(ViewState.Busy);
   if(products[productIndex].alternativeProduct!=null){
     products[productIndex].alternativeProduct.addAll(alternativeProducts);
   }else{
     products[productIndex].alternativeProduct=alternativeProducts;
   }
   setState(ViewState.Idle);
  }
  void updateWishList(String detailsId,String productListId,Product product)async{
    setState(ViewState.Busy);
    ResponseModel response=await database.updateWishList(detailsId,productListId,product);
    print(response.status);
    setState(ViewState.Idle);

  }
  void onIncrement(int index){
   setState(ViewState.Busy);
   products[index].quantity++;
   setState(ViewState.Idle);
  }
  void onDecrement(int index){
    setState(ViewState.Busy);

    products[index].quantity--;
    setState(ViewState.Idle);
  }
}
