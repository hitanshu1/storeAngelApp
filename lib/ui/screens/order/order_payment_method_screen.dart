import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_order_payment_method.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class OrderPaymentMethodScreen extends StatefulWidget {
  static const String routeName = 'orderPaymentMethodScreen';
  final OrderPaymentMethodScreenArgument argument;

  OrderPaymentMethodScreen({this.argument});

  @override
  _OrderPaymentMethodScreenState createState() => _OrderPaymentMethodScreenState();
}

class _OrderPaymentMethodScreenState extends State<OrderPaymentMethodScreen> {
  String result = "Result will be shown here";

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
    return Scaffold(
      body: BaseView<OrderPaymentMethodViewModel>(
        onModelReady: (model) => model.getPaymentMethods(),
        builder: (context, model, child) {
          if (model.state == ViewState.Busy) {
            return AppConstants.circulerProgressIndicator();
          }
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              _courierOrderDetails(context),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ..._paymentOptions(context, model),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _courierOrderDetails(BuildContext context) {
    return CustomSliverAppBar(
        backgroundColor: Theme.of(context).cardColor,
        pinned: true,
        floating: false,
        title: Text(
          AppStrings.PAYMENT.tr(),
          style: AppStyles.BlackStyleWithBold800Font_24(context),
        ),
        leading: BackButton(
          color: Theme.of(context).iconTheme.color,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))),
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            child: Column(
              children: [
                SizeConfig.VerticalSpaceExtraLarge(),
                SizeConfig.CVerticalSpaceSmallMediumC12(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: ViewAppImage(
                          width: SizeConfig.smallImageHeight60,
                          height: SizeConfig.smallImageHeight60,
                          radius: 10,
                          imageUrl: widget.argument.orderOrPurchases.candidates.first.imageUrl,
                        ),
                        onTap: () {},
                      ),
                      SizeConfig.horizontalSpaceSmall(),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.argument.orderOrPurchases.candidates.first.name,
                              style: AppStyles.BlackStyleWithBold800Font_24(context),
                            ),
                            SizeConfig.CVerticalSpaceSmallMediumC12(),
                            Row(
                              children: [
                                Text(
                                  '${AppStrings.TOTAL_PAYMENT.tr()}: ${AppStrings.euro + ' '}${NumberService.priceAfterConvert(widget.argument.orderOrPurchases.purchaseDetails.totalAmount, context)}',
                                  style: AppStyles.GrayStyle_Font24(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        expandedHeight: 160);
  }

  List<Widget> _paymentOptions(BuildContext context, OrderPaymentMethodViewModel model) {
    return [
      SizeConfig.CVerticalSpaceSmallMedium(),
      Padding(
        padding: SizeConfig.sidepadding,
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            itemCount: model.paymentMethodList.length + 1,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, int index) {
              if (index == model.paymentMethodList.length) {
                return Padding(
                  padding: SizeConfig.smallerVerticalPadding3,
                  child: ButtonWidget(
                    buttonText: 'I am a tester button so you can move to the next screen',
                    buttonColor: AppColors.green,
                    radius: AppConstants.button_Radius,
                    onPressed: () {
                      model.onClickNext(widget.argument.orderOrPurchases);
                    },
                  ),
                );
              }
              return Padding(
                padding: SizeConfig.smallerVerticalPadding3,
                child: InkWell(
                  onTap: () async {
                    model.onClickPayment(
                        model.paymentMethodList[index].title, context, widget.argument.orderOrPurchases);
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.cmediumPadding.left,
                          right: SizeConfig.cmediumPadding.right,
                          top: SizeConfig.cmediumPadding.top - 5,
                          bottom: SizeConfig.cmediumPadding.bottom - 5),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppConstants.paymentIconBackgroundColor(context), shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ViewAppImage(
                                height: 22,
                                width: 25,
                                radius: 5,
                                boxFit: BoxFit.contain,
                                assetUrl: model.paymentMethodList[index].imageUrl,
                              ),
                            ),
                          ),
                          SizeConfig.horizontalSpaceMedium(),
                          Text(
                            model.paymentMethodList[index].title,
                            style: AppStyles.BlackStyleFont_c16(context),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(AppConstants.button_Radius)),
                  ),
                ),
              );
            }),
      ),
      SizeConfig.CVerticalSpaceBig()
    ];
  }
}

class OrderPaymentMethodScreenArgument {
  final OrderOrPurchases orderOrPurchases;

  OrderPaymentMethodScreenArgument({this.orderOrPurchases});
}
