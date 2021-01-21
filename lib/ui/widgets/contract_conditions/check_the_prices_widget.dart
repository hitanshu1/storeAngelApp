import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_contract_condition_viewmodel.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/widgets/contract_conditions/your_budget_widget.dart';
import 'package:storeangelApp/ui/widgets/contract_conditions/your_price_information_widget.dart';

class CheckThePricesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContractConditionViewModel>(
        builder: (context,model,child){
          return MultiSliver(children: [
            YourPriceInformationWidget(enableTextField: true,),
            SizeConfig.verticalSliverSmallSpace(),
            YourBudgetWidget(products: model.purchaseDetails.products,),
            SizeConfig.verticalSliverSmallSpace(),
            SliverToBoxAdapter(
              child: Padding(
                padding: SizeConfig.sidepadding,
                child: ButtonWidget(
                  buttonText: AppStrings.CONTINUE.tr(),
                  onPressed: (){
                    model.onChangeStep(3);
                  },
                ),
              ),
            ),
            SizeConfig.verticalSliverSmallSpace(),


          ]);
        });
  }
}
