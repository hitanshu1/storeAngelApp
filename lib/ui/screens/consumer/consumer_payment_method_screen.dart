import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_consumer_payment_method.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:storeangelApp/ui/widgets/consumer_payment_method/payment_option_widget.dart';
import 'package:storeangelApp/ui/widgets/consumer_payment_method/store_and_candidate_details_widget.dart';

class ConsumerPaymentMethodScreenArguments{
  OrderOrPurchases orPurchases;
  CourierCandidate candidate;
  ConsumerPaymentMethodScreenArguments({this.candidate,this.orPurchases});
}

class ConsumerPaymentMethodScreen extends StatelessWidget {
  static const String routeName = 'consumerPaymentMethod';
  final ConsumerPaymentMethodScreenArguments arguments;
  ConsumerPaymentMethodScreen({this.arguments});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body:BaseView<ConsumerPaymentMethodViewModel>(
        onModelReady: (model)=>model.getPaymentMethods(),
        builder: (context,consumerPaymentMethodViewModel,child){
          if(consumerPaymentMethodViewModel.state==ViewState.Busy){
            return AppConstants.circulerProgressIndicator();
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppHeader(
                  isBack: true,height: SizeConfig.smallHeaderSize,
                  title: AppStrings.YOUR_MISSION.tr(),
                ),
              ),
              SizeConfig.verticalSliverMediumSpace(),

              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: StoreAndCandidateDetailsWidget(order: arguments.orPurchases,
                    candidate: arguments.candidate,),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: TitleTextWidget(
                    title: AppStrings.PAYMENT_METHOD.tr()+":",
                  ),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              PaymentOptionWidget(orPurchases: arguments.orPurchases,
               candidate: arguments.candidate,),




            ],
          );
        },
      ),
    );
  }
}
