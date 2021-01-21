import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/ui/shared/custom_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/widgets/summery/estimate_budget_widget.dart';
class ConsumerOrderDetailsWidget extends StatelessWidget {
  final OrderOrPurchases orPurchases;
  final CourierCandidate candidate;
  final double additionalAmount;
  ConsumerOrderDetailsWidget({this.orPurchases,this.candidate,this.additionalAmount:0});

  double get totalPrice=>orPurchases.purchaseDetails.totalAmount+candidate.charge;
  @override
  Widget build(BuildContext context) {
    return MultiSliver(children: [
      additionalAmount>0?SliverToBoxAdapter(
        child: CustomTile(
          linearGradient: AppColors.redGradient,
          leadingStyle: AppStyles.WhiteStyle_WithBold900_Font20,
          tradingStyle: AppStyles.WhiteStyle_WithBold900_Font20.copyWith(fontStyle: FontStyle.italic),
          leadingText: AppStrings.ADDITIONAL_PAYMENT_REQUIRED.tr(),
          tradingText: AppStrings.euroSymbol+NumberService.priceAfterConvert(additionalAmount, context),
        ),
      ):SliverToBoxAdapter(),
      SizeConfig.verticalSliverSmallSpace(),
      SliverToBoxAdapter(
        child: CustomTile(
          isFixLeading: true,
          leadingText: AppStrings.DELIVERY_PERIOD.tr(),
          leadingStyle: AppStyles.BlackStyleFont_20(context),
          tradingText: AppStrings.AS_SOON_AS_POSSIBLE.tr(),
        ),
      ),
      SizeConfig.verticalSliverSmallSpace(),

      SliverToBoxAdapter(
        child: CustomTile(
          isFixLeading: true,
          leadingText: AppStrings.DELIVERY_ADDRESSES.tr()+":",
          leadingStyle: AppStyles.BlackStyleFont_20(context),
          tradingText: orPurchases.clientDetails.twoLineAddressWithName,
        ),
      ),

      SizeConfig.verticalSliverSmallSpace(),
      SliverToBoxAdapter(
        child: CustomTile(
          isFixLeading: true,
          leadingText: AppStrings.DELIVERY.tr()+":",
          leadingStyle: AppStyles.BlackStyleFont_20(context),
          tradingText: AppStrings.DIRECT_HANDOVER.tr(),
        ),
      ),
      SizeConfig.verticalSliverSmallSpace(),
      SliverToBoxAdapter(
        child: CustomTile(
          isFixLeading: true,
          leadingText: AppStrings.PAYMENT_METHOD.tr()+":",
          leadingStyle: AppStyles.BlackStyleFont_20(context),
          tradingText: orPurchases.purchaseDetails.paymentOption.title,
        ),
      ),
      SizeConfig.verticalSliverSmallSpace(),
      EstimateBudgetWidget(products: orPurchases.purchaseDetails.products,),
      SizeConfig.verticalSliverSmallSpace(),
      SliverToBoxAdapter(
        child: CustomTile(
          isFixLeading: false,
          leadingText: AppStrings.PURCHASE_AMOUNT.tr()+":",
          tradingStyle: AppStyles.BlackStyleWithBold800ItalicFont20(context),
          tradingText: AppStrings.euroSymbol+NumberService.priceAfterConvert(orPurchases.purchaseDetails.totalAmount, context),
        ),
      ),
      SizeConfig.verticalSliverSmallSpace(),
      SliverToBoxAdapter(
        child: CustomTile(
          isFixLeading: false,
          leadingText: AppStrings.SUPPLIER_FEE.tr(),
          tradingStyle: AppStyles.BlackStyleWithBold800ItalicFont20(context),
          tradingText: AppStrings.euroSymbol+NumberService.priceAfterConvert(candidate.charge, context),
        ),
      ),
      SizeConfig.verticalSliverSmallSpace(),
      SliverToBoxAdapter(
        child: CustomTile(
          isFixLeading: false,
          linearGradient: AppColors.blackGradient,
          leadingText: AppStrings.TRANSFER_AMOUNT.tr()+":",
          leadingStyle: AppStyles.WhiteStyle_WithBold900_Font20,
          tradingStyle: AppStyles.WhiteStyle_WithBold900_Font20.copyWith(fontStyle: FontStyle.italic),
          tradingText:AppStrings.euroSymbol+ NumberService.priceAfterConvert(totalPrice, context),
        ),
      ),
      SizeConfig.verticalSliverSmallSpace(),
      SliverToBoxAdapter(
        child: CustomTile(
          isFixLeading: true,
          leadingStyle: AppStyles.BlackStyleFont_20(context),
          leadingText: AppStrings.COMMENT.tr()+":",
          subtitle: orPurchases.comment,
        ),
      ),
      SizeConfig.verticalSliverSmallSpace(),
      SliverToBoxAdapter(
        child: CustomTile(
          isFixLeading: true,
          leadingText: AppStrings.RELEASED.tr(),
          leadingStyle: AppStyles.BlackStyleFont_20(context),
          tradingText:DateService.getDateWithHourFormat(orPurchases.purchaseDetails.time.toIso8601String(), context),
        ),
      ),
      SizeConfig.verticalSliverSmallSpace(),
      SliverToBoxAdapter(
        child: CustomTile(
          isFixLeading: true,
          leadingStyle: AppStyles.BlackStyleFont_20(context),
          leadingText: AppStrings.ORDER_ID.tr()+':',
          tradingText: '345678',
        ),
      ),
      SizeConfig.verticalSliverMediumSpace(),



    ]);

  }
}
