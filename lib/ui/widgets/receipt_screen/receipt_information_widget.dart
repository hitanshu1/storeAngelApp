import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/participant.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/ui/widgets/orderDelivered/order_delivered_info_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/widgets/watchlist/dashline_widget.dart';

class ReceiptInformationWidget extends StatelessWidget {
  final Participant participant;
  ReceiptInformationWidget({this.participant});
 final  String _fontFamily = 'PTMono';


  Widget orderPriceAndQuantityWidget({String firstText, String secondText, String thirdText}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 3),
          child: OrderDeliveredInfoRowWidget(
            firstText: firstText,
            secondText: secondText,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.largeSidepadding.left, top: 3),
          child: Row(
            children: [
              Text(
                thirdText,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConfig.padding,
      child: Column(
        children: [
          SizeConfig.verticalSpaceMedium(),
          OrderDeliveredInfoRowWidget(
              firstText: AppStrings.COURIER.tr(),
              secondText:participant.clientDetails.name),
          OrderDeliveredInfoRowWidget(
              firstText: AppStrings.TAX_ID.tr(), secondText: '234002342343'),
          OrderDeliveredInfoRowWidget(
              firstText: AppStrings.ADDRESS.tr(),
              secondText: participant.clientDetails.city),
          SizeConfig.CVerticalSpacevEMedium(),
          Center(
              child: Text(
                'REWE',
                style: AppStyles.BlackStyleWithBold700_Font40(context),
              )),
          SizeConfig.CVerticalSpaceMedium(),
          Center(
            child: Text(
              '${participant.clientDetails.address}',
              style: AppStyles.BlackStyleFont_20(context).copyWith(fontFamily: _fontFamily),
            ),
          ),
          Center(
            child: Text(
              participant.clientDetails.zip,
              style: AppStyles.BlackStyleFont_20(context).copyWith(fontFamily: _fontFamily),
            ),
          ),
          SizeConfig.CVerticalSpacevEMedium(),
          Center(
              child: Text(
                AppStrings.RECEIPT_COPY.tr(),
                style:
                AppStyles.BlackStyleWithBold_Font36(context).copyWith(fontFamily: _fontFamily),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text(AppStrings.EURO.tr())],
          ),
          SizeConfig.verticalSpaceSmall(),
          ListView.builder(itemCount: participant.products.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,int index){
            return orderPriceAndQuantityWidget(
                firstText: participant.products[index].name,
                secondText:
                '${NumberService.priceAfterConvert(participant.products[index].quantity * participant.products[index].price,context)} A',
                thirdText:
                '${participant.products[index].quantity} x ${NumberService.priceAfterConvert(participant.products[index].price,context)}');
          }),
          SizeConfig.verticalSpaceMedium(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DotWidget(
                dashColor: AppColors.darkGrayColor,
                dashHeight: 1,
                dashWidth: AppConstants.dash_width,
                emptyWidth: AppConstants.empty_width,
                totalWidth: SizeConfig.screenWidth * .3,
              ),
            ],
          ),
          SizeConfig.verticalSpaceSmall(),
          OrderDeliveredInfoRowWidget(
            firstText: AppStrings.PURCHASE_TOTAL.tr(),
            secondText: '40,97',
            firstTextStyle:
            AppStyles.BlackStyleWithBold_Font36(context).copyWith(fontFamily: _fontFamily),
            secondTextStyle:
            AppStyles.BlackStyleWithBold_Font36(context).copyWith(fontFamily: _fontFamily),
          ),
          SizeConfig.verticalSpaceSmall(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DotWidget(
                dashColor: AppColors.darkGrayColor,
                dashHeight: 1,
                dashWidth: AppConstants.dash_width,
                emptyWidth: AppConstants.empty_width,
                totalWidth: SizeConfig.screenWidth * .3,
              ),
            ],
          ),
          SizeConfig.verticalSpaceSmall(),
          Text('${participant.products.length} ' + AppStrings.ARTICLES.tr()),
          SizeConfig.verticalSpaceMedium(),
          OrderDeliveredInfoRowWidget(
            firstText: AppStrings.BUDGET.tr(),
            secondText: '70,00',
          ),
          SizeConfig.verticalSpaceVerySmall(),
          OrderDeliveredInfoRowWidget(
            firstText: AppStrings.CREDIT_CARD.tr(),
            secondText: '40,97',
          ),
          SizeConfig.verticalSpaceVerySmall(),
          OrderDeliveredInfoRowWidget(
            firstText: AppStrings.FEE.tr(),
            secondText: '9,99',
          ),
          SizeConfig.verticalSpaceSmall(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DotWidget(
                dashColor: AppColors.darkGrayColor,
                dashHeight: 1,
                dashWidth: AppConstants.dash_width,
                emptyWidth: AppConstants.empty_width,
                totalWidth: SizeConfig.screenWidth * .3,
              ),
            ],
          ),
          SizeConfig.verticalSpaceSmall(),
        OrderDeliveredInfoRowWidget(
            firstText: AppStrings.PAY_BACK_AMOUNT.tr(),
            secondText: '19,96',
            firstTextStyle: AppStyles.BlackStyleWithBold_Font36(context)
                .copyWith(fontFamily: _fontFamily),
            secondTextStyle: AppStyles.BlackStyleWithBold_Font36(context)
                .copyWith(fontFamily: _fontFamily),
          ),
          SizeConfig.verticalSpaceSmall(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DotWidget(
                dashColor: AppColors.darkGrayColor,
                dashHeight: 1,
                dashWidth: AppConstants.dash_width,
                emptyWidth: AppConstants.empty_width,
                totalWidth: SizeConfig.screenWidth * .3,
              ),
            ],
          ),
          SizeConfig.verticalSpaceVerySmall(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DotWidget(
                dashColor: AppColors.darkGrayColor,
                dashHeight: 1,
                dashWidth: AppConstants.dash_width,
                emptyWidth: AppConstants.empty_width,
                totalWidth: SizeConfig.screenWidth * .3,
              ),
            ],
          ),
          SizeConfig.verticalSpaceMedium(),
          OrderDeliveredInfoRowWidget(
            firstText: AppStrings.DELIVERY_DATE.tr(),
            secondText: DateService.getDateWithHourFormat(DateTime.now().toIso8601String(),context),
          ),
          OrderDeliveredInfoRowWidget(
            firstText: AppStrings.DELIVERY_CITY.tr(),
            secondText: participant.clientDetails.city,
          ),
          OrderDeliveredInfoRowWidget(
            firstText: AppStrings.DELIVERY_STREET.tr(),
            secondText: participant.clientDetails.street,
          ),
          OrderDeliveredInfoRowWidget(
            firstText: AppStrings.POSTED.tr(),
            secondText: DateService.getDateWithHourFormat(DateTime.now().toIso8601String(),context),
          ),
          OrderDeliveredInfoRowWidget(
            firstText: AppStrings.ORDER_ID.tr(),
            secondText: '542342123',
          ),
          SizeConfig.verticalSpaceMedium(),
          SizedBox(
            width: SizeConfig.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.THANK_YOU.tr(),
                  style: AppStyles.BlackStyleFont_16(context),
                ),
                Text(AppStrings.FOR_YOUR_PURCHASE.tr(),
                    style: AppStyles.BlackStyleFont_16(context)),
                Text(AppStrings.WITH_STOREANGEL.tr(),
                    style: AppStyles.BlackStyleFont_16(context))
              ],
            ),
          ),
          SizeConfig.verticalSpaceBig(),
        ],
      ),
    );
  }
}
