
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_mystore.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';

import 'package:storeangelApp/ui/widgets/my_store/my_store_header.dart';
import 'package:storeangelApp/ui/widgets/my_store/store_list_widget.dart';

class MyStoreScreen extends StatefulWidget {
  @override
  _MyStoreScreenState createState() => _MyStoreScreenState();
}

class _MyStoreScreenState extends State<MyStoreScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MyStoreViewModel>(
      onModelReady: (myStoreViewModel) => myStoreViewModel.initialize(_scrollController),
      builder: (context, myStoreViewModel, child) {
        return CustomScaffold(
          body: CustomScrollView(
            slivers: [
              MyStoreHeaderWidget(),
              SizeConfig.verticalSliverMediumSpace(),
              StoreListWidget()
            ],
          ),
        );
      },
    );
  }
}
