import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/common_itemsscreen_viewmodel.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/widgets/items/item_details.dart';
import 'package:storeangelApp/ui/widgets/items/last_item/view_bill_list.dart';

import 'last_item_package_screen.dart';

class CommonItemsDetailsArgument {
  final List<Product> products;
  final int currentIndex;
  final bool courierView;
  final bool hasLastPage;
  final Function onClickPush;

  CommonItemsDetailsArgument({
    this.currentIndex,
    this.products,
    this.onClickPush,
    this.courierView: false,
    this.hasLastPage: true,
  });
}

class CommonItemsDetailsScreen extends StatefulWidget {
  static const String routeName = 'commonItemsDetailsScreen';
  final CommonItemsDetailsArgument argument;

  CommonItemsDetailsScreen({this.argument});

  @override
  _CommonItemsDetailsScreenState createState() => _CommonItemsDetailsScreenState();
}

class _CommonItemsDetailsScreenState extends State<CommonItemsDetailsScreen> {
  @override
  void initState() {
    super.initState();
    getData().then((value) {
      Provider.of<CommonItemScreenViewModel>(context, listen: false).loading = false;
    });
    if (widget.argument.currentIndex != null) {
      setState(() {
        Provider.of<CommonItemScreenViewModel>(context, listen: false).selectedIndex = widget.argument.currentIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Dark, context);
    final _commonItemScreenViewModel = Provider.of<CommonItemScreenViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        if (_commonItemScreenViewModel.blurScreen) {
          setState(() {
            _commonItemScreenViewModel.blurScreen = false;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar(
          title: _commonItemScreenViewModel.selectedProduct.length > 1
              ? Wrap(
                  children: dotWidget(),
                  clipBehavior: Clip.none,
                )
              : Container(),
          backgroundColor: Theme.of(context).backgroundColor,
          leading: BackButton(
            color: Theme.of(context).iconTheme.color,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: _commonItemScreenViewModel.hasShadow ? 4 : 0,
          centerTitle: true,
        ),
        body: _commonItemScreenViewModel.loading
            ? AppConstants.circulerProgressIndicator()
            : Stack(
                children: [
                  Container(
                    height: SizeConfig.screenHeight,
                    child: Padding(
                        padding: SizeConfig.innersidepadding,
                        child: CarouselSlider.builder(
                          itemCount:
                              _commonItemScreenViewModel.selectedProduct.length + (widget.argument.hasLastPage ? 1 : 0),
                          options: CarouselOptions(
                            initialPage: _commonItemScreenViewModel.selectedIndex,
                            enableInfiniteScroll: false,

                            height: SizeConfig.screenHeight * .91,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            onPageChanged: (index, reason) {
                              _commonItemScreenViewModel.setSelectedIndex = index;
                            },
                            // autoPlay: false,
                          ),
                          itemBuilder: (BuildContext context, int itemIndex) {
                            if (itemIndex == _commonItemScreenViewModel.selectedProduct.length) {
                              if (widget.argument.hasLastPage)
                                return LastItemPackageScreen(
                                  onClickPush: widget.argument?.onClickPush,
                                  onChangeBlurValue: (val) {
                                    setState(() {
                                      _commonItemScreenViewModel.blurScreen = val;
                                    });
                                    if (val) {
                                      StatusBarService.changeColor(Colors.grey.withOpacity(.1));
                                    }
                                  },
                                  products: _commonItemScreenViewModel.selectedProduct,
                                );
                            }

                            return ArticleDetailsView(
                              product: _commonItemScreenViewModel.selectedProduct[itemIndex],
                              currentIndex: itemIndex,
                              courierOption: widget.argument.courierView,
                              hasScrolledFunc: _commonItemScreenViewModel.checkIfHasShadow,
                            );
                          },
                        )),
                  ),
                  _commonItemScreenViewModel.blurScreen
                      ? Positioned.fill(
                          child: Align(
                          child: ViewBillList(
                            images: _commonItemScreenViewModel.lastItemFileimages,
                            onClose: () {
                              _commonItemScreenViewModel.setBlur = false;
                              StatusBarService.changeStatusBarColor(StatusBarType.Dark, context);
                            },
                            onDelete: (int index) {
                              _commonItemScreenViewModel.onRemoveImage(index);
                              setState(() {
                                if (_commonItemScreenViewModel.lastItemFileimages.length == 0) {
                                  _commonItemScreenViewModel.blurScreen = false;
                                }

                                StatusBarService.changeStatusBarColor(StatusBarType.Dark, context);
                              });
                            },
                          ),
                        ))
                      : Container()
                ],
              ),
      ),
    );
  }

  List<Widget> dotWidget() {
    final _commonItemScreenViewModel = Provider.of<CommonItemScreenViewModel>(context);
    List<Widget> listWidget = [];
    int length = _commonItemScreenViewModel.selectedProduct.length + (widget.argument.hasLastPage ? 1 : 0) > 70
        ? 70
        : _commonItemScreenViewModel.selectedProduct.length + (widget.argument.hasLastPage ? 1 : 0);
    for (int i = 0; i < length; i++) {
      listWidget.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _commonItemScreenViewModel.selectedIndex == i
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColorLight,
          ),
        ),
      );
    }

    return listWidget;
  }

  Future getData() async {
    Future.microtask(
        () => Provider.of<CommonItemScreenViewModel>(context, listen: false).initializeData(widget.argument.products));
    return true;
  }
}
