import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:storeangelApp/core/viewmodel/mainApp_viewmodel.dart';
import 'package:storeangelApp/ui/screens/consumer/home_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/profile_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/watchlist_Screen.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/widgets/mainApp/appBottomNavigationBar.dart';
import 'my_store.dart';

class MainAppScreen extends StatelessWidget {
  static const String routeName = 'MainAppScreen';
   final int index;
  MainAppScreen({this.index:0});

  final List<Widget> _viewList = [
    HomeScreen(),
    WatchlistScreen(),
    MyStoreScreen(),
    ProfileScreen(customerView: true,),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView<MainAppViewModel>(
      onModelReady: (model)=>model.initializeData(index??0),
      builder:(context, mainViewModel, child)=> CustomScaffold(
        body: _viewList[mainViewModel.bottomNavigationIndex],
        bottomNavigationBar: AppBottomNavigationBar(),
      ),
    );
  }
}
