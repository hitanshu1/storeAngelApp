
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_mystore.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/premium_widget.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:storeangelApp/ui/widgets/my_store/more_stores_widget.dart';

import 'package:storeangelApp/ui/widgets/my_store/my_store_header.dart';
import 'package:storeangelApp/ui/widgets/my_store/store_list_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class MyStoreScreen extends StatefulWidget {
  @override
  _MyStoreScreenState createState() => _MyStoreScreenState();
}

class _MyStoreScreenState extends State<MyStoreScreen> {

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserModel>(context);
    return BaseView<MyStoreViewModel>(
      onModelReady: (myStoreViewModel) => myStoreViewModel.initialize(user.id),
      builder: (context, myStoreViewModel, child) {
        return CustomScaffold(
          body:myStoreViewModel.state==ViewState.Busy?AppConstants.circulerProgressIndicator():
          CustomScrollView(
            slivers: [
              MyStoreHeaderWidget(),
              SizeConfig.verticalSliverMediumSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding:SizeConfig.sidepadding,
                  child: TitleTextWidget(
                    title:  AppStrings.AFFILIATED_STORES.tr(),
                  ),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              StoreListWidget(),
              SizeConfig.verticalSliverMediumSpace(),
              SliverToBoxAdapter(
                child:  !myStoreViewModel.userDetails.premium?Padding(
                  padding:SizeConfig.sidepadding,
                  child: TitleTextWidget(
                    title:  AppStrings.MORE_STORES.tr(),
                  ),
                ):PremiumWidget(),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              MoreStoreWidget()
            ],
          ),
        );
      },
    );
  }
}
