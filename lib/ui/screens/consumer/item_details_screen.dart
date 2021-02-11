import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_item_details.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/widgets/item_details/alternative_products_widget.dart';
import 'package:storeangelApp/ui/widgets/courier_item_details/client_list_widget.dart';
import 'package:storeangelApp/ui/widgets/item_details/item_details_header.dart';
import 'package:storeangelApp/ui/widgets/item_details/product_status_widget.dart';

class ItemDetailsArguments{
  List<Product>products;
  int initialIndex;
  List<ClientDetails>clients;
  ItemDetailsArguments({this.products,this.initialIndex,this.clients});
}

class ItemDetailsScreen extends StatelessWidget {
  static const String routeName = 'itemDetailsScreen';
  final ItemDetailsArguments arguments;
  ItemDetailsScreen({this.arguments});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body:BaseView<ItemDetailsViewModel>(
        onModelReady: (model)=>model.initializeData(arguments.products, arguments.initialIndex),
        builder: (context,model,child){
          return  CustomScrollView(
            slivers: [
              ItemDetailsHeader(),
              SizeConfig.verticalSliverMediumSpace(),
              ProductStatusWidget(),
              SizeConfig.verticalSliverSmallSpace(),
              AlternativeProductWidget(),
              SizeConfig.verticalSliverMediumSpace(),
            ],
          );
        },
      ),
    );
  }
}
