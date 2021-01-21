import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_summary_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/consumer_payment_method_screen.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:storeangelApp/ui/widgets/order_details_and_chat/consumer_order_details_widget.dart';
import 'package:storeangelApp/ui/widgets/summery/store_candidate_tile_widget.dart';
import 'package:storeangelApp/ui/widgets/summery/summery_bottom_text.dart';

class SummeryScreenArgument{
  final OrderOrPurchases orPurchases;
  final CourierCandidate candidate;

  SummeryScreenArgument({this.orPurchases,this.candidate});

}

class SummeryScreen extends StatelessWidget {
  static const String routeName = 'summeryScreen';
  final SummeryScreenArgument argument;
  SummeryScreen({this.argument});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BaseView<SummaryViewModel>(
        onModelReady: (model)=>model.initializeData(argument.orPurchases, argument.candidate),
        builder: (context,summaryViewModel,child){
          if(summaryViewModel.state==ViewState.Busy){
            return AppConstants.circulerProgressIndicator();
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppHeader(
                  height: SizeConfig.smallHeaderSize,
                  isBack: true,
                  title: AppStrings.YOUR_MISSION.tr(),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding:SizeConfig.sidepadding,
                  child: StoreCandidateTileWidget(
                    orPurchases: argument.orPurchases,
                    candidate: argument.candidate,
                  ),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: TitleTextWidget(
                    title: AppStrings.SUMMARY.tr(),
                  ),
                ),
              ),
              ConsumerOrderDetailsWidget(orPurchases: argument.orPurchases,
                candidate: argument.candidate,),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: ButtonWidget(
                    buttonText: AppStrings.PLACE_THE_ORDER.tr(),
                    onPressed: (){
                      summaryViewModel.navigateToScreen(ConsumerPaymentMethodScreen.routeName,
                      arguments: ConsumerPaymentMethodScreenArguments(
                        candidate: argument.candidate,
                        orPurchases: argument.orPurchases
                      ));
                    },
                  ),
                ),
              ),
              SizeConfig.verticalSliverMediumSpace(),
              SummeryBottomTextWidget(),
              SizeConfig.verticalSliverMediumSpace(),




            ],
          );
        },
      ),
    );
  }
}
