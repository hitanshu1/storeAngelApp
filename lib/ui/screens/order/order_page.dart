
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/services/string_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_orderpage.dart';
import 'package:storeangelApp/ui/screens/consumer/mainApp_Screen.dart';
import 'package:storeangelApp/ui/screens/order/order_popup_details_widget.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/show_candidantes_list.dart';


class OrderPageScreen extends StatefulWidget {
  static const String routeName = 'orderPage';
  final PurchaseDetails purchaseDetails;

  OrderPageScreen({this.purchaseDetails});

  @override
  _OrderPageScreenState createState() => _OrderPageScreenState();
}

class _OrderPageScreenState extends State<OrderPageScreen> {
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
    if(!_isAppBarExpanded){
      StatusBarService.changeStatusBarColor(StatusBarType.OffGray, context);
    }else{
      StatusBarService.changeStatusBarColor(StatusBarType.Light, context);
    }
    return Scaffold(
      body: BaseView<OrderPageViewModel>(
        builder: (context,model,child){
          if(model.state==ViewState.Busy){
            return AppConstants.circulerProgressIndicator();
          }
          return WillPopScope(
            onWillPop: ()async{
              model.navigateToScreen(MainAppScreen.routeName, context);
              return true;
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                _expandingOrderSheet(context,model),
                _courierProposals(context)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _expandingOrderSheet(BuildContext context,OrderPageViewModel model){
    return CustomSliverAppBar(
        backgroundColor: Theme.of(context).cardColor,
        pinned: true,
        floating: false,
        leading: BackButton(
          color: Theme.of(context).iconTheme.color,
          onPressed: (){
            model.navigateToScreen(MainAppScreen.routeName, context);
          },
        ),
        title: Text(
          widget.purchaseDetails.listName,
          style: AppStyles.BlackStyleWithBold800Font_24(context),
        ),
//        automaticallyImplyLeading: false,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(90.0), child: _orderSheet(model)),

        centerTitle: true,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35))),
        );
  }

  Widget _courierProposals(BuildContext context){
    return BaseView<OrderPageViewModel>(
      builder: (context, model, child) {
        if (model.state == ViewState.Busy) {
          return AppConstants.circulerProgressIndicator();
        } else {
          return SliverPadding(
            padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .08),
            sliver: StreamBuilder<List<CourierCandidate>>(
              stream: model.getuserList(),
              builder: (context, snapshot) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index){
                          if (snapshot.hasData) {
                            if (snapshot.data.length == 0) {
                              return Stack(
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth,
                                    height: SizeConfig.screenHeight * .65,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: SizeConfig.screenWidth * .7,
                                            child: Text(
                                              AppStrings.YOUR_ORDER_WAS_SUCCESSFULLY_PUBLISHED.tr(),
                                              style: AppStyles.BlackStyleWithBold_FontC20(context),
                                              textAlign: TextAlign.center,
                                            )),
                                        SizeConfig.CVerticalSpacevEMedium(),
                                        SizedBox(
                                            width: SizeConfig.screenWidth * .77,
                                            child: Text(
                                              AppStrings.YOU_CAN_CLOSE_THE_APP.tr(),
                                              style: AppStyles.BlackStyleFontWeightSmall_24(context),
                                              textAlign: TextAlign.center,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        AppStrings.CANCEL.tr(),
                                        style: AppStyles.GreenStyleWithw500Font_24(context),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              if(index==0){
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizeConfig.CVerticalSpace60(),
                                    Text(AppStrings.WAITING_FOR_OFFERS_.tr(),
                                        style: AppStyles.BlackStyleFontWeightSmall_24(context), textAlign: TextAlign.center),
                                    SizeConfig.CVerticalSpacevEMedium(),
                                    Text(
                                      ' ${snapshot.data.length > 1 ? StringService.getCandidate(context.locale,snapshot.data.length) : StringService.getCandidate(context.locale,snapshot.data.length)}',
                                      style: AppStyles.BlackStyleWithBold_FontC20(context),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizeConfig.CVerticalSpacevEMedium(),
                                  ],
                                );
                              }
                              return ShowCandidatesList(
                                candidates: snapshot.data,
                                model: model,
                                purchaseDetails: widget.purchaseDetails,
                                index: index-1,
                              );
                            }
                          } else {
                            return AppConstants.circulerProgressIndicator();
                          }
                        },
                      childCount: snapshot.hasData?snapshot.data.length+1:1
                    ));
              }
            ),
          );
        }
      },
    );
  }

  Widget  _orderSheet(OrderPageViewModel model) => InkWell(
    onTap: (){
      MyUtils.showAppDialog(
        context: context,
        child: OrderPopUpDetailsWidget(orderOrPurchases: OrderOrPurchases(
          purchaseDetails: widget.purchaseDetails,
        ),)
      );
    },
    child: Stack(
      children: [
        Container(
          child: Column(
            children: [
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
                      ViewAppImage(
                        width: SizeConfig.smallImageHeight60,
                        height: SizeConfig.smallImageHeight60,
                        radius: 10,
                        imageUrl: widget.purchaseDetails.storeDetails.image,
                      ),
                      SizeConfig.horizontalSpaceSmall(),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      widget.purchaseDetails.storeDetails.name,
                                      style: AppStyles.BlackStyleWithBold800Font_24(context),
                                    )),
//                                Icon(StoreangelIcons.watchlist_tab,color: AppColors.green,size: SizeConfig.smallIconSize,),
//                                SizedBox(width: 3,),
//                                Text(
//                                  AppStrings.DETAILS.tr(),
//                                  style: AppStyles.GreenStyleWithBold800_Font20(context),
//                                )
                              ],
                            ),
                            SizeConfig.verticalSpaceSmall(),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          widget.purchaseDetails.storeDetails.street,
                                          style: AppStyles.GrayStyle_Font16(context),
                                        ),

                                        Text(
                                          widget.purchaseDetails.storeDetails.zipCity,
                                          style: AppStyles.GrayStyle_Font16(context),
                                        ),
                                      ],
                                    ),),
                                SizedBox(width: 8,),
                                Text(
                                  '${widget.purchaseDetails.quantity} ${AppStrings.ITEMS.tr()}',
                                  style: AppStyles.GreenStyleWithBold800_Font20(context),
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
      ],
    ),
  );
}
