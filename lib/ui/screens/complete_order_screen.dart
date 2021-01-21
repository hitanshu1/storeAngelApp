import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_complete_order_screen.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/collapased_order_info_widget.dart';

class CompleteOrderScreen extends StatefulWidget {
  static const String routeName = 'completeOrderScreen';
  final OrderOrPurchases  orderOrPurchases;

  CompleteOrderScreen({this.orderOrPurchases});

  @override
  _CompleteOrderScreenState createState() => _CompleteOrderScreenState();
}

class _CompleteOrderScreenState extends State<CompleteOrderScreen> {
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
    final theme=Theme.of(context);
    return BaseView<CompleteOrderViewModel>(
      builder: (context,model,child){
        return Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              CustomSliverAppBar(
                  backgroundColor: theme.backgroundColor,
                  pinned: true,
                  floating: false,
                  automaticallyImplyLeading: true,
                  centerTitle: true,
                  leading:  IconButton(icon:  Icon(Icons.arrow_back_ios,
                    color: Theme.of(context).focusColor,),
                      onPressed: (){
                        Navigator.pop(context);
                      }),
                  title: Text(AppStrings.PAST_ORDER.tr(),
                    style: AppStyles.BlackStyleWithBold800Font_24(context),),
                  shape: ContinuousRectangleBorder(
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      child: Column(
                        children: [
                          SizeConfig.VerticalSpaceExtraLarge(),
                          Text(
                            AppStrings.AS_SOON_AS_POSSIBLE.tr(),
                            style: AppStyles.BlackStyleFont_16(context),
                          ),
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: Padding(
                              padding: SizeConfig.mediumPadding,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    child: ViewAppImage(
                                      width: SizeConfig.smallImageHeight60,
                                      height: SizeConfig.smallImageHeight60,
                                      radius: 10,
                                      imageUrl: widget.orderOrPurchases.purchaseDetails.storeDetails.image,
                                    ),
                                    onTap: () {},
                                  ),
                                  SizeConfig.horizontalSpaceSmall(),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  widget.orderOrPurchases.purchaseDetails.storeDetails.name,
                                                  style: AppStyles.BlackStyleWithBold800Font_24(context),
                                                )),
                                            Text(
                                              AppStrings.DETAILS.tr(),
                                              style: AppStyles.BlackStyleWithBold600Font_20(context),
                                            )
                                          ],
                                        ),
                                        SizeConfig.verticalSpaceSmall(),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  widget.orderOrPurchases.purchaseDetails.storeDetails.street,
                                                  style: AppStyles.GrayStyle_Font16(context),
                                                )),
                                            Text(
                                              '${widget.orderOrPurchases.purchaseDetails.quantity} ${AppStrings.ITEMS.tr()}',
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  expandedHeight: 170),
              SliverPadding(
                padding:  EdgeInsets.only(bottom: SizeConfig.screenHeight*.1),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      CollapsedOrderInfoWidget(
                        model: model,
                        orderOrPurchases: widget.orderOrPurchases,
                        storeDetailsVisible: false,
                      )
                    ])),
              )
            ],
          ),
        );
      },
    );
  }
}
