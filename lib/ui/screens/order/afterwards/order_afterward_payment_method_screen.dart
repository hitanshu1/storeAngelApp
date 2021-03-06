import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/mobileSize.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_order_afterward_payment_method.dart';
import 'package:storeangelApp/ui/screens/order_delivered_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/deliveryinfo_rowWidget.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/watchlist/dashline_widget.dart';

class OrderAfterWardPaymentMethodScreen extends StatefulWidget {
  static const String routeName = 'orderAfterWardPaymentMethodScreen';
  final OrderOrPurchases orderOrPurchases;

  OrderAfterWardPaymentMethodScreen({this.orderOrPurchases});

  @override
  _OrderAfterWardPaymentMethodScreenState createState() => _OrderAfterWardPaymentMethodScreenState();
}

class _OrderAfterWardPaymentMethodScreenState extends State<OrderAfterWardPaymentMethodScreen> {
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
      body: BaseView<OrderAfterWardPaymentMethodViewMoel>(
        onModelReady: (model) => model.getPaymentMethods(),
        builder: (context, model, child) {
          if (model.state == ViewState.Busy) {
            return AppConstants.circulerProgressIndicator();
          }
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              _courierOrderDetails(context,model),
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

  Widget _courierOrderDetails(BuildContext context,OrderAfterWardPaymentMethodViewMoel model) {
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
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: SizedBox(
                  height: SizeConfig.iconSize,
                  child: Image.asset(
                    AssetsPath.bill,
                    color: Theme.of(context).primaryColor,
                  )),
              onPressed: () {
                model.navigateToScreen(OrderDeliveredScreen.routeName,context,arguments: OrderDeliveredScreenArgument(
                    orderOrPurchases: widget.orderOrPurchases,
                    isPrePaid: false
                ));
              })
        ],
        centerTitle: true,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft:
            Radius.circular(radius), bottomRight: Radius.circular(radius))),
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
                          imageUrl: widget.orderOrPurchases.candidates.first.imageUrl,
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
                              widget.orderOrPurchases.candidates.first.name,
                              style: AppStyles.BlackStyleWithBold800Font_24(context),
                            ),
                            SizeConfig.CVerticalSpaceSmallMediumC12(),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      '${AppStrings.FEE.tr()}:${SizeConfig.mobileSize==MobileSize.small?'\n':' '}${AppStrings.euro+' '}${NumberService.priceAfterConvert(widget.orderOrPurchases.candidates.first.charge,context)}',
                                      style: AppStyles.GrayStyle_Font16(context),
                                    )),
                                Text(
                                  '${AppStrings.TOTAL_PAYMENT.tr()}: ${AppStrings.euro+' '}${NumberService.priceAfterConvert(widget.orderOrPurchases.purchaseDetails.amount,context)}',
                                  style: AppStyles.GrayStyle_Font16(context),
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
        expandedHeight: SizeConfig.adaptiveHeight(SizeConfig.screenHeight*.18));
  }

  List<Widget> _paymentOptions(BuildContext context,OrderAfterWardPaymentMethodViewMoel model){
    return [
      SizeConfig.CVerticalSpaceMedium(),
     Padding(
       padding:SizeConfig.sidepadding,
       child: DeliveryInfoRowWidget(
         enablePadding: false,
         hasBorderColor: false,
         firstText: AppStrings.PAYMENT_FOR_PURCHASE.tr(),
         secondText: '${AppStrings.euro+' '} 40,97',
         secondTextStyle: AppStyles.GrayStyle_Font16(context),
       ),
     ),
      SizeConfig.verticalSpaceSmall(),

      Padding(
        padding: SizeConfig.sidepadding,
        child: DeliveryInfoRowWidget(
          enablePadding: false,
          hasBorderColor: false,
          firstText: AppStrings.FEE.tr(),
          secondText: '${AppStrings.euro+' '} ${NumberService.priceAfterConvert(widget.orderOrPurchases.candidates.first.charge,context)}',
          secondTextStyle: AppStyles.GrayStyle_Font16(context),
        ),
      ),
      SizeConfig.verticalSpaceSmall(),
      Padding(
        padding: SizeConfig.sidepadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DotWidget(
              totalWidth: SizeConfig.screenWidth*.3,
              dashWidth: 5,
              emptyWidth: 5,
              dashHeight: 1,
              dashColor: Theme.of(context).focusColor,
            ),
          ],
        ),
      ),
      SizeConfig.verticalSpaceSmall(),
      Padding(
        padding: SizeConfig.sidepadding,
        child: DeliveryInfoRowWidget(
          enablePadding: false,
          hasBorderColor: false,
          firstText: AppStrings.TOTAL_PAYMENT.tr(),
          firstTextStyle: AppStyles.BlackStyleWithBold600Font_16(context),
          secondText: '${AppStrings.euro+' '} ${NumberService.priceAfterConvert(50,context)}',
        ),
      ),
      SizeConfig.verticalSpaceSmall(),
      Padding(
        padding: SizeConfig.sidepadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(child: Text(AppStrings.SHOW_BILL.tr(),style: AppStyles.GreenStyle_Font20(context),),
            onTap: (){
              model.navigateToScreen(OrderDeliveredScreen.routeName,context,arguments: OrderDeliveredScreenArgument(
                orderOrPurchases: widget.orderOrPurchases,
                isPrePaid: false
              ));
            },)
          ],
        ),
      ),
      SizeConfig.CVerticalSpaceMedium(),
      Padding(
        padding: SizeConfig.sidepadding,
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            itemCount: model.paymentMethodList.length+1,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, int index) {
              if(index==model.paymentMethodList.length){
                return Padding(
                  padding: SizeConfig.smallerVerticalPadding3,
                  child: ButtonWidget(
                    buttonText: AppStrings.NEXT.tr(),
                    buttonColor: AppColors.green,
                    radius:AppConstants.button_Radius,
                    onPressed: (){
                     model.onClickNext();
                    },
                  ),
                );
              }

              return Padding(
                padding: SizeConfig.smallerVerticalPadding3,
                child: InkWell(
                  onTap: () async {
                    model.onClickPayment(model.paymentMethodList[index].title, context,
                        widget.orderOrPurchases);

                  },
                  child: Container(
                    child: Padding(
                      padding: SizeConfig.cmediumPadding,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppConstants.paymentIconBackgroundColor(context),
                                shape: BoxShape.circle
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ViewAppImage(
                                height: 22,
                                width: 22,
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
      SizeConfig.CVerticalSpaceBig()];
  }

}

class OrderAfterWardPaymentMethodScreenArgument{
  final OrderOrPurchases orderOrPurchases;

  OrderAfterWardPaymentMethodScreenArgument({this.orderOrPurchases});
}

