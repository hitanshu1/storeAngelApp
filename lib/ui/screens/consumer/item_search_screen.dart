import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_item_search.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/widgets/item_search/item_search_header.dart';
import 'package:storeangelApp/ui/widgets/item_search/search_item_list_widget.dart';

class ItemSearchScreen extends StatelessWidget {
  static const String routeName = 'itemSearchScreen';

  @override
  Widget build(BuildContext context) {
  return CustomScaffold(
      body: BaseView<ItemSearchViewModel>(
        builder: (context,model,child){
          return CustomScrollView(
            slivers: [
              ItemSearchHeader(
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverPadding(
                padding: SizeConfig.sidepadding,
                sliver: SearchItemListWidget(),
              ),


            ],
          );
        },
      ),
    );
  }
}
