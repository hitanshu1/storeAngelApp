import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/viewmodel/home_viewmodel.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/widgets/home/horizontal_list_widget.dart';
import 'package:storeangelApp/ui/widgets/home/orders_bar.dart';

class NotificationTiles extends StatelessWidget {
  final EdgeInsets sidePadding;

  const NotificationTiles({Key key,@required this.sidePadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<HomeViewModel>(
        builder:(context, homeViewModel, child)=> Column(
          children: <Widget>[
            Padding(
              padding: sidePadding,
              child: Column(
                children: <Widget>[
                  homeViewModel.state == ViewState.Busy
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CarouselSlider.builder(
                          options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 10),
                              height: 168,
                              viewportFraction: 1,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                homeViewModel.setSelectedIndex(index);
                              }
                          ),
                          itemCount: homeViewModel.notificationList.length,
                          itemBuilder: (context, index) {
                            return HorizontalListItemWidget(
                              purchaseDetails: homeViewModel.notificationList[index],
                            );
                          }),
                      Container(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: homeViewModel.notificationList.map((url) {
                            int index = homeViewModel.notificationList.indexOf(url);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: homeViewModel.selectedIndex == index
                                    ? AppColors.primaryColor
                                    : Theme.of(context).primaryColorLight,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizeConfig.CVerticalSpacevMedium(),
                  OrdersBar(
                    model: homeViewModel,
                  ),
                  SizeConfig.CVerticalSpaceSmallMediumC12(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
