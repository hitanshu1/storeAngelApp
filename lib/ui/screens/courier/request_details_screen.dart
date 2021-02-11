import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/services/string_service.dart';
import 'package:storeangelApp/core/viewmodel/view_model_order_information.dart';
import 'package:storeangelApp/ui/shared/app_delevery_period_picker_tile_widget.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/custom_tile.dart';
import 'package:storeangelApp/ui/shared/text_field_increment_decrement_tile.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_request_details/request_details_order_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_request_details/request_item_list.dart';

import 'courier_main_page.dart';

class RequestDetailsScreen extends StatefulWidget {
  final OrderOrPurchases order;
  static const String routeName = 'RequestDetailsScreen';

  RequestDetailsScreen({this.order});

  @override
  _RequestDetailsScreenState createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  var radius = SizeConfig.radiusOfSliverAppbar;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController priceController = TextEditingController();
  TextEditingController myFeeController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.OffGray, context);
    final user=Provider.of<UserModel>(context);
    return BaseView<OrderInformationViewModel>(
      onModelReady: (model)=>model.initializeData(user.id),
      builder: (context, orderInformationViewModel, child) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).canvasColor,
          body: orderInformationViewModel.state==ViewState.Busy?AppConstants.circulerProgressIndicator():
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppHeader(
                  height: SizeConfig.smallHeaderSize,
                  isBack: true,
                  title: AppStrings.YOUR_CUSTOMER_REQUEST.tr(),

                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:SizeConfig.paddingWithHighVerticalSpace,
                  child: RequestDetailsOrderWidget(
                    order:widget.order,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CustomTile(
                  leadingText: AppStrings.DELIVERY_PERIOD.tr(),
                  tradingText: AppStrings.AS_SOON_AS_POSSIBLE.tr(),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: CustomTile(
                  leadingText:StringService.getBudgetName(widget.order.purchaseDetails).name+":",
                  tradingText: AppStrings.euroSymbol+NumberService.addAfterCommaTwoZeros(widget.order.orderAmount.toString(), context),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: CustomTile(
                  leadingText:AppStrings.TIME_OF_PAYMENT.tr(),
                  tradingText: widget.order.orderPayment,
                ),
              ),

              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: CustomTile(
                  leadingText:AppStrings.PUBLISHED_COMPLETED.tr(),
                  tradingText: '6/4',
                ),
              ),

              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: CustomTile(
                  leadingText:AppStrings.COMMENT.tr(),
                  subtitle: widget.order.comment,
                ),
              ),
              SizeConfig.verticalSliverMediumSpace(),
              CourierItemList(products: widget.order.purchaseDetails.products,),
              SizeConfig.verticalSliverMediumSpace(),

              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: AppDeliveryPeriodTileWidget(
                      title: AppStrings.DELIVERY_PERIOD.tr(),
                      hintText: AppStrings.SELECT_DELIVERY_TIME.tr(),
                  onChangeDateTime: (String period){
                        print(period);
                  },),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: TextFieldIncrementDecrementTile(
                    controller: myFeeController,
                    initialValue:orderInformationViewModel.userDetails.premium?99.99:10,
                    title: AppStrings.MY_FEE.tr(),
                  ),
                ),
              ),
              SizeConfig.verticalSliverBigSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: ButtonWidget(onPressed: (){
                    orderInformationViewModel.navigateToScreen(CourierMainAppScreen.routeName,
                    arguments: 1);

                  },buttonText: AppStrings.SEND_OFFER.tr(),
                    buttonColor: AppColors.primaryColor,),
                ),
              ),
              SizeConfig.verticalSliverMediumSpace(),

              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: Text(AppStrings.TRACK_THE_STATUS.tr(),
                  style: AppStyles.BlackStyleFont_20(context),textAlign: TextAlign.center,),
                ),
              ),
              SizeConfig.verticalSliverLargeSpace(),
            ],
          ),

        );
      },
    );
  }


}
