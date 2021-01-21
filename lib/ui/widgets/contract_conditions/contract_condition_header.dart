import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/string_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_contract_condition_viewmodel.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/widgets/store_details/delivery_status_widget.dart';

class ContractConditionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Consumer<ContractConditionViewModel>(
        builder: (context,model,child){
      return SliverToBoxAdapter(
        child: Stack(
          children: [
            SizeConfig.verticalSpace(SizeConfig.headerHeight+15),
            AppHeader(
              isBack: true,
              title:StringService.getConditionStatus(model.step)+' ${model.step}/3' ,
              style: AppStyles.WhiteStyle_WithBold700_Font20,
            ),
            Positioned.fill(child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: SizeConfig.sidepadding,
                child: SizedBox(
                  width: SizeConfig.smallImageheight+5,
                  child: DeliveryStatusWidget(
                    step: model.step,
                  ),
                ),
              ),
            ))
          ],
        ),
      );
    });
  }
}
