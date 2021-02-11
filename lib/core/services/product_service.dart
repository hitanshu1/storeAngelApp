import 'package:storeangelApp/core/enums/item_status.dart';
import 'package:storeangelApp/core/models/product.dart';

class ProductService {

  static void updateProductStatus(Product productVal){
    print(productVal.itemStatus);
    switch (productVal.itemStatus) {
      case ItemStatus.UnSelected:
        productVal.itemStatus=ItemStatus.Selected;
        break;
      case ItemStatus.Selected:
        productVal.itemStatus = ItemStatus.Few;
        break;
      case ItemStatus.Few:
        productVal.itemStatus = ItemStatus.UnAvailable;
        break;
      case ItemStatus.UnAvailable:
        productVal.itemStatus = ItemStatus.UnSelected;
        break;


    }
  }
}