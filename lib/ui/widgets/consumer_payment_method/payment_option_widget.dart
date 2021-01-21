import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_consumer_payment_method.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class PaymentOptionWidget extends StatelessWidget {
  final OrderOrPurchases orPurchases;
  final CourierCandidate candidate;
  PaymentOptionWidget({this.orPurchases,this.candidate});
  @override
  Widget build(BuildContext context) {
    return Consumer<ConsumerPaymentMethodViewModel>(
        builder: (context,model,child){
          return  SliverList(
            delegate: SliverChildListDelegate(
              [
                ..._paymentOptions(context, model),
              ],
            ),
          );
        });
  }

  List<Widget> _paymentOptions(BuildContext context, ConsumerPaymentMethodViewModel model) {
    return [
      SizeConfig.CVerticalSpaceSmallMedium(),
      Padding(
        padding: SizeConfig.sidepadding,
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            itemCount: model.paymentMethodList.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, int index) {
              return Padding(
                padding: SizeConfig.smallerVerticalPadding3,
                child: InkWell(
                  onTap: () async {
                    model.onClickPayment(
                        model.paymentMethodList[index].title, context, orPurchases,candidate);
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.cmediumPadding.left,
                          right: SizeConfig.cmediumPadding.right,
                          top: SizeConfig.cmediumPadding.top - 5,
                          bottom: SizeConfig.cmediumPadding.bottom - 5),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppConstants.paymentIconBackgroundColor(context), shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ViewAppImage(
                                height: 22,
                                width: 25,
                                radius: 5,
                                boxFit: BoxFit.contain,
                                assetUrl: model.paymentMethodList[index].imageUrl,
                              ),
                            ),
                          ),
                          SizeConfig.horizontalSpaceMedium(),
                          Text(
                            model.paymentMethodList[index].title,
                            style: AppStyles.BlackStyleFont_c16(context),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(AppConstants.button_Radius)),
                  ),
                ),
              );
            }),
      ),
      SizeConfig.CVerticalSpaceBig()
    ];
  }
}
