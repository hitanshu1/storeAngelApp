import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/viewmodel/view_model_courier_item_details.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/widgets/courier_item_details/courier_alternative_product_widget.dart';
import 'package:storeangelApp/ui/widgets/courier_item_details/courier_item_details_header.dart';
import 'package:storeangelApp/ui/widgets/courier_item_details/client_list_widget.dart';


class CourierItemDetailsArguments{
  OrderByStore orderByStore;
  List<Product>products;
  Product selectedProduct;
  List<ClientDetails>clients;
  CourierItemDetailsArguments({this.products,this.selectedProduct,this.clients,this.orderByStore});
}

class CourierItemDetailsScreen extends StatelessWidget {
  static const String routeName = 'courierItemDetailsScreen';
  final CourierItemDetailsArguments arguments;
  CourierItemDetailsScreen({this.arguments});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body:BaseView<CourierItemDetailsViewModel>(
        onModelReady: (model)=>model.initializeData(arguments.products, arguments.selectedProduct,arguments.clients,arguments.orderByStore),
        builder: (context,model,child){
          if(model.state==ViewState.Busy){
            return AppConstants.circulerProgressIndicator();
          }
          return  CustomScrollView(
            slivers: [
              CourierItemDetailsHeader(product: model.currentProduct,),
              SizeConfig.verticalSliverMediumSpace(),
              ClientListWidget(clients: arguments.clients,),
              SizeConfig.verticalSliverSmallSpace(),
              CourierAlternativeProductWidget(),
              SizeConfig.verticalSliverMediumSpace(),
            ],
          );
        },
      ),
    );
  }
}
