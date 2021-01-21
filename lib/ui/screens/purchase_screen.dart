import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/viewmodel/purchase_viewmodel.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/circuler_button_widget.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/order_client_appbarbackground.dart';
import 'package:storeangelApp/ui/widgets/purchase/viewpurchase_list_product_widget.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';

class PurchaseScreen extends StatefulWidget {
  static const String routeName = 'purchaseScreen';
  final PurchaseDetails purchaseDetails;

  PurchaseScreen({this.purchaseDetails});

  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseView<PurchaseViewModel>(
      onModelReady: (purchaseViewModel) {
        purchaseViewModel.getPurchaseDetails('id');
      },
      builder:(context, purchaseViewModel, child)=> Scaffold(
        backgroundColor: theme.backgroundColor,
        body: Builder(
          builder: (context) {
            if (purchaseViewModel.state == ViewState.Busy&&purchaseViewModel.purchaseDetails!=null) {
              return AppConstants.circulerProgressIndicator();
            } else {
              return CustomScrollView(
                  physics: ClampingScrollPhysics(),
                  slivers: <Widget>[
                    CustomSliverAppBar(
                      backgroundColor: theme.cardColor,
                      pinned: true,
                      floating: false,
                      leading: BackButton(
                        color: theme.iconTheme.color,
                        onPressed: () {
                          purchaseViewModel.navigatorPop();
                        },
                      ),
                      title: Text(
                        AppStrings.PURCHASE.tr(),
                        style: AppStyles.BlackStyleWithBold800Font_24(context),
                      ),
                      centerTitle: true,
                      actions: [
                        IconButton(
                          icon: SizedBox(
                              height: SizeConfig.iconSize,
                              width: SizeConfig.iconSize,
                              child: Image.asset(
                                AssetsPath.moreIcon,
                              )),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child:purchaseViewModel.purchaseDetails!=null? OrderAndClientBackgroundView(
                        purchaseDetails: purchaseViewModel.purchaseDetails,
                      ):Container(),
                    ),
                    SizeConfig.verticalSliverSmallSpace(),
                    SliverPadding(
                      padding: SizeConfig.sidepadding.copyWith(bottom: SizeConfig.screenHeight * .2),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, int index) {
                          return ViewPurchaseListProductWidget(
                            product: purchaseViewModel.purchaseDetails.products[index],
                            onTapWithStatus: (status) => purchaseViewModel.updatePurchaseDetails(index, status),
                          );
                        }, childCount: purchaseViewModel.purchaseDetails?.products?.length??0),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
        floatingActionButtonAnimator: NoScalingAnimation(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * .1,
              right: SizeConfig.screenWidth * .1,
              bottom: SizeConfig.screenHeight * .04),
          child: Builder(
            builder:(context)=> CircularButtonWidget(
                radius: AppConstants.button_Radius,
                fontSize: AppConstants.fontSizeSmall,
                buttonColor: Theme.of(context).primaryColor,
                buttonText: AppStrings.ADD_TO_MY_LIST.tr(),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      AppStrings.PRODUCTS_HAVE_BEEN_ADDED.tr(),
                      style: AppStyles.BlackStyleFont_20(context).copyWith(color: AppColors.whiteColor),
                    ),
                    backgroundColor: AppColors.primaryColor,
                  ));
                }),
          ),
        ),
      ),
    );
  }
}
