import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/ui/shared/status_dot.dart';

class CourierOrderDetails extends StatelessWidget {
  final OrderOrPurchases order;
  final bool submitProposal;
  CourierOrderDetails({this.order,this.submitProposal:false});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppConstants.button_Radius)
      ),
      child: Padding(
        padding:SizeConfig.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeConfig.VerticalSpaceSmallMedium(),
            Row(
              children: [
                SizedBox(
                    width: SizeConfig.screenWidth*.45,
                    child: Row(
                      children: [
                        Expanded(child: Text(order.storeDetails.name,style: AppStyles.BlackStyleWithBold600Font_20(context),)),
                        Image.asset(AssetsPath.green_arrow),
                      ],
                    )),

                SizeConfig.horizontalSpaceSmall(),
                Expanded(child: Text(order.clientDetails.name,style: AppStyles.BlackStyleWithBold600Font_20(context)))

              ],

            ),
            SizeConfig.verticalSpaceSmall(),
            Row(
              children: [
                SizedBox(
                    width: SizeConfig.screenWidth*.45,
                    child: Text(order.storeDetails.street,style: AppStyles.GrayStyle_Font16(context),)),
                SizeConfig.horizontalSpaceSmall(),
                Expanded(
                  child: Text('Knesebeckstr.76',style: AppStyles.GrayStyle_Font16(context)),
                ),
              ],
            ),
            SizeConfig.CVerticalSpaceMedium(),
            Row(
              children: [
                SizedBox(
                    width: SizeConfig.screenWidth*.45,
                    child: Text('${order.purchaseDetails.products.length} ${AppStrings.ITEMS.tr()}',style: AppStyles.BlackStyleFont_16(context),)),
                Image.asset(AssetsPath.smallerAngelStroe),
                SizeConfig.horizontalSpaceSmall(),
                Text('300m',style: AppStyles.GreenStyleWith_Font16(context),)
              ],
            ),
            SizeConfig.CVerticalSpacevEMedium(),
            ListView.builder(padding: EdgeInsets.all(0),shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
                itemCount: order.purchaseDetails.products.length>7?7:order.purchaseDetails.products.length,
                itemBuilder: (context,int i){
                  return Container(
                    child: Padding(
                      padding: SizeConfig.smallVerticalPadding,
                      child: Row(
                        children: [
                          StatusDot(availableStatus: order.purchaseDetails.products[i].availableStatus,),
                          SizeConfig.horizontalSpaceSmall(),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: '${order.purchaseDetails.products[i].name} ',
                                style: AppStyles.BlackStyleWithBold800Font_12(context),
                              ),
                            ),
                          ),
                          order.purchaseDetails.products[i].quantity!=0?Text('${order.purchaseDetails.products[i].quantity}'):
                          Container()
                        ],
                      ),
                    ),
                  );
                }),
            SizeConfig.verticalSpaceSmall(),
            order.purchaseDetails.products.length>7?Text('+ ${AppStrings.AND.tr()} ${order.purchaseDetails.products.length-7} ${AppStrings.MORE.tr()}',
              style: AppStyles.GrayStyle_FontC12W600(context),):Container(),
            SizeConfig.CVerticalSpaceMedium(),
            Row(
              children: [
                Expanded(child: Text(AppStrings.PURCHASE_BUDGET.tr(),style: AppStyles.BlackStyleWithw500_FontC18(context),)),
                Text('${AppStrings.euro+' '}230,00',style: AppStyles.BlackStyleWithw500_FontC18(context))
              ],
            ),
            SizeConfig.verticalSpaceSmall(),
            Divider(
              color: AppColors.lightGreyColor,
            ),
            SizeConfig.verticalSpaceSmall(),
            submitProposal?Row(
              children: [
                Expanded(child: Text('10 minutes ago',style: AppStyles.GrayStyle_Font12(context),textAlign: TextAlign.right,)),
              ],
            ):Row(
              children: [
                Expanded(child: Text('5 minutes ago',style: AppStyles.GrayStyle_Font12(context),)),
                Expanded(child: Text('10 ${AppStrings.PROPOSALS.tr()}',style: AppStyles.GrayStyle_Font12(context))),
                Expanded(child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(AssetsPath.small_circuler_tick),
                    SizeConfig.horizontalSpaceSmall(),
                    Text(AppStrings.SUBMITTED.tr(),style: AppStyles.GreenStyle_FontW50014(context),)
                  ],
                )),
              ],
            ),
            SizeConfig.verticalSpaceSmall(),

          ],
        ),
      ),
    );
  }
}
