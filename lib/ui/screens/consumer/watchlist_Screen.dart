
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_watchlist.dart';
import 'package:storeangelApp/ui/screens/consumer/pick_new_store_screen.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/widgets/watch_list/watchlist_widget.dart';
import 'package:easy_localization/easy_localization.dart';
class WatchlistScreen extends StatefulWidget {
  static const String routeName = 'watchlist';

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray,context);
    final theme=Theme.of(context);

    return BaseView<WatchListViewModel>(
      onModelReady: (watchListViewModel) {
        watchListViewModel.initialize(_scrollController);
      },
      builder: (context,watchListViewModel,child){
        return CustomScaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: theme.backgroundColor,
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppHeader(
                  title: AppStrings.YOUR_SHOPPING_LISTS.tr(),
                  actions: [
                    IconButton(icon: Icon(Icons.add,color: AppColors.whiteColor,size: SizeConfig.mediumIcon,), onPressed: (){
                      watchListViewModel.navigateToScreen(NewOrderSelectStore.routeName,context);
                    })
                  ],
                ),
              ),

              SizeConfig.verticalSliverMediumSpace(),
              WatchListWidget()
            ],
          )
        );
      },
    );
  }
}
