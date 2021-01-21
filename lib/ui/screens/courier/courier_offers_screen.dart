import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_offers.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_offers/active_offer_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_offers/decline_offer_widget.dart';
import 'package:storeangelApp/ui/widgets/courier/single_offer_screen.dart';
class CourierOfferScreen extends StatefulWidget {

  @override
  _CourierOfferScreenState createState() => _CourierOfferScreenState();
}

class _CourierOfferScreenState extends State<CourierOfferScreen> {
  final ScrollController _scrollController = ScrollController();
  
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseView<CourierOffersViewModel>(
      onModelReady: (courierOffersViewModel)=>courierOffersViewModel.initialize(_scrollController),
      builder: (context,courierOffersViewModel,child){
        if(courierOffersViewModel.state==ViewState.Busy){
          return CustomScaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: AppConstants.circulerProgressIndicator());
        }else{
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppHeader(
                  height: SizeConfig.smallHeaderSize  ,
                  title: AppStrings.YOUR_OFFERS.tr(),
                  actions: [
                    InkWell(child:
                    Icon(Icons.add,color: AppColors.whiteColor,),
                        onTap: (){
                      
                    })
                  ],
                ),
              ),
              SizeConfig.verticalSliverMediumSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: TitleTextWidget(title: AppStrings.ACTIVE_OFFERS.tr()),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, int index) {

                      return Padding(
                        padding: SizeConfig.sidepadding,
                        child: InkWell(
                          child: ActiveOfferWidget(
                            order: courierOffersViewModel.offerOrders[index],
                          ),
                          onTap: ()async{
                            courierOffersViewModel.navigateTo(SingleOfferScreen.routeName, courierOffersViewModel.offerOrders[index], context);

                          },
                        ),
                      );
                    },
                    childCount: courierOffersViewModel.offerOrders.length,
                  )),
              SizeConfig.verticalSliverMediumSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: TitleTextWidget(title: AppStrings.DECLINED_OFFERS.tr()),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, int index) {

                      return Padding(
                        padding: SizeConfig.sidepadding,
                        child: InkWell(
                          child: DeclineOfferWidget(
                            order: courierOffersViewModel.declineOffers[index],
                          ),
                          onTap: ()async{

                          },
                        ),
                      );
                    },
                    childCount: courierOffersViewModel.offerOrders.length,
                  )),
            ],
          );

        }
      },
    );
  }

}
