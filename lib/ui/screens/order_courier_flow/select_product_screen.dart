import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_select_product.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/widgets/order_courier_flow/order_courier_flow.dart';
import 'package:storeangelApp/ui/widgets/select_product/view_select_product_widget.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';


class SelectProductScreen extends StatefulWidget {
  static const String routeName = 'selectProductScreen';
  final PurchaseDetails purchaseDetails;

  SelectProductScreen({this.purchaseDetails});

  @override
  _SelectProductScreenState createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends State<SelectProductScreen> {
  var _radius = SizeConfig.radiusOfSliverAppbar;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => StatusBarService.changeStatusBarColor(StatusBarType.Light, context));

    _scrollController.addListener(() {
      if (_isAppBarExpanded) {
        setState(() {
          _radius = 0.0;
        });
      } else {
        setState(() {
          _radius = SizeConfig.radiusOfSliverAppbar;
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

    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    Future.delayed(Duration.zero, () => StatusBarService.changeStatusBarColor(StatusBarType.Light, context));
    return BaseView<SelectProductViewModel>(
      onModelReady: (model) => model.initializeData(widget.purchaseDetails),
      builder: (context, model, child) {
        return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              CustomSliverAppBar(
                backgroundColor: Theme.of(context).cardColor,
                pinned: true,
                floating: false,
                leading: BackButton(
                  color: Theme.of(context).iconTheme.color,
                  onPressed: () {
                    model.navigatorPop();
                  },
                ),
                title: Text(
                  AppStrings.SELECT_YOUR_PRODUCT.tr(),
                  style: AppStyles.BlackStyleWithBold800Font_24(context),
                ),
                centerTitle: true,
                shape: ContinuousRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(_radius), bottomRight: Radius.circular(_radius))),

            bottom: PreferredSize(
              child:OrderCourierStatusWidget(status: OrderCourierStatus.SelectProduct,),
              preferredSize: Size.fromHeight(SizeConfig.expandedHeight*.5),
            )),
              SliverPadding(
                padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .2),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index == 0)
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizeConfig.CVerticalSpaceMedium(),
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    AppStrings.YOUR_PRODUCTS.tr(),
                                    textAlign: TextAlign.start,
                                    style: AppStyles.BlackStyleWithBold800Font_24(context),
                                  ),
                                ),
                                TextButton(
                                  child: FittedBox(
                                    child: Text(
                                      model.isAllSelected ? AppStrings.UNSELECT_ALL.tr() : AppStrings.SELECT_ALL.tr(),
                                      style: AppStyles.GreenStyleWith_Font16(context),maxLines: 1,
                                    ),
                                  ),
                                  onPressed: () {
                                    model.onSelectUnselectAll();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    return Padding(
                      padding: SizeConfig.sidepadding,
                      child: ViewSelectProductWidget(
                        product: model.purchaseDetails.products[index - 1],
                        selected: model.selectedProducts.contains(model.purchaseDetails.products[index - 1]),
                        onTap: () {
                          model.onSelectProduct(model.purchaseDetails.products[index - 1]);
                        },
                      ),
                    );
                  }, childCount: model.purchaseDetails.products.length + 1),
                ),
              ),
            ],
          ),
          floatingActionButtonAnimator: NoScalingAnimation(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: keyboardIsOpened
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * .1,
                      right: SizeConfig.screenWidth * .1,
                      bottom: SizeConfig.screenHeight * .04),
                  child: ButtonWidget(
                      radius: AppConstants.button_Radius,
                      fontSize: AppConstants.fontSizeSmall,
                      buttonColor: Theme.of(context).primaryColor,
                      buttonText: AppStrings.NEXT.tr(),
                      onPressed: () {
                        model.onClickNext(context);
                      }),
                ),
        );
      },
    );
  }
}
