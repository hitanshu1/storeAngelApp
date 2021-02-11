import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/home_viewmodel.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:storeangelApp/ui/widgets/home/home_header.dart';
import 'package:storeangelApp/ui/widgets/home/home_purchases_tiles.dart';
import 'package:storeangelApp/ui/widgets/home/information_inspire_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/widgets/home/your_order_today_widget.dart';

class HomeScreen extends StatelessWidget {

  EdgeInsets get sidePadding => SizeConfig.sidepadding;

  final smallLeftPadding = EdgeInsets.only(left: SizeConfig.screenWidth * 0.03);

  @override
  Widget build(BuildContext context) {

    StatusBarService.changeStatusBarColor(StatusBarType.Gray,context);
    final user = Provider.of<UserModel>(context);
    return BaseView<HomeViewModel>(
      onModelReady: (homeViewModel) =>homeViewModel.initialize(user.id),
      builder: (context, homeViewModel, child) =>
          CustomScaffold(
        resizeToAvoidBottomInset: false,
        body: homeViewModel.state==ViewState.Busy?AppConstants.circulerProgressIndicator():CustomScrollView(
            slivers: <Widget>[
              HomeHeader(user: homeViewModel.user,),
              SizeConfig.verticalSliverMediumSpace(),

              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: TitleTextWidget(
                    title: AppStrings.YOUR_ORDER_TODAY.tr(),
                  ),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              YourOrderTodayWidget(sidePadding: sidePadding,),
              SizeConfig.verticalSliverMediumSpace(),
              InFormationInspireWidget(),
              SizeConfig.verticalSliverMediumSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: TitleTextWidget(
                    title: AppStrings.YOUR_COMPLETED_PURCHASE.tr(),
                  ),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),

              HomePurchasesTiles(sidePadding: sidePadding,),

            ],
          ),
        ),
    );
  }
}
