import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_store_details.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:storeangelApp/ui/widgets/store_details/opening_hour_tile.dart';
import 'package:storeangelApp/ui/widgets/store_details/store_address_widget.dart';
import 'package:storeangelApp/ui/widgets/store_details/store_details_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/widgets/store_details/toplists_widget.dart';



class StoreDetailsScreen extends StatelessWidget {
  static const String routeName = 'storeDetailsScreen';
  final int initialIndex;
  StoreDetailsScreen({this.initialIndex});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BaseView<StoreDetailsViewModel>(
        onModelReady: (model)=>model.initialize( initialIndex),
        builder: (context,model,child){
          if(model.state==ViewState.Busy){
            return AppConstants.circulerProgressIndicator();
          }
          return CustomScrollView(
            slivers: [
              StoreDetailsHeader(),
              SizeConfig.verticalSliverMediumSpace(),
              OpeningHourTile(),
              SizeConfig.verticalSliverSmallSpace(),
              StoreAddressWidget(),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding:SizeConfig.sidepadding,
                  child: TitleTextWidget(
                    title: AppStrings.TOPLISTS.tr(),
                  ),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              TopListsWidget()



            ],
          );
        },
      ),
    );
  }
}
