import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_store_details.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:easy_localization/easy_localization.dart';
class StoreAddressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreDetailsViewModel>(
        builder: (context,model,child){
          return SliverToBoxAdapter(
            child: Padding(
              padding: SizeConfig.sidepadding,
              child: AppShapeItem(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).toggleableActiveColor
                  ),
                  child: Padding(
                    padding: SizeConfig.padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizeConfig.verticalSpaceSmall(),
                        Text(AppStrings.ADDRESS.tr(),
                          style: AppStyles.BlackStyleWithBold800Font_20(context),),
                        SizeConfig.verticalSpaceSmall(),
                        Text(model.currentStore.twoLineAddress,
                          style: AppStyles.BlackStyleFont16Light(context),),
                        SizeConfig.verticalSpaceSmall(),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
