import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_mainpage.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/screens/courier/courier_offers_screen.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import '../../../ui/widgets/courier/courier_request/courier_request_screen.dart';
import '../../widgets/courier/courier_appbottomnavbar.dart';
import '../consumer/profile_screen.dart';
import 'courier_order_screen.dart';

class CourierMainAppScreen extends StatelessWidget {
  final int index;
  CourierMainAppScreen({this.index});
  static const String routeName = 'CourierMainPage';

  final List<Widget> _viewList = [
    CourierRequestScreen(),
    CourierOfferScreen(),
    CourierOrderScreen(),
    ProfileScreen(customerView: false,),
  ];

  @override
  Widget build(BuildContext context) {
//    StatusBarService.changeStatusBarColor(StatusBarType.Dark, context);
    return BaseView<CourierMainViewModel>(
      onModelReady: (model)=>model.initializeData(index),
      builder: (context,model,child){
        return CustomScaffold(
          body: _viewList[model.bottomNavigationIndex],
          bottomNavigationBar: CourierAppBottomNavigationBar(),
        );

      },
    );
  }

  void setProfilePageView(int index, BuildContext context){
    index ??=0;
    print('index $index');
    if(index!=_viewList.length-1)
      Provider.of<ProfileViewModel>(context).profilePageView = ProfilePageView.home;
  }
}
