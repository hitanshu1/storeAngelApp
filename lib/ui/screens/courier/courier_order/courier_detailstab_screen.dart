import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/courier_details_tab_viewmodel.dart';
import 'package:storeangelApp/ui/screens/items/common_item_details_screen.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_details_tab/delivery_details_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_details_tab/store_and_client_row_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_details_tab/user_details_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_list_product_info_widget.dart';

class CourierDetailsTabScreen extends StatefulWidget {
  final OrderOrPurchases order;

  CourierDetailsTabScreen({this.order});

  @override
  _CourierDetailsTabScreenState createState() => _CourierDetailsTabScreenState();
}

class _CourierDetailsTabScreenState extends State<CourierDetailsTabScreen> {
  var radius = SizeConfig.radiusOfSliverAppbar;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_isAppBarExpanded) {
        setState(() {
          radius = 0.0;
        });
      } else {
        setState(() {
          radius = SizeConfig.radiusOfSliverAppbar;
        });
      }
    });
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients && _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Light, context);
    return BaseView<CourierDetailsTabViewModel>(
      onModelReady: (model) => model.initializeData(widget.order),
      builder: (context, model, child) {
        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            CustomSliverAppBar(
              title: Text(
                widget.order.storeDetails.name,
                style: AppStyles.BlackStyleWithBold800Font_24(context),
              ),
              elevation: 10,
              backgroundColor: Theme.of(context).cardColor,
              pinned: true,
              floating: false,
              leading: BackButton(
                color: Theme.of(context).iconTheme.color,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(
                    StoreangelIcons.delete_icon,
                    color: Theme.of(context).focusColor,
                    size: SizeConfig.iconSize,
                  ),
                  onPressed: () {},
                )
              ],
              shape: ContinuousRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Column(
                  children: [
                    SizeConfig.verticalSpace(AppBar().preferredSize.height),
                    Spacer(),
                    Container(
                      height: SizeConfig.screenWidth * .15 + 18,
                      width: SizeConfig.screenWidth,
                      padding: EdgeInsets.only(top: 12),
                      child: Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: model.order.clientlist.length,
                            itemBuilder: (context, int index) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: InkWell(
                                      child: CircleAvatar(
                                        radius: SizeConfig.screenWidth * .065,
                                        backgroundImage: NetworkImage(model.order.clientlist[index].imageUrl),
                                      ),
                                      onTap: () {
                                        model.onSelectClient(model.order.clientlist[index]);
                                      },
                                    ),
                                  ),
                                  model.selectedClient.id == model.order.clientlist[index].id
                                      ? Positioned.fill(
                                          child: Align(
                                          alignment: Alignment.topRight,
                                          child: SizedBox(height: 15, child: Image.asset(AssetsPath.check_checkbox)),
                                        ))
                                      : Container()
                                ],
                              );
                            }),
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
              expandedHeight: SizeConfig.adaptiveHeight(SizeConfig.screenHeight * .185),
            ),
            SliverToBoxAdapter(
              child: SizeConfig.verticalSpaceMedium(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: SizeConfig.sidepadding,
                child: StoreAndClientRowWidget(
                  store: model.order.storeDetails,
                  client: model.selectedClient,
                ),
              ),
            ),
            SizeConfig.verticalSliverSmallSpace(),
            SliverToBoxAdapter(
              child: DeliveryDetailsWidget(
                order: model.order,
              ),
            ),
            SizeConfig.verticalSliverLargeSpace(),
            SliverToBoxAdapter(
              child: Padding(
                padding: SizeConfig.sidepadding,
                child: UserDetailsWidget(),
              ),
            ),
            SizeConfig.verticalSliverLargeSpace(),
            SliverToBoxAdapter(
              child: Padding(
                padding: SizeConfig.sidepadding,
                child: Row(
                  children: [
                    Expanded(child: Text(AppStrings.PURCHASE_LIST.tr()+':')),
                    Icon(
                      StoreangelIcons.download_icon,
                      color: Theme.of(context).focusColor,
                      size: SizeConfig.iconSize / 1.2,
                    )
                  ],
                ),
              ),
            ),
            SizeConfig.verticalSliverSmallSpace(),
            SliverPadding(
              padding: SizeConfig.padding,
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, int index) {
                return InkWell(
                  child: Padding(
                    padding: SizeConfig.verticalC13Padding,
                    child: CourierListProductInfoWidget(
                      product: model.order.purchaseDetails.products[index],
                    ),
                  ),
                  onTap: () {
                    model.navigateToScreen(CommonItemsDetailsScreen.routeName, context,
                        arguments: CommonItemsDetailsArgument(
                            products: model.order.purchaseDetails.products, currentIndex: index, courierView: true));
                  },
                );
              }, childCount: model.order.purchaseDetails.products.length)),
            )
          ],
        );
      },
    );
  }
}
