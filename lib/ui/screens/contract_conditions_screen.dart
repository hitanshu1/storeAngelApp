import 'package:flutter/material.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_contract_condition_viewmodel.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/widgets/contract_conditions/check_the_prices_widget.dart';
import 'package:storeangelApp/ui/widgets/contract_conditions/contract_condition_header.dart';
import 'package:storeangelApp/ui/widgets/contract_conditions/sumary_widget.dart';
import 'package:storeangelApp/ui/widgets/contract_conditions/terms_of_engagement_widget.dart';


class  ContractConditionsScreen extends StatelessWidget {
  static const String routeName = 'contractConditions';
  final PurchaseDetails purchaseDetails;
  ContractConditionsScreen({this.purchaseDetails});

  Widget _body(int step){

    if(step==2){
      return CheckThePricesWidget();
    }else if(step==3){
      return SummaryWidget();
    }
    return TermsOfEngagementWidget();

  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BaseView<ContractConditionViewModel>(
        onModelReady: (model)=>model.initializeData(purchaseDetails),
        builder: (context,contractConditionViewModel,child){
          return CustomScrollView(
            slivers: [
              ContractConditionHeader(),
              _body(contractConditionViewModel.step),


            ],
          );
        },
      ),
    );
  }
}
